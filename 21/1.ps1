# https://adventofcode.com/2021/day/21
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$p1pos = [int]::Parse($puzzleinput[0].Substring($puzzleinput[0].Length - 1, 1))
$p2pos = [int]::Parse($puzzleinput[1].Substring($puzzleinput[1].Length - 1, 1))

$p1score = 0
$p2score = 0

[int[]]$dice = [int[]]::New(100)

for($a = 0; $a -lt 100; $a++)
{
    $dice[($a)] = ($a+1) 
}

$dicepos = 0

for($i = 0; $i -lt 400; $i++)
{
    # P1
    $dicepos1 = ($dicepos % 100)
    $dicepos2 = (($dicepos + 1) % 100)
    $dicepos3 = (($dicepos + 2) % 100)

    $p1move = $dice[$dicepos1] + $dice[$dicepos2] + $dice[$dicepos3]

    $dicepos += 3

    $p1pos = $p1pos + $p1move

    if(($p1pos) -gt 10)
    {
        $p1pos = $p1pos % 10
    }

    if($p1pos -eq 0)
    {
        $p1pos = 10
    }
    
    $p1score += $p1pos

    if($p1score -ge 1000)
    {
        $answer = $p2score * $dicepos
        Write-Output "P1 wins. P2 score = $($p2score), dice rolled = $($dicepos), answer = $($answer)"

        break
    }


    # P2
    $dicepos1 = ($dicepos % 100)
    $dicepos2 = (($dicepos + 1) % 100)
    $dicepos3 = (($dicepos + 2) % 100)

    $p2move = $dice[$dicepos1] + $dice[$dicepos2] + $dice[$dicepos3]

    $dicepos += 3

    $p2pos = $p2pos + $p2move

    if(($p2pos) -gt 10)
    {
        $p2pos = $p2pos % 10
    }

    if($p2pos -eq 0)
    {
        $p2pos = 10
    }

    $p2score += $p2pos

    if($p2score -ge 1000)
    {
        $answer = $p1score * $dicepos
        Write-Output "P2 wins. P1 score = $($p1score), dice rolled = $($dicepos), answer = $($answer)"

        break
    }

}


