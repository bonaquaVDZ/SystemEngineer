@echo off

:: Redirect Output to a File
echo Hello > test.txt
echo World >> test.txt

:: Redirect Error Messages
dir /b non_existing_file.txt 2>> error.log

