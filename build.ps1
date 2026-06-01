param(
    [Parameter(Mandatory)][string]$Bat,
    [string]$Ico,
    [string]$Out
)

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

# Compile
$outPath = Join-Path (Split-Path $batPath) $Out
if ($Ico -and (Test-Path $Ico)) {
    $icoPath = (Get-Item $Ico).FullName
    & $csc /out:"$outPath" /win32icon:"$icoPath" "$tmpCs"
} else {
    & $csc /out:"$outPath" "$tmpCs"
}

Remove-Item $tmpCs

if ($LASTEXITCODE -eq 0) {
    Write-Host "Done! Output: $outPath"
} else {
    Write-Error "Compile failed"
}
