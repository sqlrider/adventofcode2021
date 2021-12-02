
# https://adventofcode.com/2021/day/1
# Part 1

$input = Get-Content -Path "$($PSScriptRoot)\input.txt"

$larger_measurements = 0
[int]$last_value = 9999999 # Arbitrarily large value

foreach($row in $input)
{
    if([int]$row -gt $last_value)
    {
        $larger_measurements++
    }

    $last_value = [int]$row
}

Write-Output $larger_measurements