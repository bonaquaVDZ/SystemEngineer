#! /usr/bin/env python3

"""
Backup Status Check Script

This script verifies the backup status by comparing source and destination directories. 
"""

import os
from datetime import datetime

SOURCE_DIRECTORY = r"C:\Users\Username\Tech\Python"
DESTINATION_DIRECTORY = r"C:\Users\Username\Tech\Test"
LOG_FILE = r"C:\Users\Username\Tech\backup_status_log.txt"

def compare_directories(source, backup):
    """
    Compares the source and backup directories for missing files and folders.

    Args:
        source (str): Path to the source directory.
        backup (str): Path to the backup directory.

    Returns:
        dict: A dictionary containing missing files and folders.
    """
    missing_files = []
    missing_folders = []

    for root, dirs, files in os.walk(source):
        # Check directories
        for dir in dirs:
            relative_path = os.path.relpath(os.path.join(root, dir), source)
            backup_path = os.path.join(backup, relative_path)
            if not os.path.exists(backup_path):
                missing_folders.append(relative_path)

        # Check files
        for file in files:
            relative_path = os.path.relpath(os.path.join(root, file), source)
            backup_path = os.path.join(backup, relative_path)
            if not os.path.exists(backup_path):
                missing_files.append(relative_path)

    return {"files": missing_files, "folders": missing_folders}

def log_message(message):
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open (LOG_FILE, "a") as log:
        log.write(f"{timestamp}: {message}\n")


def main():
    """
    Main function to check backup status and log missing files and folders.
    """
    log_message("Starting backup status check.")
    print("Comparing source and backup directories...")
    missing_items = compare_directories(SOURCE_DIRECTORY, DESTINATION_DIRECTORY)

    missing_files = missing_items["files"]
    missing_folders = missing_items["folders"]

    if missing_files or missing_folders:
        if missing_files:
            log_message(f"Missing files: {missing_files}")
            print(f"Missing files logged to {LOG_FILE}")

        if missing_folders:
            log_message(f"Missing folders: {missing_folders}")
            print(f"Missing folders logged to {LOG_FILE}")
    else:
        log_message("Backup is complete and up to date.")
        print("Backup is complete and up to date.")

    log_message("Backup status check completed.")

if __name__ == '__main__':
    main()