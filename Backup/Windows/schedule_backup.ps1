# PowerShell Script to Schedule Backup Task
#------------------------------------------
# This script automates the creation of a Task Scheduler to run a full backup batch

# Define variables
$TaskName="FullBackupTask"      # Name of the Task Scheduler task
$BatchFilePath="C:\Users\vadzi\Tech\SystemEngineer\Backup\Windows\full_backup.bat" # Path to the batch file
$ScheduleType="daily"      # Schedule time (daily, weekly, monthly)
$StartTime="02:00AM"        # Time to run the backup task
$Description="Automates the execution of the full backup script. "

# Validate the batch file exists
if ( -not (Test-Path -Path $BatchFilePath)) {
    Write-Host "Error: The batch file $BatchFilePath does not exist." -ForegroundColor Red
    exit 1
}

# Create the actio for the Task Scheduler
$Action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c $BatchfilePath"

# Create the trigger for the Task Scheduler
$Trigger = New-ScheduledTaskTrigger -Daily -At (Get-Date -Format "HH:mm:ss" -Date $StartTime)

# Create the principal (runs at the current user)
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount

# Create the settings for the Task Scheduler
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# Create or update the task in Task Scheduler
try {
    Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -Description $Description -Force 
    Write-Host "Task '$TaskName' has been successfully created or updated" -ForegroundColor Green
} catch {
    Write-Host "Error: Failed to create or update the task. Deatils: $_" -ForegroundColor Red
    exit 1
}

# Display task details
Write-Host "`nScheduled Task Details: " -ForegroundColor Yellow
Write-Host "------------------------------------------------------"
Write-Host "Task name: $TaskName"
Write-Host "Batch file: $BatchFilePath"
Write-Host "Schedule: $ScheduleType at $StartTime"
Write-Host "Description: $Description"
Write-Host "------------------------------------------------------"
