#!/bin/bash
# Full Backup Script for Linux and MacOS
#
# This script performs a full backup of a specified source directory by compressing it
# into a `.tar.gz` archive and storing it in a specified backup directory. It includes
# robust error checking to ensure the source directory exists and is not empty before
# proceeding. Logs are maintained for both successful operations and errors.

SOURCE_DIR="/home/whitetulip/Test"
BACKUP_DIR="/home/whitetulip/Backup"
LOG_FILE="/home/whitetulip/backup.log"
ERROR_LOG="/home/whitetulip/error.log"

# Ensure the backup directory exists; create it if it doesn't
mkdir -p "$BACKUP_DIR"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    # Log an error if the source directory is missing
    echo "Error: Source directory $SOURCE_DIR does not exist. Backup aborted" >> "$ERROR_LOG"
    exit 1  
fi

# Check if the source directory is empty
if [ -z "$(ls -A "$SOURCE_DIR")" ]; then
    # Log an error if the source directory is empty
    echo "Error: Source directory $SOURCE_DIR is empty. Backup aborted." >> "$ERROR_LOG"
    exit 1 
fi

# Add a timestamp to the log files to indicate the start of the backup
echo "---------------------------------" >> "$LOG_FILE"
echo "Backup started on $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"

echo "---------------------------------" >> "$ERROR_LOG"
echo "Backup started on $(date '+%Y-%m-%d %H:%M:%S')" >> "$ERROR_LOG"

echo "Starting backup from $SOURCE_DIR to $BACKUP_DIR" >> "$LOG_FILE"

# Perform the backup using the `tar` command
# -c: Create an archive
# -z: Compress the archive with gzip
# -v: Verbose mode, listing the files being processed
# -f: Specify the output file
tar -czvf "$BACKUP_DIR/backup_$(date +%Y%m%d).tar.gz" -C "$SOURCE_DIR" . >> "$LOG_FILE" 2>> "$ERROR_LOG"

# Check the exit status of the tar command
if [ $? -eq 0 ]; then
    echo "Backup completed successfully on $(date '+%Y-%m-%d %H:%M:%S')!" >> "$LOG_FILE"
    echo "No errors occurred during the backup process." >> "$ERROR_LOG"
else
    echo "Backup failed on $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "Backup failed due to errors. Check the details above." >> "$ERROR_LOG"
fi

# Add a completion timestamp to the error log
echo "Backup process ended on: $(date '+%Y-%m-%d %H:%M:%S')" >> "$ERROR_LOG"
