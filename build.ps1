param(
    [string]$Bat,
    [string]$Png,
    [string]$Out,
    [string]$Config
)

# Read config.txt if provided
if ($Config -and (Test-Path $Config)) {
    Get-Content $Config | ForEach-Object {
        if ($_ -match '^BAT=(.+)$' -and -not $Bat) { $Bat = $Matches[1].Trim() }
        if ($_ -match '^PNG=(.+)$' -and -not $Png) { $Png = $Matches[1].Trim() }
    }
}

if (-not $Bat) { Write-Error "BAT path is not set. Please fill in config.txt."; exit 1 }

# Resolve bat path
if (-not (Test-Path $Bat)) { Write-Error "Cannot find bat file: $Bat"; exit 1 }
$batPath = (Get-Item $Bat).FullName

# Default output name from bat filename
if (-not $Out) {
    $Out = [System.IO.Path]::GetFileNameWithoutExtension($batPath) + ".exe"
}

# Read bat content and escape for C# verbatim string
$batContent = [System.IO.File]::ReadAllText($batPath) -replace '"', '""'

# Generate C# source with embedded bat content
$cs = @"
using System;
using System.Diagnostics;
using System.IO;
using System.Security.Principal;

class Program {
    static void Main() {
        if (!IsAdmin()) {
            Process.Start(new ProcessStartInfo(
                System.Reflection.Assembly.GetExecutingAssembly().Location) {
                Verb = "runas",
                UseShellExecute = true
            });
            return;
        }

        string bat = Path.Combine(Path.GetTempPath(), Path.GetRandomFileName() + ".bat");
        File.WriteAllText(bat, @"$batContent");
        try {
            Process.Start(new ProcessStartInfo("cmd.exe", "/c \"" + bat + "\"") {
                UseShellExecute = true
            }).WaitForExit();
        } finally {
            if (File.Exists(bat)) File.Delete(bat);
        }
    }

    static bool IsAdmin() {
        WindowsIdentity id = WindowsIdentity.GetCurrent();
        return new WindowsPrincipal(id).IsInRole(WindowsBuiltInRole.Administrator);
    }
}
"@

$tmpCs = [System.IO.Path]::Combine($PSScriptRoot, "_tmp_launcher.cs")
[System.IO.File]::WriteAllText($tmpCs, $cs)

# Find csc.exe
$csc = Get-ChildItem "C:\Windows\Microsoft.NET\Framework64" -Filter "csc.exe" -Recurse |
       Sort-Object FullName -Descending | Select-Object -First 1 -ExpandProperty FullName

if (-not $csc) { Write-Error "找不到 csc.exe"; Remove-Item $tmpCs; exit 1 }

# Convert PNG to ICO if provided
$tmpIco = $null
if ($Png -and (Test-Path $Png)) {
    $pngPath = (Get-Item $Png).FullName
    $tmpIco = [System.IO.Path]::Combine($PSScriptRoot, "_tmp_icon.ico")
    Add-Type -AssemblyName System.Drawing
    $src = [System.Drawing.Image]::FromFile($pngPath)
    $sizes = @(256, 48, 32, 16)
    $ms = New-Object System.IO.MemoryStream
    $bw = New-Object System.IO.BinaryWriter($ms)
    $bw.Write([uint16]0); $bw.Write([uint16]1); $bw.Write([uint16]$sizes.Count)
    $imageDataList = @()
    foreach ($size in $sizes) {
        $bmp = New-Object System.Drawing.Bitmap($size, $size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.Clear([System.Drawing.Color]::Transparent)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $g.DrawImage($src, 0, 0, $size, $size); $g.Dispose()
        $imgMs = New-Object System.IO.MemoryStream
        $bmp.Save($imgMs, [System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
        $imageDataList += ,$imgMs.ToArray(); $imgMs.Dispose()
    }
    $offset = 6 + $sizes.Count * 16
    foreach ($i in 0..($sizes.Count - 1)) {
        $size = $sizes[$i]; $data = $imageDataList[$i]
        $w = if ($size -eq 256) { 0 } else { $size }
        $h = if ($size -eq 256) { 0 } else { $size }
        $bw.Write([byte]$w); $bw.Write([byte]$h); $bw.Write([byte]0); $bw.Write([byte]0)
        $bw.Write([uint16]1); $bw.Write([uint16]32); $bw.Write([uint32]$data.Length); $bw.Write([uint32]$offset)
        $offset += $data.Length
    }
    foreach ($data in $imageDataList) { $bw.Write($data) }
    $bw.Flush()
    [System.IO.File]::WriteAllBytes($tmpIco, $ms.ToArray())
    $src.Dispose()
}

# Compile
$outPath = Join-Path (Split-Path $batPath) $Out
if ($tmpIco) {
    & $csc /out:"$outPath" /win32icon:"$tmpIco" "$tmpCs"
} else {
    & $csc /out:"$outPath" "$tmpCs"
}

Remove-Item $tmpCs
if ($tmpIco) { Remove-Item $tmpIco }

if ($LASTEXITCODE -eq 0) {
    Write-Host "Done! Output: $outPath"
} else {
    Write-Error "Compile failed"
}
