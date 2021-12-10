# https://adventofcode.com/2021/day/9
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# Get bounds of map
$mapwidth = $puzzleinput[0].Length 
$mapheight = $puzzleinput.Length

[int[]]$lowpoints = @()

for($i = 0; $i -lt $mapheight; $i++)
{
    for($j = 0; $j -lt $mapwidth; $j++)
    {
        # $puzzleinput[$i][$j]

        [bool]$lowpoint = $false
        
        # If current pos is top left, only check below and to the right
        if($i -eq 0 -and $j -eq 0)
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i+1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j+1]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

           # Write-Output "Top left check: $($lowpoint)"
        }

        # If current pos is top middle, only check left, below and to the right
        elseif($i -eq 0 -and $j -gt 0 -and $j -lt ($mapwidth-1))
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i+1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j+1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j-1]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

          #  Write-Output "Top middle check: $($lowpoint)"
        }

        # If current pos is top right, only check left and below
        elseif($i -eq 0 -and $j -eq ($mapwidth - 1))
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j-1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i+1][$j]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

           # Write-Output "Top right check: $($lowpoint)"
        }

        # If current pos is left middle, only check above, below and to the right
        elseif($i -gt 0 -and $i -lt ($mapheight-1) -and $j -eq 0)
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i-1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j+1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i+1][$j]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

            #Write-Output "Left middle check: $($lowpoint)"
        }

        # If current pos is right middle, only check above, below and to the left
        elseif($i -gt 0 -and $i -lt ($mapheight-1) -and $j -eq ($mapwidth - 1))
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i-1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j-1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i+1][$j]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

           # Write-Output "Right middle check: $($lowpoint)"
        }

        # If current pos is bottom left, only check above and to the right
        elseif($i -eq ($mapheight -1) -and $j -eq 0)
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i-1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j+1]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

            #Write-Output "Bottom left check: $($lowpoint)"
        }

        # If current pos bottom middle, only check left, above and to the right
        elseif($i -eq ($mapheight -1) -and $j -gt 0 -and $j -lt ($mapwidth-1))
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j-1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i-1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j+1]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

           # Write-Output "Bottom middle check: $($lowpoint)"
        }

        # If current pos bottom right, only check left and above
        elseif($i -eq ($mapheight -1) -and $j -eq ($mapwidth-1))
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j-1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i-1][$j]))
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

           # Write-Output "Bottom right check: $($lowpoint)"
        }

        # Else check above, left, right and down
        else
        {
            if(($puzzleinput[$i][$j] -lt $puzzleinput[$i-1][$j]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j-1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i][$j+1]) -and ($puzzleinput[$i][$j] -lt $puzzleinput[$i+1][$j]) )
            {
                $lp = [int]::Parse($puzzleinput[$i][$j])
                $lowpoints += $lp
                $lowpoint = $true
                Write-Output "Found low point of $($puzzleinput[$i][$j])"
            }

        #    Write-Output "Any other check: $($lowpoint)"
        }

    }
}

$summedlowpoints = ($lowpoints | Measure-Object -sum).Sum

$risklevel = $summedlowpoints + $lowpoints.Count

Write-Output "Risk level: $($risklevel)"