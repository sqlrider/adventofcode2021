# https://adventofcode.com/2021/day/6
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$fishinput = $puzzleinput.Split(',')

# There are 300 initial fish
$initial_num_fish = $fishinput.Count

[long]$fishstate_0 = 0
[long]$fishstate_1 = 0
[long]$fishstate_2 = 0
[long]$fishstate_3 = 0
[long]$fishstate_4 = 0
[long]$fishstate_5 = 0
[long]$fishstate_6 = 0
[long]$fishstate_7 = 0
[long]$fishstate_8 = 0

foreach($initial_fish in $fishinput)
{
    switch($initial_fish)
    {
        0 { $fishstate_0++ }
        1 { $fishstate_1++ }
        2 { $fishstate_2++ }
        3 { $fishstate_3++ }
        4 { $fishstate_4++ }
        5 { $fishstate_5++ }
        6 { $fishstate_6++ }
        7 { $fishstate_7++ }
        8 { $fishstate_8++ }
    }
}

for($i = 0; $i -lt 256; $i++)
{
    # Take a snapshot of current values, as process happens simultaneously for each state
    $temp_0 = $fishstate_0
    $temp_1 = $fishstate_1
    $temp_2 = $fishstate_2
    $temp_3 = $fishstate_3
    $temp_4 = $fishstate_4
    $temp_5 = $fishstate_5
    $temp_6 = $fishstate_6
    $temp_7 = $fishstate_7
    $temp_8 = $fishstate_8

    # Now progress lifecycle - each day, fish at lifecycle 8 to 1 are decremented, while fish at 0 move to 6 and create another lifecycle 8 fish

    $fishstate_0 = $temp_1

    $fishstate_1 = $temp_2
    $fishstate_2 = $temp_3
    $fishstate_3 = $temp_4
    $fishstate_4 = $temp_5
    $fishstate_5 = $temp_6

    $fishstate_6 = $temp_7 + $temp_0
    $fishstate_7 = $temp_8
    $fishstate_8 = $temp_0
}

Write-Output "Fish at lifecycle 0: $($fishstate_0)"
Write-Output "Fish at lifecycle 1: $($fishstate_1)"
Write-Output "Fish at lifecycle 2: $($fishstate_2)"
Write-Output "Fish at lifecycle 3: $($fishstate_3)"
Write-Output "Fish at lifecycle 4: $($fishstate_4)"
Write-Output "Fish at lifecycle 5: $($fishstate_5)"
Write-Output "Fish at lifecycle 6: $($fishstate_6)"
Write-Output "Fish at lifecycle 7: $($fishstate_7)"
Write-Output "Fish at lifecycle 8: $($fishstate_8)"

[long]$totalfish = $fishstate_0 + $fishstate_1 + $fishstate_2 + $fishstate_3 + $fishstate_4 + $fishstate_5 + $fishstate_6 + $fishstate_7 + $fishstate_8

Write-Output "Total fish: $($totalfish)"
