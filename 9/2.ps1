# https://adventofcode.com/2021/day/9
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# Get bounds of map
$mapwidth = $puzzleinput[0].Length 
$mapheight = $puzzleinput.Length

[int[,]]$map = [int[,]]::New(($mapheight + 2), ($mapwidth + 2))

# Set borders to 9
for($a = 0; $a -lt $mapwidth + 2; $a++)
{
    $map[0,$a] = 9
    $map[($mapheight+1),$a] = 9
}
for($b = 0; $b -lt $mapheight + 2; $b++)
{
    $map[$b,0] = 9
    $map[$b,($mapwidth + 1)] = 9
} 

# Fill map
for($i = 0; $i -lt $mapheight; $i++)
{
    for($j = 0; $j -lt $mapwidth; $j++)
    {
        $map[($i+1),($j+1)] = [int]::Parse($puzzleinput[$i][$j])
    }

}

# Recursive function to get basin sizes
function GetBasin([int]$y, [int]$x)
{
    if($Script:alreadychecked -contains "$($y) $($x)")
    {
        return
    }

    $Script:basinsize++

    $Script:alreadychecked += "$($y) $($x)"

    # Check above
    if($map[($y-1),$x] -ne 9)
    {
        GetBasin ($y-1) $x
    }

    # Check left
    if($map[$y,($x-1)] -ne 9)
    {
        GetBasin $y ($x-1)
    }

    # Check right
    if($map[$y,($x+1)] -ne 9)
    {
        GetBasin $y ($x+1)
    }

    # Check below
    if($map[($y+1),$x] -ne 9)
    {
        GetBasin ($y+1) $x
    }
}

[int[]]$lowpoints = @()
[int[]]$basinsizes = @()


for([int]$i = 1; $i -lt $mapheight + 1; $i++)
{
    for([int]$j = 1; $j -lt $mapwidth + 1; $j++)
    {

        [bool]$lowpoint = $false
        

        if(($map[$i,$j] -lt $map[($i-1),($j-1)]) -and `
           ($map[$i,$j] -lt $map[($i-1),$j]) -and `
           ($map[$i,$j] -lt $map[($i-1),($j+1)]) -and `
           ($map[$i,$j] -lt $map[$i,($j-1)]) -and `
           ($map[$i,$j] -lt $map[$i,($j+1)]) -and `
           ($map[$i,$j] -lt $map[($i+1),($j-1)]) -and `
           ($map[$i,$j] -lt $map[($i+1),$j]) -and `
           ($map[$i,$j] -lt $map[($i+1),($j+1)]))
        {
            $lp = $map[$i,$j]
            $lowpoints += $lp
            $lowpoint = $true
            Write-Output "Found low point of $($map[$i,$j])"

            $Script:basinsize = 0
            [string[]]$Script:alreadychecked = @()

            GetBasin $i $j

            Write-Output "Basin size = $($Script:basinsize)"

            $basinsizes += $Script:basinsize

        }
    }
}


[int[]]$top3 = $basinsizes | Sort-Object -Descending | Select-Object -First 3

[int]$answer = $top3[0] * $top3[1] * $top3[2]

Write-Output "Answer = $($answer)"