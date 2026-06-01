@echo off

rem ==============================
rem  Set your file paths below
rem ==============================

set BAT=E:\Path\To\your_script.bat
set ICO=E:\Path\To\your_icon.ico

rem  No icon needed? Change the line above to:
rem  set ICO=

rem ==============================

if not exist "%BAT%" (
    echo Cannot find bat file: %BAT%
    pause
    exit /b 1
)

if "%ICO%"=="" (
    powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Bat "%BAT%"
) else if not exist "%ICO%" (
    echo Cannot find ico file: %ICO%
    pause
    exit /b 1
) else (
    powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Bat "%BAT%" -Ico "%ICO%"
)

pause