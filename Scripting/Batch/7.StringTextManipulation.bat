@echo off

set var=HelloWorld

:: Prints Hello (First five characters)
echo %var:~0,5%

:: Prints World (Starting at the 6th character)
echo %var:~5%

:: Replace text
set my_var=WorldOfEvil
echo %my_var:World=Universe%
