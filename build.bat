@echo off
if "%~1"=="" (
    echo Usage: build.bat ^<bat-file^> [ico-file]
    echo.
    echo   bat-file   Path to your .bat script ^(required^)
    echo   ico-file   Path to your .ico icon   ^(optional^)
    exit /b 1
)

if "%~2"=="" (
    powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Bat "%~1"
) else (
    powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Bat "%~1" -Ico "%~2"
)
