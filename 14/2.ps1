# https://adventofcode.com/2021/day/14
# Part 2

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

[string]$base = $puzzleinput[0]

class PolymerRule
{
    PolymerRule([string]$rule)
    {
        $this.element = $rule.Substring(0,2)
        $this.produces += ($rule.Substring(0,1) + $rule.Substring(6,1))
        $this.produces += ($rule.Substring(6,1) + $rule.Substring(1,1))
    }

    [string]$element
    [string[]]$produces = @()
    [long]$count = 0
    [long]$to_add = 0
}

# Need this custom class because hashtable wasn't functioning as per documentation
class ElementCount
{
    ElementCount([string]$element)
    {
        $this.element = $element
        $this.counter = 0
    }

    [string]$element
    [long]$counter
}

[PolymerRule[]]$polymers = @()

[ElementCount[]]$element_counts = @()

foreach($row in $puzzleinput)
{
    if($row -match ('->'))
    {
        $polymers += [PolymerRule]::new($row)

        $exists = $false
        foreach($e in $element_counts)
        {
            if($e.element -eq $row.Substring(6,1))
            {
                $exists = $true
            }
        }
        if($exists -eq $false)
        {
            $element_counts += [ElementCount]::new($row.Substring(6,1))
        }
    }
}


# Add base values
for($i = 0; $i -lt ($base.Length - 1); $i++)
{
    $currentpair = $base[$i] + $base[$i+1] 
    
    foreach($poly in $polymers)
    {
        if($currentpair -eq $poly.element)
        {
            $poly.count++
        }
    }
}

foreach($poly in $polymers)
{
    Write-output "$($poly.element) produces $($poly.produces[0]),$($poly.produces[1]) - count $($poly.count)"
}

Write-Output ""


for($i = 1; $i -lt 41; $i++)
{
    foreach($poly in $polymers)
    {
        if($poly.count -gt 0)
        {
            foreach($poly2 in $polymers)
            {
                if($poly2.element -eq $poly.produces[0])
                {
                    $poly2.to_add += $poly.count
                }
                if($poly2.element -eq $poly.produces[1])
                {
                    $poly2.to_add += $poly.count
                }
            }

        }
    }


    foreach($poly in $polymers)
    {
        $poly.count = $poly.to_add
        $poly.to_add = 0
    }
}

foreach($poly in $polymers)
{
    Write-output "$($poly.element) produces $($poly.produces[0]),$($poly.produces[1]) - count $($poly.count)"
}


foreach($poly in $polymers)
{
    foreach($e in $element_counts)
    {
        if($e.element -eq $poly.element.Substring(0,1))
        {
            $e.counter += $poly.count
        }
        if($e.element -eq $poly.element.Substring(1,1))
        {
            $e.counter += $poly.count
        }
    }
}


$max = 0
$min = [long]::MaxValue

foreach($e in $element_counts)
{
    $realnumber = [Math]::Ceiling($e.counter / 2)
    Write-Output "Element $($e.element) occurs $($realnumber) times"

    if($realnumber -gt $max)
    {
        $max = $realnumber
    }
    if($realnumber -lt $min)
    {
        $min = $realnumber
    }
}

$answer = $max - $min

Write-Output "Answer = $($answer)"