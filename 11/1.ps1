# https://adventofcode.com/2021/day/11
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# Helper function to keep main loop smaller
function DrawGrid([int[,]]$grid)
{
    for($i = 1; $i -lt 11; $i++)
    {
        Write-Output "$($grid[$i,1])$($grid[$i,2])$($grid[$i,3])$($grid[$i,4])$($grid[$i,5])$($grid[$i,6])$($grid[$i,7])$($grid[$i,8])$($grid[$i,9])$($grid[$i,10])"
    }
}

[int[,]]$octopus = [int[,]]::New(12,12)
[int]$flashes = 0

# Populate octopus (int) array
for($i = 1; $i -lt 11; $i++)
{
    for($j = 1; $j -lt 11; $j++)
    {
        $octopus[$i,$j] = [Int32]::Parse($puzzleinput[$i-1][$j-1])
    }
}

Write-Output "--- Step 0 ---"
DrawGrid($octopus)

for($steps = 1; $steps -lt 101; $steps++)
{
    [bool]$hit10occured = $false

    # Need to keep track of which octopus has flashed already
    [bool[,]]$hasflashed = [bool[,]]::New(12,12)

    # Loop through grid once incrementing energy levels, handle flashes after
    for($i = 1; $i -lt 11; $i++)
    {
        for($j = 1; $j -lt 11; $j++)
        {
            $octopus[$i,$j]++
            if($octopus[$i,$j] -eq 10)
            {
                $octopus[$i,$j] = 0
                $hit10occured = $true
            }
        }
    }

    if($hit10occured)
    {
        # Now handle flashes...
        <# This increases the energy level of all adjacent octopuses by 1, including octopuses that are diagonally adjacent.
           If this causes an octopus to have an energy level greater than 9, it also flashes.
           This process continues as long as new octopuses keep having their energy level increased beyond 9. #>

        [bool]$flashoccuredthisround = $true

        while($flashoccuredthisround)
        {
            $flashoccuredthisround = $false

            for($a = 1; $a -lt 11; $a++)
            {
                for($b = 1; $b -lt 11; $b++)
                {
                    # If octopus energy is 0 and hasflashed = false, set hasflashed flag and increase energy for all surrounding octopii,
                    # as long such octopii have energy < 10
                    if($octopus[$a,$b] -eq 0 -and $hasflashed[$a,$b] -eq $false)
                    {
                        $flashoccuredthisround = $true
                        $hasflashed[$a,$b] = $true
                        $flashes++

                        # Top left
                        if($octopus[($a-1),($b-1)] -ne 0)
                        {
                            $octopus[($a-1),($b-1)]++

                            if($octopus[($a-1),($b-1)] -eq 10)
                            {
                                $octopus[($a-1),($b-1)] = 0
                            }
                        }

                        # Top middle
                        if($octopus[($a-1),($b)] -ne 0)
                        {
                            $octopus[($a-1),($b)]++

                            if($octopus[($a-1),($b)] -eq 10)
                            {
                                $octopus[($a-1),($b)] = 0
                            }
                        }

                        # Top right
                        if($octopus[($a-1),($b+1)] -ne 0)
                        {
                            $octopus[($a-1),($b+1)]++

                            if($octopus[($a-1),($b+1)] -eq 10)
                            {
                                $octopus[($a-1),($b+1)] = 0
                            }
                        }

                        # Left
                        if($octopus[($a),($b-1)] -ne 0)
                        {
                            $octopus[($a),($b-1)]++

                            if($octopus[($a),($b-1)] -eq 10)
                            {
                                $octopus[($a),($b-1)] = 0
                            }
                        }

                        # Right
                        if($octopus[($a),($b+1)] -ne 0)
                        {
                            $octopus[($a),($b+1)]++

                            if($octopus[($a),($b+1)] -eq 10)
                            {
                                $octopus[($a),($b+1)] = 0
                            }
                        }

                        # Bottom left
                        if($octopus[($a+1),($b-1)] -ne 0)
                        {
                            $octopus[($a+1),($b-1)]++

                            if($octopus[($a+1),($b-1)] -eq 10)
                            {
                                $octopus[($a+1),($b-1)] = 0
                            }
                        }

                        # Bottom middle
                        if($octopus[($a+1),($b)] -ne 0)
                        {
                            $octopus[($a+1),($b)]++

                            if($octopus[($a+1),($b)] -eq 10)
                            {
                                $octopus[($a+1),($b)] = 0
                            }
                        }

                        # Bottom right
                        if($octopus[($a+1),($b+1)] -ne 0)
                        {
                            $octopus[($a+1),($b+1)]++

                            if($octopus[($a+1),($b+1)] -eq 10)
                            {
                                $octopus[($a+1),($b+1)] = 0
                            }
                        }
                    
                    }
                }
            }
        }
    }
    
    Write-Output ""
    Write-Output "--- Step $($steps) ---"
    DrawGrid($octopus)
}

Write-Output "Total octopus flashes = $($flashes)"