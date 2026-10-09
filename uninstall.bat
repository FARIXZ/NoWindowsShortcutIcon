@echo off

:: Restores the default shortcut arrow by deleting the custom overlay value.
:: Run as Administrator to be able to edit the registry.

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo Please run this script as Administrator.
    timeout /t 5
    exit /b
)

:: Set variables
set "REG_PATH=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons"
set "REG_VALUE=29"

:: Delete registry value if it exists
reg query "%REG_PATH%" /v %REG_VALUE% >nul 2>&1
if %errorlevel% EQU 0 (
    reg delete "%REG_PATH%" /v %REG_VALUE% /f >nul
) else (
    echo The custom shortcut icon value was not set, nothing to remove.
)

:: Clear icon cache and restart Explorer
taskkill /f /im explorer.exe >nul 2>&1
del /a /q "%localappdata%\IconCache.db" >nul 2>&1
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1
start explorer.exe

:: Done
echo Done. Default shortcut arrows are restored. If any icon still looks wrong, restart your PC.
pause
