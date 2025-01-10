# Try-Catch-Finally
try {
    Get-Content not_existing_file.txt
} catch {
    Write-Output "An error occurred: $_"
} finally {
    Write-Output "Completed"
}

# Check if the last cmdlet was successfull
Write-Output "Was the last command successful? $?"

# Display the most recent error
Write-Output "Last Error: $($Error[0])"