# https://adventofcode.com/2021/day/5
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# There are 500 vents
$num_vents = $puzzleinput.Count

# Create a ThermalVent (vector) class with flag for direction
Class ThermalVent
{
    [int]$x1
    [int]$y1
    [int]$x2
    [int]$y2

    [string]$LineType

    SetLineType()
    {
        if($this.x1 -eq $this.x2)
        {
            $this.LineType = 'vertical'
        }
        elseif($this.y1 -eq $this.y2)
        {
            $this.LineType = 'horizontal'
        }
        else
        {
            $this.LineType = 'diagonal'
        }
    }

}

# Create and initialise all vents
[ThermalVent[]]$vent = [ThermalVent[]]::New($num_vents)

for($a = 0; $a -lt $num_vents; $a++)
{
    $vent[$a] = [ThermalVent]::New()
}


# Load vents array
for($a = 0; $a -lt $num_vents; $a++)
{
    $coords = $puzzleinput[$a].Replace(' -> ', ',').Split(',')

    $vent[$a].x1 = $coords[0]
    $vent[$a].y1 = $coords[1]
    $vent[$a].x2 = $coords[2]
    $vent[$a].y2 = $coords[3]

    $vent[$a].SetLineType()

}

# Initialise grid
[int[,]]$grid = [int[,]]::New(1000,1000)


# Loop through vents and add to grid
for($a = 0; $a -lt $num_vents; $a++)
{
    if($vent[$a].LineType -eq 'horizontal')
    {
        if($vent[$a].x1 -lt $vent[$a].x2) # left to right
        {
            for($i = $vent[$a].x1; $i -le $vent[$a].x2; $i++)
            {
                $grid[$i,$vent[$a].y1]++
            }
        }

        if($vent[$a].x1 -gt $vent[$a].x2) # right to left
        {
            for($i = $vent[$a].x1; $i -ge $vent[$a].x2; $i--)
            {
                $grid[$i,$vent[$a].y1]++
            }
        }
    }

    if($vent[$a].LineType -eq 'vertical')
    {
        if($vent[$a].y1 -lt $vent[$a].y2) # descending
        {
            for($i = $vent[$a].y1; $i -le $vent[$a].y2; $i++)
            {
                $grid[$vent[$a].x1,$i]++
            }
        }

        if($vent[$a].y1 -gt $vent[$a].y2) # ascending
        {
            for($i = $vent[$a].y1; $i -ge $vent[$a].y2; $i--)
            {
                $grid[$vent[$a].x1,$i]++
            }
        }
    }

    if($vent[$a].LineType -eq 'diagonal')
    {
        # Descending to right
        if(($vent[$a].x2 -gt $vent[$a].x1) -and ($vent[$a].y2 -gt $vent[$a].y1))
        {
            $steps = 0

            for($i = $vent[$a].x1; $i -le $vent[$a].x2; $i++)
            {
                $grid[$i,(($vent[$a].y1) + $steps)]++

                $steps++
            }
        }

        # Ascending to right
        if(($vent[$a].x2 -gt $vent[$a].x1) -and ($vent[$a].y2 -lt $vent[$a].y1))
        {
            $steps = 0

            for($i = $vent[$a].x1; $i -le $vent[$a].x2; $i++)
            {
                $grid[$i,(($vent[$a].y1) - $steps)]++

                $steps++
            }
        }

        # Descending to left
        if(($vent[$a].x2 -lt $vent[$a].x1) -and ($vent[$a].y2 -gt $vent[$a].y1))
        {
            $steps = 0

            for($i = $vent[$a].x1; $i -ge $vent[$a].x2; $i--)
            {
                $grid[$i,(($vent[$a].y1) + $steps)]++

                $steps++
            }
        }

        # Ascending to left
        if(($vent[$a].x2 -lt $vent[$a].x1) -and ($vent[$a].y2 -lt $vent[$a].y1))
        {
            $steps = 0

            for($i = $vent[$a].x1; $i -ge $vent[$a].x2; $i--)
            {
                $grid[$i,(($vent[$a].y1) - $steps)]++

                $steps++
            }
        }
    }
}

$total = 0

for($i = 0; $i -lt 1000; $i++)
{
    for($j = 0; $j -lt 1000; $j++)
    {
        if($grid[$i,$j] -gt 1)
        {
            $total++
        }
    }
}

Write-Output "Total overlapping vents = $($total)"