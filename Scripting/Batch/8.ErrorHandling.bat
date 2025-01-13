@echo off

set var=Awesome World
echo %var% >nul 2>&1

if %errorlevel%==0 (
    echo Command succeeded
) else (
    echo Command failed
)

:: command >nul 2>&1 Suppresses both output and error message