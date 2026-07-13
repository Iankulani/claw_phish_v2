@echo off
title CLAW_PHISH_v2 Installer
echo ================================================
echo  🐾 CLAW_PHISH_v2 v2.0.0 - Installer
echo ================================================
echo.

:: Check Python installation
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH.
    echo Please install Python 3.9+ from https://www.python.org/
    pause
    exit /b 1
)

:: Check Python version
python -c "import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)"
if %errorlevel% neq 0 (
    echo [ERROR] Python 3.9 or higher is required.
    pause
    exit /b 1
)

echo [OK] Python detected

:: Create virtual environment
echo Creating virtual environment...
python -m venv venv
if %errorlevel% neq 0 (
    echo [ERROR] Failed to create virtual environment.
    pause
    exit /b 1
)

:: Activate virtual environment
call venv\Scripts\activate

:: Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip

:: Install requirements
echo Installing requirements...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install requirements.
    pause
    exit /b 1
)

:: Create directories
echo Creating directories...
mkdir .claw_phish_v2 2>nul
mkdir config 2>nul
mkdir logs 2>nul
mkdir reports 2>nul

:: Create config
echo Creating default configuration...
if not exist config\config.json (
    copy config\config.example.json config\config.json
)

echo.
echo ================================================
echo  ✅ Installation Complete!
echo ================================================
echo.
echo To run CLAW_PHISH_v2:
echo   1. Activate environment: venv\Scripts\activate
echo   2. Run: python src\main.py
echo.
echo Or use the launcher: run.bat
echo.
pause