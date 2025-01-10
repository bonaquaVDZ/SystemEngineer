# Get running processes
Get-Process   # Lists all processes
Get-Process -Name notepad

# Start and Stop processes
Start-Process notepad
Stop-Process -Name notepad

# Exapnaded version if needed
Get-Process | Select-Object CPU, ProcessName | Select-Object -First 20 | Sort-Object -Property CPU -Descending