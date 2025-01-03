# File Cleanup Script

This Python script automates the cleanup of old files in a specified directory. It scans the directory, checks the last modification time of each file, and deletes files older than a user-defined retention period.

## Features
- Deletes files based on age (in days).
- Supports a "dry run" mode to preview deletions without actually deleting files.
- Validates input directory and handles errors gracefully.

## Requirements
- Python 3.6 or higher
- Compatible with Linux, macOS, and Windows.

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/file-cleanup-script.git
   cd file-cleanup-script

## Usage
1. Delete files older that 7 days
python file_cleanup.py /path/to/logs 7

2. Simulate deletion without removing files
python file_cleanup.py /path/to/logs 7 --dry-run

