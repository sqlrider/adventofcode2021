# https://adventofcode.com/2021/day/20
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# Input is 100x100 and will be expanded by 100x100 - so create 300x300 array to cover
$initialheight = ($puzzleinput.Length - 2)
$initialwidth = $puzzleinput[2].Length

$height = $initialheight + 200
$width = $initialwidth + 200

[char[][]]$pixel = [char[][]]::New($height,$width)

function DrawImage([char[][]][ref]$pixels, [int]$_height, [int]$_width)
{
    for($y = 0; $y -lt $_height; $y++)
    {
        for($x = 0; $x -lt $_width; $x++)
        {
            Write-Host $pixels[$y][$x] -NoNewline
        }

        Write-Host ""
    }
}

# Hack around the infinite edge problem
function HackEdges([int]$inputheight, [int]$inputwidth, [char[][]][ref]$pixels)
{
    for($a = 0; $a -lt $inputheight; $a++)
    {
        if(($a -eq 0) -or ($a -eq 299))
        {
            for($b = 0; $b -lt $inputwidth; $b++)
            {
                $pixels[$a][$b] = '#'
            }
        }
        else
        {
            $pixels[$a][0] = '#'
            $pixels[$a][299] = '#'
        }
    }
}

# Blank out initial pixel array
for($y = 0; $y -lt $height; $y++)
{
    for($x = 0; $x -lt $width; $x++)
    {
        $pixel[$y][$x] = '.'
    }
}

$algorithm = $puzzleinput[0]

# Fill initial pixel array
$i = 0
$j = 0

for($a = 100; $a -lt ($height - 100); $a++)
{
    $j = 0;

    for($b = 100; $b -lt ($width - 100); $b++)
    {
        $pixel[$a][$b] = $puzzleinput[($i+2)][$j]

        $j++
    }

    $i++
}


$steps = 0

while($steps -lt 50)
{
    $steps++

    Write-Host "Step $($steps)"

    # Create magnified grid and blank it out
    [char[][]]$pixel_magnified = [char[][]]::New($height,$width)
    for($y = 0; $y -lt $height; $y++)
    {
        for($x = 0; $x -lt $width; $x++)
        {
            $pixel_magnified[$y][$x] = '.'
        }
    }

    # Magnify and fill new pixel grid
    for($a = 1; $a -lt ($height - 1); $a++)
    {
        for($b = 1; $b -lt ($width - 1); $b++)
        {
            [string]$pixelcode = ""

            $pixelcode += $pixel[($a-1)][($b-1)]
            $pixelcode += $pixel[($a-1)][($b)]
            $pixelcode += $pixel[($a-1)][($b+1)]
            $pixelcode += $pixel[($a)][($b-1)]
            $pixelcode += $pixel[($a)][($b)]
            $pixelcode += $pixel[($a)][($b+1)]
            $pixelcode += $pixel[($a+1)][($b-1)]
            $pixelcode += $pixel[($a+1)][($b)]
            $pixelcode += $pixel[($a+1)][($b+1)]
        
            $pixelcode = $pixelcode.Replace(".", "0")
            $pixelcode = $pixelcode.Replace("#",'1')

            $pixelcode = [convert]::ToInt32($pixelcode, 2)

            $pixel_magnified[$a][$b] = $algorithm[$pixelcode]
        }
    }

    # Fill in infinity edges if loop is an odd number
    if($steps % 2 -eq 1)
    {
        HackEdges -inputheight $height -inputwidth $width -pixels ([ref]$pixel_magnified)
    }

    # Set pixel array to the magnified one to use as base in next iteration
    $pixel = $pixel_magnified
}

Write-Host "Final State"
Write-Host ""
DrawImage -_height $height -_width $width -pixels ([ref]$pixel)
Write-Host ""

$litpixels = 0

for($a = 0; $a -lt $height; $a++)
{
    for($b = 0; $b -lt $width; $b++)
    {
        if($pixel[$a][$b] -eq '#')
        {
            $litpixels++
        }
    }
}

Write-Host "Total lit pixels = $($litpixels)"