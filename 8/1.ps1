# https://adventofcode.com/2021/day/8
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

[string[]]$outputs = @{}

foreach($row in $puzzleinput)
{
    $outputs += $row.Substring($row.IndexOf("|") + 2, $row.Length - $row.IndexOf("|") - 2).Split(' ')
}

$2347signals = 0

foreach($output in $outputs)
{
    switch($output.Length)
    {
        2 { $2347signals++ }
        3 { $2347signals++ }
        4 { $2347signals++ }
        7 { $2347signals++ }
    }
}

Write-Output "Number of 1,4,7,8 digits: $($2347signals)"