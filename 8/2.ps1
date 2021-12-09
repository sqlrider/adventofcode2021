# https://adventofcode.com/2021/day/8
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

[int[]]$answerarray = @()

# main loop
foreach($row in $puzzleinput)
{
    [string[]]$inputs = @{}
    [string[]]$outputs = @{}

    $inputs += $row.Substring(0, $row.IndexOf("|") - 1).Split(' ')
    $outputs += ($row.Substring($row.IndexOf("|") + 2, $row.Length - $row.IndexOf("|") - 2).Split(' '))

    [char[]]$2signals = @()
    [char[]]$3signals = @()
    [char[]]$4signals = @()
    [char[,]]$5signals = [char[,]]::New(3,5)
    [char[,]]$6signals = [char[,]]::New(3,6)
    [char[]]$7signals = @()

    $5signalcounter = 0
    $6signalcounter = 0

    foreach($input in $inputs)
    {
        switch($input.Length)
        {
            2 { 
                foreach($char in $input.ToCharArray())
                {
                    $2signals += $char  
                }
              }

            3 { 
                foreach($char in $input.ToCharArray())
                {
                    $3signals += $char  
                }
              }

            4 { 
                foreach($char in $input.ToCharArray())
                {
                    $4signals += $char  
                }
              }

            5 { 
                for($i = 0; $i -lt 5; $i++)
                {
                    $5signals[$5signalcounter,$i] = $input[$i]
                }

                $5signalcounter++
              }

            6 { 
                for($i = 0; $i -lt 6; $i++)
                {
                    $6signals[$6signalcounter,$i] = $input[$i]
                }

                $6signalcounter++
              }
        
            7 { 
                foreach($char in $input.ToCharArray())
                {
                    $7signals += $char  
                }
              }
        }
    }

    [char]$RealA = 'x'
    [char]$RealB = 'x'
    [char[]]$CandidateB = @()
    [char]$RealC = 'x'
    [char[]]$CandidateC = @()
    [char]$RealD = 'x'
    [char[]]$CandidateD = @()
    [char]$RealE = 'x'
    [char]$RealF = 'x'
    [char[]]$CandidateF = @()
    [char]$RealG = 'x'


    # Whichever character is in the three signal code but not the two digit code is RealA
    foreach($letter in $3signals)
    {
        if(!($2signals -contains $letter))
        {
            $RealA = $letter
        }
        else
        {
            $CandidateC += $letter
            $CandidateF += $letter
        }
    }

    # Whichever two characters are in the four signal code (dgbe) but not the two digit code (bd)
    # are either bb or dd.
    # dgbe (4) - bd (1) = ge, thus g = bb OR dd and e = bb OR dd
    foreach($letter in $4signals)
    {
        if(!($2signals -contains $letter))
        {
            $CandidateB += $letter
            $CandidateD += $letter
        }

    }

    # Whichever of Candidate C or F in the 6 digit codes (0,6,9) is in three out of three = RealF
    # Whichever of Candidate C or F in the 6 digit codes (0,6,9) is in two out of the three = RealC
    $069ContainsCandidateF_0_Counter = 0

    foreach($6signals_code in $6signals)
    {
        if($6signals_code -contains $CandidateF[0])
        {
            $069ContainsCandidateF_0_Counter++
        }
    }

    if($069ContainsCandidateF_0_Counter -eq 3)
    {
        $RealF = $CandidateF[0]
        $RealC = $CandidateF[1]
    }
    else
    {
        $RealF = $CandidateF[1]
        $RealC = $CandidateF[0]
    }

    # of the 5 signal codes (2,3,5) we identify 2 by the code that contains RealC but not RealF
    # For some reason have to use low level array indexing here instead of -contains
    for($i = 0; $i -lt 3; $i++)
    {
        [bool]$235_RealC = $false
        [bool]$235_RealF = $false

        for($j = 0; $j -lt 5; $j++)
        {
            if($5signals[$i,$j] -eq $RealC)
            {
                $235_RealC = $true
            }
            if($5signals[$i,$j] -eq $RealF)
            {
                $235_RealF = $true
            } 
        }

        if($235_RealC -and !($235_RealF))
        {
            # From 2, whichever of Candidate B or D that exists = RealD , therefore the other = RealB
            for($j = 0; $j -lt 5; $j++)
            {
                if($5signals[$i,$j] -eq $CandidateB[0])
                {
                    $RealD = $5signals[$i,$j]
                    $RealB = $CandidateB[1]
                }
                elseif($5signals[$i,$j] -eq $CandidateB[1])
                {
                    $RealD = $5signals[$i,$j]
                    $RealB = $CandidateB[0]
                }
            }

            break
        }
    }

    # Now we know 5 signals
    # Whichever of the 6 digit codes has all of the signals we know and one more signal, that code is 9. 
    for($i = 0; $i -lt 3; $i++)
    {
        $knownsignals = 0

        for($j = 0; $j -lt 6; $j++)
        {
            if($6signals[$i,$j] -eq $RealA)
            {
                $knownsignals++
            }
            elseif($6signals[$i,$j] -eq $RealB)
            {
                $knownsignals++
            }
            elseif($6signals[$i,$j] -eq $RealC)
            {
                $knownsignals++
            }
            elseif($6signals[$i,$j] -eq $RealD)
            {
                $knownsignals++
            }
            elseif($6signals[$i,$j] -eq $RealF)
            {
                $knownsignals++
            }
            else
            {
                $unknownsignal = $6signals[$i,$j]
            }
        }

        if($knownsignals -eq 5)
        {
            # The signal we don't know is a, so RealG = a.
            $RealG = $unknownsignal

            # There's now only one signal left, which must = RealE
            $stringchars = $RealA + $RealB + $RealC + $RealD + $RealF + $RealG

            if(!($stringchars.Contains('a')))
            {
                $RealE = 'a'
            }
            if(!($stringchars.Contains('b')))
            {
                $RealE = 'b'
            }
            if(!($stringchars.Contains('c')))
            {
                $RealE = 'c'
            }
            if(!($stringchars.Contains('d')))
            {
                $RealE = 'd'
            }
            if(!($stringchars.Contains('e')))
            {
                $RealE = 'e'
            }
            if(!($stringchars.Contains('f')))
            {
                $RealE = 'f'
            }
            if(!($stringchars.Contains('g')))
            {
                $RealE = 'g'
            }
        }
    }

    [string]$Zero = (($RealA + $RealB + $RealC + $RealE + $RealF + $RealG).ToCharArray() | Sort-Object)
    [string]$One = (($RealC + $RealF).ToCharArray() | Sort-Object)
    [string]$Two = (($RealA + $RealC + $RealD + $RealE + $RealG).ToCharArray() | Sort-Object)
    [string]$Three = (($RealA + $RealC + $RealD + $RealF + $RealG).ToCharArray() | Sort-Object)
    [string]$Four = (($RealB + $RealC + $RealD + $RealF).ToCharArray() | Sort-Object)
    [string]$Five = (($RealA + $RealB + $RealD + $RealF + $RealG).ToCharArray() | Sort-Object)
    [string]$Six = (($RealA + $RealB + $RealD + $RealE + $RealF + $RealG).ToCharArray() | Sort-Object)
    [string]$Seven = (($RealA + $RealC + $RealF).ToCharArray() | Sort-Object)
    [string]$Eight = (($RealA + $RealB + $RealC + $RealD + $RealE + $RealF + $RealG).ToCharArray() | Sort-Object)
    [string]$Nine = (($RealA + $RealB + $RealC + $RealD + $RealF + $RealG).ToCharArray() | Sort-Object)

    
    [string]$answers = ''

    # Need to skip first value of output array as for some reason Psh treating it as a hashtable with a phantom first row
    for($i = 1; $i -lt 5; $i++)
    {
        [string]$sorted = ($outputs[$i].ToCharArray() | Sort-Object)
    
        switch($sorted)
        {
            $Zero { $answers += '0' }
            $One  { $answers += '1' }
            $Two  { $answers += '2' }
            $Three { $answers += '3' }
            $Four { $answers += '4' }
            $Five { $answers += '5' }
            $Six  { $answers += '6' }
            $Seven { $answers += '7' }
            $Eight { $answers += '8' }
            $Nine  { $answers += '9' }
        }
    }

    Write-output "Decoded output: $($answers)"

    $answerarray += [int]$answers
}

$total = ($answerarray | Measure-Object -Sum).Sum

Write-Output "Total = $($total)"
