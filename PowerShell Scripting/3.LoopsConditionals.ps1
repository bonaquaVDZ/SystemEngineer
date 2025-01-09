# For Loop
for ($i = 0; $i -lt 10; $i++) {
    Write-Output "Iteration $i"
}

# Foreach Loop
$Array = 1, 2, 3
foreach ($Item in $Array) {
    Write-Output $Item
}

# While Loop
$i = 0
while ($i -lt 5) {
    Write-Output $i
    $i++
}

# If-Else
if ($a -eq $b) {
    Write-Output "Equal"
} elseif ($a -gt $b) {
    Write-Output "Greater"
} else {
    Write-Output "Smaller"
}
