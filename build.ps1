# 自動找 csc.exe (Windows 內建 .NET Framework 編譯器)
$csc = Get-ChildItem "C:\Windows\Microsoft.NET\Framework64" -Filter "csc.exe" -Recurse |
       Sort-Object FullName -Descending |
       Select-Object -First 1 -ExpandProperty FullName

if (-not $csc) {
    Write-Error "找不到 csc.exe，請確認已安裝 .NET Framework"
    exit 1
}

Write-Host "使用編譯器: $csc"

# 有 icon.ico 就加入，沒有就略過
if (Test-Path ".\icon.ico") {
    & $csc /out:restart_explorer.exe /win32icon:icon.ico launcher.cs
} else {
    Write-Host "未找到 icon.ico，將不加入 icon"
    & $csc /out:restart_explorer.exe launcher.cs
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "編譯成功！輸出：restart_explorer.exe"
} else {
    Write-Error "編譯失敗"
}
