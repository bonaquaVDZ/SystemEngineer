@echo off
:: Loop through a range of numbers
for /L %%i in (1,2,10) do (
    echo %%i
)

:: Loops through files in a folder
for %%f in (*.txt) do (
    echo %%f
)

:: Iterate over the list
for %%i in (banana, apple, orange, grape) do (
    echo %%i
)