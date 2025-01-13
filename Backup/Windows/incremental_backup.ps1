# Incremental Backup Script
# Copies only new or modified files to the backup location based on timestamp.
# Efficient for frequent backups in between full backups. 

$Source= "C:\Users\vadzi\Tech\Python"
$Destination= "C:\Users\vadzi\Tech\Test"
$LogFile= "C:\Users\vadzi\Tech\incremental_backup_log.txt"

Write-Host "Starting incremental backup from $Source to $Destination..."
Add-Content -Path $LogFile -Value "Backup started at $(Get-Date)"

Get-ChildItem -Path $Source -Recurse | ForEach-Object {
    $SourceFile = $_.FullName
    $DestFile = $Destination + ($_.FullName -replace [regex]::Escape($Source), "")
    if (-Not (Test-Path -Path (Split-Path $DestFile))) {
        New-Item -ItemType Directory -Path (Split-Path $DestFile)
    }
    if (-Not (Test-Path -Path $DestFile) -or $_.LastWriteTime -gt (Get-Item -Path $DestFile).LastWriteTime) {
        Copy-Item -Path $SourceFile -Destination $DestFile
        Add-Content -Path $Logfile -Value "Copied: $SourceFile"
    }
}

Add-Content -Path $LogFile -Value "Backup completed at $(Get-Date)"
Write-Host "Backup completed. Log file: $Logfile"