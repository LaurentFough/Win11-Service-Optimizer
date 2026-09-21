@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

REM 🧹 Win11 Service Optimizer - Automated Setup
REM This script sets up everything needed for one-click optimization

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "TARGET=%SCRIPT_DIR%\win11-service-optimize-now.bat"
set "PS_SCRIPT=%SCRIPT_DIR%\win11-service-service-disable.ps1"
set "SHORTCUT=%USERPROFILE%\Desktop\Win11 Service Optimizer.lnk"

if not exist "%TARGET%" (
    echo ❌ Missing launcher: "%TARGET%"
    echo.
    echo Please make sure win11-service-optimize-now.bat is present in the same folder as this setup script.
    echo.
    pause
    exit /b 1
)

if not exist "%PS_SCRIPT%" (
    echo ❌ Missing PowerShell optimizer: "%PS_SCRIPT%"
    echo.
    echo Please make sure win11-service-service-disable.ps1 is present in the same folder as this setup script.
    echo.
    pause
    exit /b 1
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║            🧹 Win11 Service Optimizer Setup                  ║
echo ║                 🚀 Automated Installation                    ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Administrator privileges confirmed
) else (
    echo ❌ Setup requires Administrator privileges!
    echo.
    echo Right-click this file and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

echo.
echo 🔧 Step 1: Setting up PowerShell execution policy for this process...
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -Scope Process Bypass -Force" >nul 2>&1
if errorlevel 1 (
    echo ⚠️ PowerShell policy change returned a non-zero exit code, but setup will continue
) else (
    echo ✅ PowerShell execution policy configured for this session
)

echo.
echo 📦 Step 2: Creating desktop shortcut...

REM Create shortcut using PowerShell
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); $Shortcut.TargetPath = '%TARGET%'; $Shortcut.WorkingDirectory = '%SCRIPT_DIR%'; $Shortcut.IconLocation = 'powershell.exe,0'; $Shortcut.Description = 'Windows 11 Service Optimizer - One-Click Performance Boost'; $Shortcut.Save()"

if exist "%SHORTCUT%" (
    echo ✅ Desktop shortcut created
) else (
    echo ❌ Desktop shortcut creation failed
    echo.
    echo Please check whether the Desktop folder is accessible and try again.
    echo.
    pause
    exit /b 1
)

echo.
echo 🚀 Step 3: Verifying optimizer files...
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "if (Test-Path '%TARGET%') { Write-Host '✅ Launcher detected' -ForegroundColor Green } else { throw 'Missing launcher' }; if (Test-Path '%PS_SCRIPT%') { Write-Host '✅ PowerShell script detected' -ForegroundColor Green } else { throw 'Missing optimizer script' }"
if errorlevel 1 (
    echo ❌ File verification failed.
    echo.
    pause
    exit /b 1
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                    📋 Setup Complete!                        ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo 🎉 Win11 Service Optimizer is now ready to use!
echo.
echo 📁 WHAT WAS INSTALLED:
echo   ✅ PowerShell execution policy configured for this session
echo   ✅ Desktop shortcut created
echo   ✅ One-click optimization ready
echo.
echo 🚀 HOW TO USE:
echo   1. Double-click the 'Win11 Service Optimizer' icon on your desktop
echo   2. The optimization will run automatically
echo   3. Restart your computer when prompted
echo.
echo 🔧 ADVANCED USAGE:
echo   • Run 'win11-service-optimize-now.bat' directly from this folder
echo   • Disable Services (PowerShell): .\win11-service-disable.ps1
echo   • Undo Last Run    (PowerShell): .\win11-service-undo-last-run.ps1
echo.
echo Press any key to exit setup...
pause >nul

REM Optional: Ask if user wants to run service optimization now
echo.
echo Would you like to run the service optimization now? (Y/N)
set /p "run_now="
if /i "%run_now%"=="Y" (
    if exist "%TARGET%" (
        echo.
        echo 🚀 Starting service optimization...
        call "%TARGET%"
    ) else (
        echo.
        echo ❌ Cannot start service optimization because '%TARGET%' was not found.
        echo.
        pause
    )
)

exit /b 0
