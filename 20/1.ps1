# https://adventofcode.com/2021/day/20
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# Input is 100x100 and will be expanded by 6 - so create 120x120 array to cover

$initialheight = ($puzzleinput.Length - 2)
$initialwidth = $puzzleinput[2].Length

$height = $initialheight + 20
$width = $initialwidth + 20

[char[][]]$pixel = [char[][]]::New($height,$width)
[char[][]]$pixel_mag2 = [char[][]]::New($height,$width)
[char[][]]$pixel_mag3 = [char[][]]::New($height,$width)


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


for($y = 0; $y -lt $height; $y++)
{
    for($x = 0; $x -lt $width; $x++)
    {
        $pixel[$y][$x] = '.'
        $pixel_mag2[$y][$x] = '.'
        $pixel_mag3[$y][$x] = '.'
    }
}

$algorithm = $puzzleinput[0]

$i = 0
$j = 0

for($a = 10; $a -lt ($height - 10); $a++)
{
    $j = 0;

    for($b = 10; $b -lt ($width - 10); $b++)
    {
        $pixel[$a][$b] = $puzzleinput[($i+2)][$j]

        $j++
    }

    $i++
}


DrawImage -_height $height -_width $width -pixels ([ref]$pixel)

Write-Host ""


# Magnify x2

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

        $pixel_mag2[$a][$b] = $algorithm[$pixelcode]
    }
}

# HACK - now fill in inifinity edges
for($a = 0; $a -lt $height; $a++)
{
    if(($a -eq 0) -or ($a -eq 119))
    {
        for($b = 0; $b -lt $width; $b++)
        {
            $pixel_mag2[$a][$b] = '#'
        }
    }
    else
    {
        $pixel_mag2[$a][0] = '#'
        $pixel_mag2[$a][119] = '#'
    }
}

DrawImage -_height $height -_width $width -pixels ([ref]$pixel_mag2)

Write-Host ""

# Magnify x3

for($a = 1; $a -lt ($height - 1); $a++)
{
    for($b = 1; $b -lt ($width - 1); $b++)
    {
            [string]$pixelcode = ""

            $pixelcode += $pixel_mag2[($a-1)][($b-1)]
            $pixelcode += $pixel_mag2[($a-1)][($b)]
            $pixelcode += $pixel_mag2[($a-1)][($b+1)]
            $pixelcode += $pixel_mag2[($a)][($b-1)]
            $pixelcode += $pixel_mag2[($a)][($b)]
            $pixelcode += $pixel_mag2[($a)][($b+1)]
            $pixelcode += $pixel_mag2[($a+1)][($b-1)]
            $pixelcode += $pixel_mag2[($a+1)][($b)]
            $pixelcode += $pixel_mag2[($a+1)][($b+1)]
        

            $pixelcode = $pixelcode.Replace(".", "0")
            $pixelcode = $pixelcode.Replace("#",'1')

            $pixelcode = [convert]::ToInt32($pixelcode, 2)

            $pixel_mag3[$a][$b] = $algorithm[$pixelcode]
    }
}

DrawImage -_height $height -_width $width -pixels ([ref]$pixel_mag3)

Write-Host ""

$litpixels = 0

for($a = 0; $a -lt $height; $a++)
{
    for($b = 0; $b -lt $width; $b++)
    {
        if($pixel_mag3[$a][$b] -eq '#')
        {
            $litpixels++
        }
    }
}

Write-Host "Total lit pixels = $($litpixels)"