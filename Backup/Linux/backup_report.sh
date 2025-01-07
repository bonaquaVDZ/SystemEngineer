#!/bin/bash
# Backup Report Generator
#
# This script generates a summary of backup operations by analyzing log files.
# It provides details such as the last successful backup, errors encountered, 
# and the overall status of the backup operations.

# Define log file paths (adjust as needed)
LOG_FILE="/home/whitetulip/backup.log"
ERROR_LOG="/home/whitetulip/error.log"
REPORT_FILE="/home/whitetulip/backup_report.log"

# Check if log files exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file $LOG_FILE does not exist. Cannot generate report."
    exit 1
fi

if [ ! -f "$ERROR_LOG" ]; then
    echo "Error log $ERROR_LOG does not exist. Cannot generate report."
    exit 1
fi

# Create a new report file
echo "Backup Report" > "$REPORT_FILE"
echo "Generated on: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"
echo "-----------------------------------" >> "$REPORT_FILE"

# Analyze the last backup entry in the log file
echo "Analyzing last backup entry..." >> "$REPORT_FILE"
LAST_BACKUP=$(grep "Backup started on" "$LOG_FILE" | tail -1)
if [ -n "$LAST_BACKUP" ]; then
    echo "Last Backup: $LAST_BACKUP" >> "$REPORT_FILE"
else
    echo "No backups have been logged in $LOG_FILE." >> "$REPORT_FILE"
fi

# Check if the last backup was successful
echo "Checking backup status..." >> "$REPORT_FILE"
if grep -q "Backup completed successfully" "$LOG_FILE"; then
    echo "Status: Last backup completed successfully." >> "$REPORT_FILE"
else
    echo "Status: Last backup failed. See errors below." >> "$REPORT_FILE"
fi

# Analyze the error log
echo "Analyzing errors..." >> "$REPORT_FILE"
if grep -q "Error:" "$ERROR_LOG"; then
    echo "Errors Found:" >> "$REPORT_FILE"
    grep "Error:" "$ERROR_LOG" | tail -5 >> "$REPORT_FILE"
else
    echo "No errors found in $ERROR_LOG." >> "$REPORT_FILE"
fi

# Add a summary section
TOTAL_BACKUPS=$(grep -c "Backup started on" "$LOG_FILE")
SUCCESSFUL_BACKUPS=$(grep -c "Backup completed successfully" "$LOG_FILE")
FAILED_BACKUPS=$((TOTAL_BACKUPS - SUCCESSFUL_BACKUPS))

echo "-----------------------------------" >> "$REPORT_FILE"
echo "Summary:" >> "$REPORT_FILE"
echo "Total Backups Logged: $TOTAL_BACKUPS" >> "$REPORT_FILE"
echo "Successful Backups: $SUCCESSFUL_BACKUPS" >> "$REPORT_FILE"
echo "Failed Backups: $FAILED_BACKUPS" >> "$REPORT_FILE"
echo "-----------------------------------" >> "$REPORT_FILE"
echo "Backup Report Completed." >> "$REPORT_FILE"

# Print the report file path
echo "Backup report generated at: $REPORT_FILE"
