# https://adventofcode.com/2021/day/6
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$fishinput = $puzzleinput.Split(',')

# There are 300 initial fish
$initial_num_fish = $fishinput.Count

Class LanternFish
{
    [int]$Lifecycle

    LanternFish([int]$initial_lifecycle)
    {
        $this.Lifecycle = $initial_lifecycle
    }

    # Function to advance the fish's lifecycle, and also return $true if a new fish should be spawned
    [bool]Cycle()
    {
        if($this.Lifecycle -gt 0)
        {
            $this.Lifecycle--

            return $false
        }    
        else
        {
            $this.Lifecycle = 6
            
            return $true
        }
    }
}

# Declare a dynamically sized array of fish
[System.Collections.ArrayList]$fish = @()
# [LanternFish[]]$fish = @()

foreach($initial_lifecycle in $fishinput)
{
    $fish.Add([LanternFish]::New($initial_lifecycle)) | Out-Null
}

# How many lanternfish would there be after 80 days?

for($i = 0; $i -lt 80; $i++)
{
    # Need to grab the fish count here as $fish.Count is updated in real time during next loop leading to new fish being cycled in same turn
    $applicable_fish = $fish.Count

    for($j = 0; $j -lt $applicable_fish; $j++)
    {
        if($fish[$j].Cycle())
        {
            $fish.Add([LanternFish]::New(8)) | Out-Null
        }
    }

    Write-Output "Day $($i): $($fish.Count) fish"
}