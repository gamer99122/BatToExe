@echo off

rem ==============================
rem  Set your file paths below
rem ==============================

set BAT=E:\Path\To\your_script.bat
set PNG=E:\Path\To\your_icon.png

rem  No icon needed? Change the line above to:
rem  set PNG=

rem ==============================

if not exist "%BAT%" (
    echo Cannot find bat file: %BAT%
    pause
    exit /b 1
)

if "%PNG%"=="" (
    powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Bat "%BAT%"
) else if not exist "%PNG%" (
    echo Cannot find png file: %PNG%
    pause
    exit /b 1
) else (
    powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Bat "%BAT%" -Png "%PNG%"
)

pause