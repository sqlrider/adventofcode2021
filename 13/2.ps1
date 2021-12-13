# https://adventofcode.com/2021/day/13
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

[int]$length = 0
[int]$height = 0

[string[]]$fold_directions = @()
[int[]]$fold_values = @()

foreach($row in $puzzleinput)
{
    # If it's a coordinate row
    if($row -notlike "fold*" -and $row -ne "")
    {
        $coords = $row.Split(',')

        if([Int32]::Parse($coords[0]) -gt $length)
        {
            $length = [Int32]::Parse($coords[0])
        }
        if([Int32]::Parse($coords[1]) -gt $height)
        {
            $height = [Int32]::Parse($coords[1])
        }
    }
    elseif($row -ne "") # it's a fold
    {
        $foldline = $row.Substring($row.IndexOf('=') + 1,$row.Length - 13)

        if($row -match "x")
        {
            $fold_directions += "x"
            $fold_values += [Int32]::Parse($foldline)
        }
        if($row -match 'y')
        {
            $fold_directions += "y"
            $fold_values += [Int32]::Parse($foldline)
        }
    }
}

$length++
$height++

Write-Output "Length of grid is $($length)"
Write-Output "height of grid is $($height)"

[int[,]]$grid = [int[,]]::New($height,$length)
foreach($row in $puzzleinput)
{
    if($row -notlike "fold*" -and $row -ne "")
    {
        $coords = $row.Split(',')
        $x = [Int32]::Parse($coords[0])
        $y = [Int32]::Parse($coords[1])
    
        $grid[$y,$x] = 1
    }
}

function CountDots
{
    Param([int[,]][ref]$inputgrid,
    [int]$gridheight,
    [int]$gridlength)

    [int]$dots = 0

    for($i = 0; $i -lt $gridheight; $i++)
    {
        for($j = 0; $j -lt $gridlength; $j++)
        {
            # Write-Host -NoNewline $inputgrid[$i,$j]
            
            if($inputgrid[$i,$j] -gt 0)
            {
                $dots++
            }
        }
    }

    Write-Output "Dots: $($dots)"
}

# Added for part 2 to draw the final grid, instead of counting dots
function DrawDots
{
    Param([int[,]][ref]$inputgrid,
    [int]$gridheight,
    [int]$gridlength)

    [int]$dots = 0

    for($i = 0; $i -lt $gridheight; $i++)
    {
        for($j = 0; $j -lt $gridlength; $j++)
        {
            # Write-Host -NoNewline $inputgrid[$i,$j]
            
            if($inputgrid[$i,$j] -gt 0)
            {
                Write-Host -NoNewline "#"
            }
            else
            {
                Write-Host -NoNewline "."
            }
        }

        Write-Host ""
    }
}

$xfold = $length
$yfold = $height

CountDots ([ref]$grid) $height $length

for($i = 0; $i -lt $fold_directions.Count; $i++)
{
    Write-Output "Folding $($fold_directions[$i]) $($fold_values[$i])"

    if($fold_directions[$i] -eq 'x')
    {
        $xfold = $fold_values[$i]

        for($y = 0; $y -lt $yfold; $y++)
        {
            for($x = 1; $x -le $xfold; $x++)
            {
                $grid[$y,($xfold-$x)] += $grid[$y,($x + $xfold)]
            }
        }
    }
    if($fold_directions[$i] -eq 'y')
    {
        $yfold = $fold_values[$i]

        for($x = 0; $x -lt $length; $x++)
        {
            for($y = 1; $y -le $yfold; $y++)
            {
                $grid[($yfold-$y),$x] += $grid[($y + $yfold),$x]
            }
        }
    }

    CountDots ([ref]$grid) $yfold $xfold
}

DrawDots ([ref]$grid) $yfold $xfold
