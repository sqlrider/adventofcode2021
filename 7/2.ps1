# https://adventofcode.com/2021/day/7
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$crab_positions = $puzzleinput.Split(',')

[int]$minpos = ($crab_positions | Measure -Minimum).Minimum
[int]$maxpos = ($crab_positions | Measure -Maximum).Maximum


# Construct fuel usage map for movement lengths up to max possible, seeded with (0,0) as population loop uses prior key value to get current value
# This is for reference in main loop to save calculating per-crab
$fuel_usage_map=@{}

$fuel_usage_map.Add(0,0)

for($i = 1; $i -le $maxpos; $i++)
{
    $fuel_usage_map.Add($i,$i+($fuel_usage_map[$i-1]))
}


# Use a hashtable to record position + fuel values
$fueltable = @{}

for($pos = $minpos; $pos -le $maxpos; $pos++)
{
    $fuelused = 0

    for($j = 0; $j -lt $crab_positions.Count; $j++)
    {
        $distance = [Math]::Abs($crab_positions[$j] - $pos)
        $fuelused += $fuel_usage_map[$distance] # Refer to fuel usage map for how much fuel used for this distance
    }

    $fueltable.Add($pos, $fuelused)

    Write-Output "Fuel used for position $($pos): $($fuelused)"

}

$fueltable.GetEnumerator() | Sort -Property Value | Select -First 1

