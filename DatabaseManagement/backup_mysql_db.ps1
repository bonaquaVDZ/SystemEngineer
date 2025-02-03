<#
.SYNOPSIS
    Backs up a MySQL database on Windows using mysqldump.

.DESCRIPTION
    This PowerShell script uses mysqldump to create a backup of a specified MySQL database.
    The backup is saved as a timestamped .sql file in a designated backup directory.
    All actions and errors are logged to a log file.

.NOTES
    - Run this script with administrative privileges if needed.
    - Ensure that mysqldump is installed and accessible in the PATH.
    - Modify the configuration variables below to match your MySQL settings.
#>

# --- Configuration Variables ---
# MySQL credentials and database name
$DB_Host = "localhost"
$DB_Port = "3306"           # Default MySQL port
$DB_User = "username"  # Change to your MySQL username
$DB_Pass = "password"  # Change to your MySQL password (consider using secure methods)
$DB_Name = "db_name"  # Change to the database you want to back up

# Backup directory and log file paths
$BackupDir = "C:\Users\$env:USERNAME\Tech\SystemEngineer\DatabaseManagement\Backups"
$LogFile = "C:\Users\$env:USERNAME\Tech\SystemEngineer\DatabaseManagement\backup_mysql_db.log"

# Ensure the backup directory exists
if (-not (Test-Path -Path $BackupDir)) {
    New-Item -Path $BackupDir -ItemType Directory | Out-Null
}

# Generate a timestamp and backup file name
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$BackupFile = Join-Path $BackupDir "${DB_Name}_backup_$Timestamp.sql"

# Function to write log messages with timestamp
function Write-Log {
    param (
        [string]$message,
        [string]$level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp [$level] $message"
    Write-Output $logMessage
    Add-Content -Path $LogFile -Value $logMessage
}

Write-Log "Starting MySQL backup for database '$DB_Name'."

# Construct the mysqldump command.
# If mysqldump is not in the PATH, replace "mysqldump" with its full path.
$DumpCommand = "mysqldump -h $DB_Host -P $DB_Port -u $DB_User -p`"$DB_Pass`" $DB_Name > `"$BackupFile`""

Write-Log "Executing command: $DumpCommand"

# Execute the mysqldump command using cmd.exe /c
# The use of cmd.exe /c allows redirection (>) to work properly.
$processInfo = New-Object System.Diagnostics.ProcessStartInfo
$processInfo.FileName = "cmd.exe"
$processInfo.Arguments = "/c $DumpCommand"
$processInfo.RedirectStandardError = $true
$processInfo.UseShellExecute = $false
$process = New-Object System.Diagnostics.Process
$process.StartInfo = $processInfo

try {
    $process.Start() | Out-Null
    $process.WaitForExit()
    $ErrorOutput = $process.StandardError.ReadToEnd()
} catch {
    Write-Log "Exception occurred while running mysqldump: $_" "ERROR"
    exit 1
}

if ($process.ExitCode -eq 0) {
    Write-Log "Backup completed successfully. Backup file: $BackupFile"
} else {
    Write-Log "Backup failed with exit code $($process.ExitCode)." "ERROR"
    if ($ErrorOutput) {
        Write-Log "Error details: $ErrorOutput" "ERROR"
    }
}


