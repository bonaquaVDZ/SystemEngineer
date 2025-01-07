#!/bin/bash
# Incremental Backup Script for Linux and MacOS
#
# This script performs an incremental backup of a specified source directory by compressing only 
# files that have changed since the last backup. It stores the backup in a `.tar.gz` archive 
# and tracks changes using a snapshot file. Logs are maintained for both successful operations 
# and errors.

SOURCE_DIR="/home/whitetulip/Test"
BACKUP_DIR="/home/whitetulip/Backup"
SNAPSHOT_FILE="/home/whitetulip/backup.snar"  # Snapshot file to track changes
LOG_FILE="/home/whitetulip/incremental_backup.log"
ERROR_LOG="/home/whitetulip/incremental_error.log"

# Ensure the backup directory exists; create it if it doesn't
mkdir -p "$BACKUP_DIR"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    # Log an error if the source directory is missing
    echo "Error: Source directory $SOURCE_DIR does not exist. Backup aborted." >> "$ERROR_LOG"
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
echo "Incremental Backup started on $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"

echo "---------------------------------" >> "$ERROR_LOG"
echo "Incremental Backup started on $(date '+%Y-%m-%d %H:%M:%S')" >> "$ERROR_LOG"

echo "Starting incremental backup from $SOURCE_DIR to $BACKUP_DIR" >> "$LOG_FILE"

# Perform the incremental backup using the `tar` command
# --listed-incremental: Use the snapshot file to track changes
# -c: Create an archive
# -z: Compress the archive with gzip
# -v: Verbose mode, listing the files being processed
# -f: Specify the output file
tar --listed-incremental="$SNAPSHOT_FILE" -czvf "$BACKUP_DIR/incremental_backup_$(date +%Y%m%d_%H%M%S).tar.gz" -C "$SOURCE_DIR" . >> "$LOG_FILE" 2>> "$ERROR_LOG"

# Check the exit status of the tar command
if [ $? -eq 0 ]; then
    echo "Incremental Backup completed successfully on $(date '+%Y-%m-%d %H:%M:%S')!" >> "$LOG_FILE"
    echo "No errors occurred during the incremental backup process." >> "$ERROR_LOG"
else
    echo "Incremental Backup failed on $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "Incremental Backup failed due to errors. Check the details above." >> "$ERROR_LOG"
fi

# Add a completion timestamp to the error log
echo "Incremental Backup process ended on: $(date '+%Y-%m-%d %H:%M:%S')" >> "$ERROR_LOG"
