@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1" -Config "%~dp0config.txt"
pause