@echo off

:: Run as Administrator to be able to copy icon and edit registery

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo Please run this script as Administrator.
    timeout /t 5
    exit /b
)

:: Set variables
set ICON_SRC=blank.ico
set ICON_DST=%SystemRoot%\System32\blank.ico
set REG_PATH="HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons"
set REG_VALUE=29
set REG_DATA=%%windir%%\\System32\\blank.ico,0

:: Copy icon file to System32
copy /Y "%~dp0%ICON_SRC%" "%ICON_DST%" >nul

:: Add registry key and value
reg add %REG_PATH% /f >nul
reg add %REG_PATH% /v %REG_VALUE% /t REG_SZ /d "%REG_DATA%" /f >nul

:: Done
echo Done. Restart Explorer or restart your PC to see changes.
pause
