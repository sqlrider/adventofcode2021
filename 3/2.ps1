# https://adventofcode.com/2021/day/3
# Part 2

$input = Get-Content -Path "$($PSScriptRoot)\input.txt"

[int[]]$oxygen_mostcommonbits = [int[]]::New(12)
[int[]]$oxygen_leastcommonbits = [int[]]::New(12)
[int[]]$oxygen_flag = [int[]]::New(1000)

[int[]]$co2_mostcommonbits = [int[]]::New(12)
[int[]]$co2_leastcommonbits = [int[]]::New(12)
[int[]]$co2_flag = [int[]]::New(1000)

# Initialise oxygen/co2 flags to 1 for all array entries
for($a = 0; $a -lt 1000; $a++)
{
    $oxygen_flag[$a] = 1
    $co2_flag[$a] = 1
}

for($i = 0; $i -lt 12; $i++)
{
    # Reset counters
    $oxygen_zeroes = 0
    $oxygen_ones = 0
    [bool]$oxygen_equal = $false

    $co2_zeroes = 0
    $co2_ones = 0
    [bool]$co2_equal = $false

    # First get most/least common bits for oxygen / co2 
    for($j = 0; $j -lt 1000; $j++)
    {
        $currentvalue = $input[$j][$i]

        if($currentvalue -eq '0')
        {
            if($oxygen_flag[$j] -eq 1)
            {
                $oxygen_zeroes++
            }

            if($co2_flag[$j] -eq 1)
            {
                $co2_zeroes++
            }
        }
        elseif($currentvalue -eq '1')
        {
            if($oxygen_flag[$j] -eq 1)
            {
                $oxygen_ones++
            }

            if($co2_flag[$j] -eq 1)
            {
                $co2_ones++
            }
        }
    }

    # Oxygen
    if($oxygen_zeroes -gt $oxygen_ones)
    {
        $oxygen_mostcommonbits[$i] = 0
        $oxygen_leastcommonbits[$i] = 1
    }
    elseif($oxygen_ones -gt $oxygen_zeroes)
    {
        $oxygen_mostcommonbits[$i] = 1
        $oxygen_leastcommonbits[$i] = 0
    }
    elseif($oxygen_zeroes -eq $oxygen_ones)
    {
        $oxygen_equal = $true
    }

    # CO2
    if($co2_zeroes -gt $co2_ones)
    {
        $co2_mostcommonbits[$i] = 0
        $co2_leastcommonbits[$i] = 1
    }
    elseif($co2_ones -gt $co2_zeroes)
    {
        $co2_mostcommonbits[$i] = 1
        $co2_leastcommonbits[$i] = 0
    }
    elseif($co2_zeroes -eq $co2_ones)
    {
        $co2_equal = $true
    }

    # Now go back through bits and flag to keep for either oxygen or co2 values
    for($j = 0; $j -lt 1000; $j++)
    {
        # Oxygen - most common value, if 0 and 1 are equally common, keep values with a 1 in the position being considered
        if($oxygen_flag[$j] -eq 1) 
        {
            if($oxygen_equal -eq $true)
            {
                if($input[$j][$i] -ne '1')
                {
                    $oxygen_flag[$j] = 0
                }
            }
            elseif($input[$j][$i] -ne [string]$oxygen_mostcommonbits[$i])
            {
                $oxygen_flag[$j] = 0
            }
        }

        # CO2 - least common value, if 0 and 1 are equally common, keep values with a 0 in the position being considered
        if($co2_flag[$j] -eq 1) 
        {
            if($co2_equal -eq $true)
            {
                if($input[$j][$i] -ne '0')
                {
                    $co2_flag[$j] = 0
                }
            }
            elseif($input[$j][$i] -ne [string]$co2_leastcommonbits[$i])
            {
                $co2_flag[$j] = 0
            }
        }
    }

    # Check for Oxygen last value
    if(($oxygen_flag | Measure-Object -Sum).Sum -eq 1)
    {
        $oxygen_binary_result = $input[$oxygen_flag.IndexOf(1)]
    }

    # Check for CO2 last value
    if(($co2_flag | Measure-Object -Sum).Sum -eq 1)
    {
        $co2_binary_result = $input[$co2_flag.IndexOf(1)]
    }
}

$oxygen_result = [convert]::ToInt32("$([string]$oxygen_binary_result)",2)
$co2_result = [convert]::ToInt32("$([string]$co2_binary_result)",2)
$lifesupportrating = $oxygen_result * $co2_result

Write-Output "Oxygen = $($oxygen_result), CO2 = $($co2_result), life support rating = $($lifesupportrating)"
