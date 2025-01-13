@echo off

set year=2025

if %year%==2025 echo You're right, it is 2025


:: If-Else example
if %year%==2025 (
    echo Today is 2025
) else (
    echo Unfortunately, you were wrong
)

:: Check file/folder existance
if exist 2.Variables.bat echo Definitely file exists
if not exist 2.Variables.bat echo This file doesn't exist