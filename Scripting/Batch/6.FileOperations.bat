@echo off

:: Copy files
copy source.txt dest.txt

:: Copies directories and subdirectories
xcopy sorce_folder dest_folder /E /I

:: Moves files
move file.txt destination_folder