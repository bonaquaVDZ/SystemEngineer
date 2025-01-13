# Create a Scheduled Task
$Action = New-ScheduledTaskAction -Execute "notepad.exe"
$Trigger = New-ScheduledTaskTrigger -Daily -At "02:00AM"
Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName "MyTask"