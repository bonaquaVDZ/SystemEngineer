#!/usr/bin/env python3
"""
Migrate Databases Script
------------------------
This script migrates a MySQL database from a source server to a destination server.
It performs the following steps:
  1. Uses mysqldump to create a backup of the source database.
  2. Restores the dump into the destination database using the mysql client.
  
Usage Example:
    python migrate_dbs.py --source_host localhost --source_user src_user --source_pass src_pass --source_db source_db \
                            --dest_host dest_host --dest_user dest_user --dest_pass dest_pass --dest_db dest_db

This script is cross‑platform and works on both Linux and Windows, provided that
mysqldump and mysql commands are installed and available in the PATH.
"""

import argparse
import subprocess
import tempfile
import os
import sys
import logging

# Setup basic logging
logging.basicConfig(
    filename="migrate_dbs.log",
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

def parse_arguments():
    parser = argparse.ArgumentParser(description="Migrate a MySQL database from a source server to a destination server.")
    
    # Source connection parameters
    parser.add_argument("--source_host", required=True, help="Source MySQL host")
    parser.add_argument("--source_user", required=True, help="Source MySQL username")
    parser.add_argument("--source_pass", required=True, help="Source MySQL password")
    parser.add_argument("--source_db", required=True, help="Source MySQL database name")
    
    # Destination connection parameters
    parser.add_argument("--dest_host", required=True, help="Destination MySQL host")
    parser.add_argument("--dest_user", required=True, help="Destination MySQL username")
    parser.add_argument("--dest_pass", required=True, help="Destination MySQL password")
    parser.add_argument("--dest_db", required=True, help="Destination MySQL database name")
    
    return parser.parse_args()

def run_command(command, shell=False):
    """Run a shell command and return exit code, stdout and stderr."""
    logging.info(f"Executing command: {command}")
    try:
        result = subprocess.run(command, shell=shell, capture_output=True, text=True)
        logging.info("stdout: " + result.stdout)
        if result.stderr:
            logging.error("stderr: " + result.stderr)
        return result.returncode, result.stdout, result.stderr
    except Exception as e:
        logging.error(f"Exception while executing command: {e}")
        return 1, "", str(e)

def migrate_database(args):
    # Create a temporary file to hold the dump
    with tempfile.NamedTemporaryFile(delete=False, suffix=".sql") as tmp:
        dump_file = tmp.name
    
    logging.info(f"Temporary dump file created: {dump_file}")
    
    # Construct the mysqldump command for the source database.
    # On Windows, if mysqldump is not in the PATH, replace "mysqldump" with its full path.
    mysqldump_cmd = [
        "mysqldump",
        "-h", args.source_host,
        "-u", args.source_user,
        f"-p{args.source_pass}",
        args.source_db
    ]
    
    # Redirect output to the temporary dump file.
    with open(dump_file, "w") as dump_fp:
        logging.info("Starting mysqldump for source database...")
        retcode = subprocess.call(mysqldump_cmd, stdout=dump_fp, stderr=subprocess.PIPE, text=True)
    
    if retcode != 0:
        logging.error("mysqldump failed. Exiting migration.")
        os.unlink(dump_file)  # Clean up
        sys.exit(1)
    
    logging.info("mysqldump completed successfully.")
    
    # Construct the mysql command for the destination database.
    mysql_cmd = f'mysql -h {args.dest_host} -u {args.dest_user} -p"{args.dest_pass}" {args.dest_db}'
    
    # Open the dump file and pipe its contents into the mysql command.
    with open(dump_file, "r") as dump_fp:
        logging.info("Starting restoration to destination database...")
        result = subprocess.run(mysql_cmd, shell=True, stdin=dump_fp, capture_output=True, text=True)
    
    # Clean up the temporary dump file.
    os.unlink(dump_file)
    logging.info(f"Temporary dump file {dump_file} deleted.")
    
    if result.returncode == 0:
        logging.info("Database migration completed successfully.")
        print("Database migration completed successfully.")
    else:
        logging.error(f"Database migration failed with exit code {result.returncode}.")
        logging.error("stderr: " + result.stderr)
        print("Database migration failed. Check migrate_dbs.log for details.")
        sys.exit(1)

def main():
    args = parse_arguments()
    migrate_database(args)

if __name__ == "__main__":
    main()
