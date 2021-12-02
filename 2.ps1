
# https://adventofcode.com/2021/day/1
# Part 2

$input = Get-Content -Path "$($PSScriptRoot)\input.txt"
$depths = @()

$larger_measurements = 0

foreach($row in $input)
{
    $depths += [int]$row
}

for($i = 3; $i -le ($depths.Count - 1); $i++)
{
    if(($depths[$i] + $depths[$i-1] + $depths[$i-2]) -gt ($depths[$i-1] + $depths[$i-2] + $depths[$i-3]))
    {
        $larger_measurements++
    }

}
 
Write-Output $larger_measurements