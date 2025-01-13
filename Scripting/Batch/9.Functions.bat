@echo off

:: Batch files don't support functions directly but use labels to simulate them
call :MyFunction Parameter1 Parameter2 Year 2025
goto :eof

:MyFunction
echo This is function with %1 %2 Now is %4 %3
goto :eof