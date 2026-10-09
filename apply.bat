@echo off

:: Removes the arrow from shortcut icons by pointing the shortcut overlay
:: to the blank icon built into Windows (imageres.dll, index 197).
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
set "REG_DATA=%SystemRoot%\System32\imageres.dll,197"

:: Add registry value
reg add "%REG_PATH%" /v %REG_VALUE% /t REG_SZ /d "%REG_DATA%" /f >nul
if %errorlevel% NEQ 0 (
    echo Failed to write the registry value.
    pause
    exit /b 1
)

:: Clear icon cache and restart Explorer
taskkill /f /im explorer.exe >nul 2>&1
del /a /q "%localappdata%\IconCache.db" >nul 2>&1
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1
start explorer.exe

:: Done
echo Done. Shortcut arrows are removed. If any icon still shows the arrow, restart your PC.
pause
