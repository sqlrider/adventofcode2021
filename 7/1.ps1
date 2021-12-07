# https://adventofcode.com/2021/day/7
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$crab_positions = $puzzleinput.Split(',')

[int]$minpos = ($crab_positions | Measure -Minimum).Minimum
[int]$maxpos = ($crab_positions | Measure -Maximum).Maximum

# Use a simple hashtable to record position + fuel values
$fueltable = @{}

for($pos = $minpos; $pos -le $maxpos; $pos++)
{
    $fuelused = 0

    for($j = 0; $j -lt $crab_positions.Count; $j++)
    {
        $fuelused += [Math]::Abs($crab_positions[$j] - $pos)
    }

    $fueltable.Add($pos, $fuelused)

    Write-Output "Fuel used for position $($pos): $($fuelused)"

}

$fueltable.GetEnumerator() | Sort -Property Value | Select -First 1