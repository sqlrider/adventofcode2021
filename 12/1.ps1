# https://adventofcode.com/2021/day/12
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

# Reorder input so Start is first cave
for($i = 1; $i -lt $puzzleinput.Length; $i++)
{
    if($puzzleinput[$i] -like "start*")
    {
        $tmp = $puzzleinput[0]
        $puzzleinput[0] = $puzzleinput[$i]
        $puzzleinput[$i] = $tmp

        break
    }   
}

$puzzleinput

# Need a class to represent a cave, that has a name, a type (small or big) and a list of connected caves
class Cave
{
    Cave($cavename)
    {
        $this.Name = $cavename
    }

    [string]$Name

    # This should ideally be an array of pointers to other [Cave] objects, but can't do it in Powershell.
    # So needs to be strings representing caves instead.
    [string[]]$ConnectedCaves
}

# Need a traversal function to be recursively called to traverse the nodes
function Traverse
{
    param(
    [Parameter(Mandatory=$true, Position=0)][Cave]$inputcave,
    [Parameter(Mandatory=$true, Position=1)][string[]]$visited_caves,
    [Parameter(Mandatory=$true, Position=2)][string[]]$route_caves
    )

    if($route_caves[($route_caves.Count-1)] -eq "end")
    {
        $Script:routes += ([string]$route_caves)
        Write-Output "$($route_caves)"
    }

    if($visited_caves -notcontains $inputcave.Name)
    {
        if($inputcave.Name -cmatch "[a-z]")
        {
            $visited_caves += $inputcave.Name
        }

        $route_caves += $inputcave.Name

        foreach($connectedcave in $inputcave.ConnectedCaves)
        {
            foreach($cave in $caves)
            {
                if($cave.Name -eq $connectedcave)
                {
                    Traverse $cave $visited_caves $route_caves
                }
            }
        }

    }
}

[Cave[]]$caves = @()

[string[]]$caveslist = @()

# First get unique list of caves
foreach($row in $puzzleinput)
{
    $pair = $row.Split('-')

    for($i = 0; $i -le 1; $i++)
    {
        if(!$caveslist.Contains($pair[$i]))
        {
            $caveslist += $pair[$i]
        }
    }   
}

# Now populate caves array
foreach($cave in $caveslist)
{
    $caves += [Cave]::New($cave)
}

# Add links between caves
foreach($row in $puzzleinput)
{
    $pair = $row.Split('-')

    foreach($cave in $caves)
    {
        if($cave.Name -eq $pair[0])
        {
            $cave.ConnectedCaves += $pair[1]
        }
    }
}

foreach($row in $puzzleinput)
{
    $pair = $row.Split('-')

    foreach($cave in $caves)
    {
        if($cave.Name -eq $pair[1])
        {
            $cave.ConnectedCaves += $pair[0]
        }
    }
}

[string[]]$visitedcaves = @()
$visitedcaves += "."

[string[]]$routecaves = @()
$routecaves += "."

[string[][]]$Script:routes = @()

Traverse $caves[0] $visitedcaves $routecaves

$Script:routes | Select -Unique

$numroutes = ($Script:routes | Select -Unique | Measure-Object).Count

Write-Output ""
Write-Output "Number of routes = $($numroutes)"

