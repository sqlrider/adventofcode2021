# https://adventofcode.com/2021/day/14
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

class InsertQueue
{
    InsertQueue([int]$input_index, [char]$input_letter)
    {
        $this.index = $input_index
        $this.letter = $input_letter
    }

    [int]$index 
    [char]$letter

}

[string]$polymer = $puzzleinput[0];

# Use a hashtable for rules as patterns are unique
$rules = @{}

foreach($row in $puzzleinput)
{
    if($row -match ('->'))
    {
        $rules.Add($row.Substring(0,2),$row.Substring(6,1))
    }
}

$polymer

# Main loop
for($step = 0; $step -lt 10; $step++)
{
    Write-Output "Step $($step)"

    [InsertQueue[]]$insert_queue = @()

    for($i = 0; $i -lt ($polymer.Length - 1); $i++)
    {
        $currentpair = $polymer[$i] + $polymer[$i+1] 
    
        foreach($key in $rules.Keys)
        {
            if($currentpair -eq $key)
            {
                $insert_queue += [InsertQueue]::New(($i+1), $rules[$key])
            }
        }
    }

    for($i = 0; $i -lt $insert_queue.Length; $i++)
    {
        $polymer = $polymer.Insert(($insert_queue[$i].Index + $i), $insert_queue[$i].Letter)
    }

    $polymer

}

$counts = ($polymer.ToCharArray() | Group | Select Count)

$max = 0
$min = [Int32]::MaxValue

foreach($count in $counts)
{
    if($count.Count -gt $max)
    {
        $max = $count.Count
    }

    if($count.Count -lt $min)
    {
        $min = $count.Count
    }
}

$answer = $max - $min

Write-Output "Answer = $($answer)"