#!/usr/bin/env python3
"""
Cross-Platform Schedule Tasks Script
--------------------------------------
This script demonstrates how to schedule recurring tasks in Python using the `schedule` module.
It is designed to run on both Windows and Linux systems.

Included Tasks:
  1. A simple job that logs a generic message.
  2. An internet connectivity check job that runs every 5 minutes and logs whether each website is online.

Note:
  - This script runs as a continuously running process.
  - For production-grade scheduling, consider using OS-level schedulers (cron for Linux, Task Scheduler for Windows).
"""

import schedule
import time
import subprocess
import logging
import socket
import sys

# Set up logging to record when scheduled tasks run.
logging.basicConfig(
    filename='scheduled_tasks.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

def generic_job():
    """
    A basic job that logs a generic message.
    """
    logging.info("Executing generic scheduled job.")
    print("Generic scheduled job executed.")

# Define a list of websites to test for connectivity
WEBSITES = ["www.google.com", "www.microsoft.com", "www.github.com"]

def check_internet_connectivity(website):
    """
    Checks internet connectivity for a given website by attempting to establish a connection on port 80.
    
    Args:
        website (str): The website to check.
        
    Returns:
        bool: True if the connection is successful; otherwise, False.
    """
    try:
        socket.setdefaulttimeout(3)
        host = socket.gethostbyname(website)
        s = socket.create_connection((host, 80), 2)
        s.close()
        return True
    except Exception:
        return False

def connectivity_job():
    """
    Scheduled job that checks and logs the internet connectivity status for each website in the WEBSITES list.
    """
    for website in WEBSITES:
        online = check_internet_connectivity(website)
        if online:
            message = f"Internet connectivity to {website} is available."
            logging.info(message)
            print(message)
        else:
            message = f"Internet connectivity to {website} is NOT available."
            logging.error(message)
            print(message)

# Schedule tasks
# Run the generic job every minute (example)
schedule.every(1).minutes.do(generic_job)
# Run the connectivity check every 5 minutes
schedule.every(5).minutes.do(connectivity_job)

def main():
    """
    Main loop that continuously runs pending scheduled tasks.
    """
    logging.info("Scheduler started.")
    print("Scheduler started. Press Ctrl+C to exit.")
    try:
        while True:
            schedule.run_pending()  # Run all tasks that are scheduled to run
            time.sleep(1)           # Sleep for a short time to avoid high CPU usage
    except KeyboardInterrupt:
        logging.info("Scheduler stopped by user.")
        print("Scheduler stopped.")

if __name__ == '__main__':
    main()
