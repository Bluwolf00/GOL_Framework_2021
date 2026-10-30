@echo off
REM run_update.bat  (Framework 4)
REM This batch file runs the modular PowerShell update system and waits for a keypress after.

powershell -NoProfile -ExecutionPolicy Bypass -File ".\v4\Master-Update.ps1"

echo.
echo Press any key to exit...
pause >nul
