# Defininf function

function Greet {
    param ($Name, $Surname)
    Write-Output "Hello $Name $Surname"
}

Greet ("Bob", "Miller")