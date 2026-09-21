@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

REM 🧹 Windows 11 Service Optimizer - One-Click Launcher
REM This batch file makes optimization as simple as double-clicking!

set "SCRIPT_DIR=%~dp0"
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "PS_SCRIPT=%SCRIPT_DIR%\disable-services.ps1"

if not exist "%PS_SCRIPT%" (
    echo ❌ Missing optimizer script: "%PS_SCRIPT%"
    echo.
    echo Please make sure disable-services.ps1 is in the same folder as this launcher.
    echo.
    pause
    exit /b 1
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║              🧹 Windows 11 Service Optimizer                ║
echo ║                 🚀 One-Click Optimization                    ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

REM Check if running as Administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Administrator privileges confirmed
) else (
    echo ❌ This script requires Administrator privileges!
    echo.
    echo Right-click on this file and select "Run as Administrator"
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b 1
)

echo.
echo 🔧 Setting execution policy for this session...
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -Scope Process Bypass -Force" >nul 2>&1
if errorlevel 1 (
    echo ⚠️ PowerShell policy could not be updated for this session, but continuing anyway.
) else (
    echo ✅ PowerShell execution policy configured for this session
)

echo.
echo 🚀 Starting Windows 11 Service Optimization...
echo.

REM Run the PowerShell script
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"
if errorlevel 1 (
    echo.
    echo ❌ Optimization script exited with an error.
    echo Please review the PowerShell output above and try again.
    echo.
    pause >nul
    exit /b 1
)

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                 🎉 Optimization Complete!                 ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo The optimization has finished! Your computer will benefit from:
echo • 🚀 Faster boot times
echo • 💾 Lower memory usage
echo • 🔒 Enhanced privacy
echo • 🛡️ Reduced background activity
echo.
echo IMPORTANT: Please restart your computer for all changes to take effect.
echo.
echo Press any key to exit...
pause >nul
exit /b 0
