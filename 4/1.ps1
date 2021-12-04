# https://adventofcode.com/2021/day/4
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# There are 100 cards
$number_of_cards = (($puzzleinput.Length) - 1) / 6

# Get list of bingo numbers
$bingonumbers = $puzzleinput[0].Split(',')


# Create a class representing bingo card - with one 5x5 array of numbers, another to flag whether the number has been found or not, and a function to check for a winning line
class BingoCard
{
    [int[,]]$nums = [int[,]]::New(5,5)

    [bool[,]]$found = [bool[,]]::New(5,5)

    [bool]HasWon()
    {
        # Check horizontal lines
        for($a = 0; $a -lt 5; $a++)
        {
            if(($this.found[$a,0] -eq $true) -and ($this.found[$a,1] -eq $true) -and ($this.found[$a,2] -eq $true) -and ($this.found[$a,3] -eq $true) -and ($this.found[$a,4] -eq $true))
            {
                return $true
            }
        }

        # Check vertical lines
        for($a = 0; $a -lt 5; $a++)
        {
            if(($this.found[0,$a] -eq $true) -and ($this.found[1,$a] -eq $true) -and ($this.found[2,$a] -eq $true) -and ($this.found[3,$a] -eq $true) -and ($this.found[4,$a] -eq $true))
            {
                return $true
            }
        }
        
        return $false
    }
}


# Create array of cards, then initialise each card
[BingoCard[]]$card = [BingoCard[]]::New($number_of_cards)

for($a = 0; $a -lt 100; $a++)
{
    $card[$a] = [BingoCard]::New()
}



# Populate bingo cards
for($i = 0; $i -lt $number_of_cards; $i++)
{
    for($j = 0; $j -lt 5; $j++)
    {
        # Need to offset 2 lines from start of input for the list of bingo numbers plus first line of whitespace,
        # 5 * $i for the current bingo card being populated, and $i for the line of whitespace per card
        $currentinputline = $puzzleinput[$j + (5*$i) + $i + 2].Replace('  ',' ').TrimStart(' ').Split(' ')

        for($k = 0; $k -lt 5; $k++)
        {
            $card[$i].nums[$j, $k] = $currentinputline[$k]
            $card[$i].found[$j, $k] = $false;
        }
    }
}



# Iterate over bingo numbers, update cards and check for wins
foreach($bingonumber in $bingonumbers)
{
    for($a = 0; $a -lt 100; $a++)
    {
        for($i = 0; $i -lt 5; $i++)
        {
            for($j = 0; $j -lt 5; $j++)
            {
                if($card[$a].nums[$i, $j] -eq $bingonumber)
                {
                    $card[$a].found[$i, $j] = $true
                    #Write-Output "Found number $($bingonumber) on card $($a)"
                }
            }
        }

        if($card[$a].HasWon() -eq $true)
        {
            Write-Output "Card $($a) has won!"

            # Start by finding the sum of all unmarked numbers on that board,
            # then multiply that sum by the number that was just called when the board won to get the final score
            
            $unmarked_sum = 0

            for($i = 0; $i -lt 5; $i++)
            {
                for($j = 0; $j -lt 5; $j++)
                {
                    if($card[$a].found[$i, $j] -eq $false)
                    {
                        $unmarked_sum += $card[$a].nums[$i, $j]
                    }
                }
            }

            $finalscore = $unmarked_sum * $bingonumber

            Write-Output "Sum of unmarked numbers = $($unmarked_sum), winning number = $($bingonumber), final score = $($finalscore)"

            exit;
        }
    }
}