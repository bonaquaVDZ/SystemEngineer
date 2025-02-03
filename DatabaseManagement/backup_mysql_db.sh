#!/bin/bash
# MySQL Database Backup Script
#
# This script performs a backup of a specified MySQL database using mysqldump.
# The backup is saved as a timestamped .sql file in a designated backup directory.
# All actions and errors are logged to a log file.

# --- Configuration Variables ---
# MySQL credentials and database name
DB_HOST="localhost"
DB_PORT="3306"              # Default MySQL port
DB_USER="username"          # Change to your MySQL username
DB_PASS="password"          # Change to your MySQL password (avoid hardcoding in production)
DB_NAME="name_of_db"        # Change to the database you want to back up

# Backup directory and log file
BACKUP_DIR="/home/whitetulip/DatabaseManagement/Backups"
LOG_FILE="/home/whitetulip/DatabaseManagement/backup_mysql_db.log"

# --- Create Backup Directory ---
mkdir -p "$BACKUP_DIR"

# --- Generate Timestamp and Backup File Name ---
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_${TIMESTAMP}.sql"

# --- Logging Start of Backup ---
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting MySQL backup for database '$DB_NAME'" >> "$LOG_FILE"

# --- Perform the Backup ---
# The mysqldump command exports the database to a .sql file.
mysqldump -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE" 2>> "$LOG_FILE"

# --- Check for Success ---
if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup completed successfully. Backup file: $BACKUP_FILE" >> "$LOG_FILE"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup failed for database '$DB_NAME'" >> "$LOG_FILE"
fi
