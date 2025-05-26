@echo off

:: Check for admin privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo Please run this script as Administrator.
    timeout /t 5
    exit /b
)

:: Remove registry value
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul

:: Optionally delete the icon file
del /f /q "%SystemRoot%\System32\blank.ico" >nul

echo Removed. Restart Explorer or restart your PC to see changes.
pause
