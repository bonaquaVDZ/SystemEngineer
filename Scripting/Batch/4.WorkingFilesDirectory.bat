@echo off

:: Lists all files and directories in the current folder
dir  

:: Lists files in bare format (no extra info)
dir /b 

:: Create a new directory
mkdir new_folder

:: Remove a directory
rmdir new_folder

:: Remove a directory and its contents
rmdir /s /q old_folder


:: Creates a new file
copy con file.txt

:: Deletes a file
del my.txt

:: Delete all '.log' files
del *.log

