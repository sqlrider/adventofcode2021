# https://adventofcode.com/2021/day/10
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$score = 0

$syntaxhash = @{}

$syntaxhash.Add('{', '}')
$syntaxhash.Add('[', ']')
$syntaxhash.Add('<', '>')
$syntaxhash.Add('(', ')')

foreach($row in $puzzleinput)
{

    [bool]$changesmade = $true

    while(1 -eq 1)
    {
        $startlength = $row.Length

        $row = $row -replace "{}", ""
        $row
        $row = $row -replace [regex]::Escape("[]"),''
        $row
        $row = $row -replace "<>", ""
        $row
        $row = $row -replace [regex]::Escape("()"), ""
        $row

        # As long as we've made a change this loop, carry on
        if($row.Length -eq $startlength)
        {
            break
        }
    }


    [bool]$founderror = $false


    Write-Output "Final output: $($row)"

    for($i = 0; $i -lt ($row.Length -1); $i++)
    {
        switch($row[$i+1])
        {
            "}" { if($row[$i] -ne "{")
                  {
                     $tmp = $syntaxhash[[string]$row[$i]]
                     Write-Output "Error: Expected $($tmp), found $($row[$i+1])"
                     $founderror = $true
                     $score += 1197
                   }
                }
            "]" { if($row[$i] -ne "[")
                  {
                     $tmp = $syntaxhash[[string]$row[$i]]
                     Write-Output "Error: Expected $($tmp), found $($row[$i+1])"
                     $founderror = $true
                     $score += 57
                   }
                }
            ">" { if($row[$i] -ne "<")
                  {
                     $tmp = $syntaxhash[[string]$row[$i]]
                     Write-Output "Error: Expected $($tmp), found $($row[$i+1])"
                     $founderror = $true
                     $score += 25137
                   }
                }
            ")" { if($row[$i] -ne "(")
                  {
                     $tmp = $syntaxhash[[string]$row[$i]]
                     Write-Output "Error: Expected $($tmp), found $($row[$i+1])"
                     $founderror = $true
                     $score += 3
                   }
                }
        }

        if($founderror)
        {
            break
        }
    }

}

Write-Output "Total score = $($score)"
