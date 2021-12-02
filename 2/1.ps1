# https://adventofcode.com/2021/day/2
# Part 1

$input = Get-Content -Path "$($PSScriptRoot)\input.txt"

$x = 0
$depth = 0

foreach($row in $input)
{
    $direction = $row.Substring(0,1)
    $magnitude = [int]$row.Substring($row.Length - 1)

    if($direction -eq 'f')
    {
        $x += $magnitude
    }
    elseif($direction -eq 'd')
    {
        $depth += $magnitude
    }
    elseif($direction -eq 'u')
    {
        $depth -= $magnitude
    }
}

$pos = $x * $depth

Write-Output "x = $($x), depth = $($depth), pos = $($pos)"