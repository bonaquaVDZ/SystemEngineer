#!/usr/bin/env python3
"""
File Cleanup Script
-------------------
This script automates the cleanup of old files in a specified directory. It scans the directory, checks the last modification time of each file, and deletes files older than a user-defined retention period. Optionally, it supports a dry-run mode and user confirmation for deletion.

## Features
- Deletes files older than a specified number of days.
- Supports a "dry run" mode to preview deletions without actually removing files.
- Optionally prompts the user for confirmation before deleting each file.
- Handles invalid paths and errors gracefully with informative messages.

## Requirements
- Python 3.6 or higher.
- Compatible with Linux, macOS, and Windows.

## Usage
1. Delete files older that 7 days
    python cleanup_old_files.py /path/to/logs 7

2. Simulate deletion without removing files
    python cleanup_old_files.py /path/to/logs 7 --dry-run

3. Delete with confirmation for each file
    python cleanup_old_files.py /path/to/logs 7 --confirm
"""

import os
import time
from argparse import ArgumentParser

def delete_old_files(directory, retention_days, dry_run=False, confirm=False):
    """
    Deletes files older than a specified number of days in the given directory.

    Args:
        directory (str): Path to the directory to clean up.
        retention_days (int): Number of days to retain files. Older files are deleted.
        dry_run (bool): If True, only displays files that would be deleted.
        confirm (bool): If True, asks the user to confirm each file deletion.

    Returns:
        None
    """
    now = time.time()
    cutoff_time = now - (retention_days * 86400)  # Convert days to seconds
    deleted_files = []

    if not os.path.exists(directory):
        print(f"Error: The directory '{directory}' does not exist.")
        return

    if not os.path.isdir(directory):
        print(f"Error: '{directory}' is not a directory.")
        return

    print(f"\nScanning directory: {directory}")
    for file in os.listdir(directory):
        file_path = os.path.join(directory, file)
        try:
            if os.path.isfile(file_path):
                file_mod_time = os.path.getmtime(file_path)
                if file_mod_time < cutoff_time:
                    if dry_run:
                        print(f"[DRY RUN] Would delete: {file_path}")
                    elif confirm:
                        response = input(f"Delete {file_path}? (y/n): ").strip().lower()
                        if response == 'y':
                            os.remove(file_path)
                            deleted_files.append(file_path)
                            print(f"Deleted: {file_path}")
                        else:
                            print(f"Skipped: {file_path}")
                    else:
                        os.remove(file_path)
                        deleted_files.append(file_path)
                        print(f"Deleted: {file_path}")
        except Exception as e:
            print(f"Error processing file '{file_path}': {e}")

    if not dry_run:
        print(f"\nTotal files deleted: {len(deleted_files)}")
    else:
        print("[DRY RUN] No files were actually deleted.")


def main():
    parser = ArgumentParser(description="Automate the cleanup of old files in a directory.")
    parser.add_argument("directory", type=str, help="Path to the directory to clean up.")
    parser.add_argument(
        "retention_days", type=int, help="Number of days to retain files. Older files are deleted."
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="Simulate deletion without actually removing files."
    )
    parser.add_argument(
        "--confirm", action="store_true", help="Ask for confirmation before deleting each file."
    )
    args = parser.parse_args()

    delete_old_files(args.directory, args.retention_days, args.dry_run, args.confirm)


if __name__ == "__main__":
    main()
