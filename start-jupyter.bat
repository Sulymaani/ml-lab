@echo off
title ml-lab Jupyter
cd /d "%~dp0"
set "PATH=%USERPROFILE%\.local\bin;%PATH%"
uv run jupyter lab phase-1-python-math
pause
