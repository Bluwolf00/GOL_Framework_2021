@echo off
REM run_update.bat
REM This batch file runs the modular PowerShell update system and waits for a keypress after.

powershell -NoProfile -ExecutionPolicy Bypass -File ".\Master-Update.ps1"

echo.
echo Press any key to exit...
pause >nul
