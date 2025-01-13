@echo off
:: Full backup script
:: Copies all files and directories to the backup location

set SOURCE=C:\Users\Username\Tech\Python
set DESTINATION=C:\Users\Username\Tech\Test
set LOGFILE=C:\Users\Username\Tech\full_backup_log.txt

echo Starting full backup from %SOURCE% to %DESTINATION%
robocopy %SOURCE% %DESTINATION% /MIR /R:3 /W:5 /LOG:%LOGFILE% /V

if %errorlevel% LEQ 3 (
    echo Backup completed successfully.
) else (
    echo Backup encountered errors. Check the log: %LOGFILE%
)