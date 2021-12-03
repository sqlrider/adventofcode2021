# https://adventofcode.com/2021/day/3
# Part 1

$input = Get-Content -Path "$($PSScriptRoot)\input.txt"

[int[]]$mostcommonbits = [int[]]::New(12)
[int[]]$leastcommonbits = [int[]]::New(12)

for($i = 0; $i -lt 12; $i++)
{
    $zeroes = 0
    $ones = 0

    for($j = 0; $j -lt 1000; $j++)
    {
        if($input[$j][$i] -eq '0')
        {
            $zeroes++
        }
        elseif($input[$j][$i] -eq '1')
        {
            $ones++
        }
    }

    if($zeroes -gt $ones)
    {
        $mostcommonbits[$i] = 0
        $leastcommonbits[$i] = 1
    }
    elseif($ones -gt $zeroes)
    {
        $mostcommonbits[$i] = 1
        $leastcommonbits[$i] = 0
    }
}

# Output Field Seperator, special variable for string concatenation
$ofs=''

$gammarate = [convert]::ToInt32("$([string]$mostcommonbits)",2)

$epsilonrate = [convert]::ToInt32("$([string]$leastcommonbits)",2)

$powerconsumption = $gammarate * $epsilonrate

Write-Output "Gamma rate = $($gammarate), epsilon rate = $($epsilonrate), power consumption = $($powerconsumption)"