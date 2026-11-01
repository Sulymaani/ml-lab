@echo off
title ml-lab setup
cd /d "%~dp0"
echo.
echo [1/4] Installing uv (Python manager) if missing...
where uv >nul 2>nul || powershell -NoProfile -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
set "PATH=%USERPROFILE%\.local\bin;%PATH%"
echo.
echo [2/4] Installing Python 3.12 and the Phase 1-2 libraries (first run takes a few minutes)...
uv sync || goto :fail
echo.
echo [3/4] Checking everything imports...
uv run python -c "import numpy, pandas, sklearn, matplotlib; print('OK: Python ready, numpy', numpy.__version__, '| scikit-learn', sklearn.__version__)" || goto :fail
echo.
echo [4/4] Setting up Git...
where git >nul 2>nul
if errorlevel 1 (
  echo NOTE: Git is not installed. Install it from https://git-scm.com/download/win then run this file again.
) else (
  if not exist .git git init -b main >nul
  echo OK: git repo ready
)
echo.
echo ===== Setup finished. Double-click start-jupyter.bat to begin Week 1. =====
pause
exit /b 0
:fail
echo.
echo ===== Something failed. Take a screenshot of this window and send it to Claude. =====
pause
exit /b 1
