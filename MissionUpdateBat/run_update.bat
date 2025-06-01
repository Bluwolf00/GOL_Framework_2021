@echo off
REM run_update.bat
REM This batch file runs the PowerShell script and waits for a keypress after.

powershell -NoProfile -ExecutionPolicy Bypass -File replace_script.ps1

echo.
echo Press any key to exit...
pause >nul
