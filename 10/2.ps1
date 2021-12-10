# https://adventofcode.com/2021/day/10
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

[long[]]$completionscores = @()

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
        $row = $row -replace [regex]::Escape("[]"),''
        $row = $row -replace "<>", ""
        $row = $row -replace [regex]::Escape("()"), ""

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

    # If $founderror = false, the line is incomplete, not incorrect
    # Since we've already trimmed the string down to what needs adding, it just needs reversing
    if($founderror -eq $false)
    {
        [long]$completionscore = 0
        Write-Output "Line is incomplete"
        $completionstring = $row.ToCharArray()

        [array]::Reverse($completionstring)
    
        # Add up points
        for($i = 0; $i -lt $completionstring.Length; $i++)
        {
            $completionscore *= 5

            switch($completionstring[$i])
            {
                '(' { $completionscore += 1 }
                '[' { $completionscore += 2 }
                '{' { $completionscore += 3 }
                '<' { $completionscore += 4 }
            }
        }

        Write-Output "Completion score = $($completionscore)"
        $completionscores += $completionscore
    }
}

Write-Output "Total incorrect syntax score = $($score)"

# Get median value of array

$sortedscores = $completionscores | Sort-Object
$middlepos = ((($sortedscores.Length + 1) / 2) - 1) # -1 as scores array is 0-indexed
$middlescore = $sortedscores[$middlepos]

Write-Output "Middle completion score = $($middlescore)"

