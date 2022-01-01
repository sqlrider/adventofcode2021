# https://adventofcode.com/2021/day/25
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

[int]$gridheight = $puzzleinput.Length
[int]$gridwidth = $puzzleinput[0].Length

$puzzleinput = [char[][]]$puzzleinput

[bool[][]]$canmove = [bool[][]]::New($gridheight, $gridwidth)


# Too slow drawing the grid for actual puzzle input - debug purposes only
function DrawCucumbers([int]$height, [int]$width, [char[][]][ref]$grid)
{
    for($y = 0; $y -lt $height; $y++)
    {
        for($x = 0; $x -lt $width; $x++)
        {
            Write-Host -NoNewline "$($grid[$y][$x])"
        }

        Write-Host ""
    }

    Write-Host ""
}

# DrawCucumbers -height $gridheight -width $gridwidth -grid ([ref]$puzzleinput)

[bool]$moves = $true
$steps = 0

while($moves)
{
    Write-Host "Step $($steps)"
    $moves = $false
    $steps++

    # Reset canmove flag
    for($y = 0; $y -lt $gridheight; $y++)
    {
        for($x = 0; $x -lt $gridwidth; $x++)
        {
            $canmove[$y][$x] = $false
        }
    }

    # During a single step, the east-facing herd moves first, then the south-facing herd moves
    # So east-facing first
    # Just checking if it can move or not
    for($y = 0; $y -lt $gridheight; $y++)
    {
        for($x = 0; $x -lt $gridwidth; $x++)
        {
            # If east-facing cucumber
            if($puzzleinput[$y][$x] -eq '>')
            {
                # Is it at the edge of the map ?
                if($x -eq ($gridwidth - 1))
                {
                    # Check leftmost square
                    if($puzzleinput[$y][0] -eq '.')
                    {
                        $canmove[$y][$x] = $true
                    }
                }
                else
                {
                    if($puzzleinput[$y][($x+1)] -eq '.')
                    {
                        $canmove[$y][$x] = $true
                    }
                }
            }
        }
    }

    # Now actually move

    for($y = 0; $y -lt $gridheight; $y++)
    {
        for($x = 0; $x -lt $gridwidth; $x++)
        {
            # If east-facing cucumber
            if($puzzleinput[$y][$x] -eq '>')
            {
                # Is it at the edge of the map ?
                if($x -eq ($gridwidth - 1))
                {
                    # Check leftmost square
                    if($puzzleinput[$y][0] -eq '.')
                    {
                        if($canmove[$y][$x])
                        {
                            $moves = $true
                            $puzzleinput[$y][$x] = '.'
                            $puzzleinput[$y][0] = '>'
                        }
                    }
                }
                else
                {
                    if($puzzleinput[$y][($x+1)] -eq '.')
                    {
                        # Move cucumber east
                        if($canmove[$y][$x])
                        {
                            $moves = $true
                            $puzzleinput[$y][$x] = '.'
                            $puzzleinput[$y][($x+1)] = '>'
                        }
                    }
                }
            }
        }
    }

    # Reset canmove flag
    for($y = 0; $y -lt $gridheight; $y++)
    {
        for($x = 0; $x -lt $gridwidth; $x++)
        {
            $canmove[$y][$x] = $false
        }
    }

    #Then south-facing
    for($y = 0; $y -lt $gridheight; $y++)
    {
        for($x = 0; $x -lt $gridwidth; $x++)
        {
            # If south-facing cucumber
            if($puzzleinput[$y][$x] -eq 'v')
            {
                # Is it at the edge of the map?
                if($y -eq ($gridheight - 1))
                {
                    # Check topmost square
                    if($puzzleinput[0][$x] -eq '.')
                    {
                        $canmove[$y][$x] = $true
                    }

                }
                else
                {
                    if($puzzleinput[($y+1)][$x] -eq '.')
                    {
                        # Move cucumber south
                        $canmove[$y][$x] = $true
                    }
                }
            }
        }
    }

    # Now actually move
    for($y = 0; $y -lt $gridheight; $y++)
    {
        for($x = 0; $x -lt $gridwidth; $x++)
        {
            # If south-facing cucumber
            if($puzzleinput[$y][$x] -eq 'v')
            {
                # Is it at the edge of the map?
                if($y -eq ($gridheight - 1))
                {
                    # Check topmost square
                    if($puzzleinput[0][$x] -eq '.')
                    {
                        if($canmove[$y][$x])
                        {
                            $moves = $true
                            $puzzleinput[$y][$x] = '.'
                            $puzzleinput[0][$x] = 'v'
                        }
                    }

                }
                else
                {
                    if($puzzleinput[($y+1)][$x] -eq '.')
                    {
                        # Move cucumber south
                        if($canmove[$y][$x])
                        {
                            $moves = $true
                            $puzzleinput[$y][$x] = '.'
                            $puzzleinput[($y+1)][$x] = 'v'
                        }
                    }
                }
            }
        }
    }

    # DrawCucumbers -height $gridheight -width $gridwidth -grid ([ref]$puzzleinput)

}

Write-Host "No moves after $($steps) steps"

DrawCucumbers -height $gridheight -width $gridwidth -grid ([ref]$puzzleinput)