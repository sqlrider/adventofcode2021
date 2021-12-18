# https://adventofcode.com/2021/day/17
# Part 1

$puzzleinput = Get-Content -Path "$($PSScriptRoot)\puzzleinput.txt"

$matches =  ([regex]"-?\d+").Matches($puzzleinput)

$TargetMinX = $matches[0].Value
$TargetMaxX = $matches[1].Value
$TargetMinY = $matches[2].Value
$TargetMaxY = $matches[3].Value

[int[]]$highestpoints = @()

# X velocity can't be more than TargetMaxX
for($initial_x_velocity = 1; $initial_x_velocity -le $TargetMaxX; $initial_x_velocity++)
{
    # Condition is arbitrarily large number, though could be calculated...
    for($initial_y_velocity = 1; $initial_y_velocity -lt 700; $initial_y_velocity++)
    {
        <# 
        The probe's x position increases by its x velocity.
        The probe's y position increases by its y velocity.
        Due to drag, the probe's x velocity changes by 1 toward the value 0; that is, it decreases by 1 if it is greater than 0, increases by 1 if it is less than 0, or does not change if it is already 0.
        Due to gravity, the probe's y velocity decreases by 1.
        #>
        
        $x = 0
        $y = 0
        $xvel = $initial_x_velocity
        $yvel = $initial_y_velocity
        $highest_y = 0

        # Fire probe
        while($y -gt $TargetMinY -and $x -lt $TargetMaxX)
        {
            $x += $xvel
            $y += $yvel

            if($y -gt $highest_y)
            {
                $highest_y = $y
            }

            # Apply drag
            if($xvel -gt 0)
            {
                $xvel--
            }

            # Apply gravity
            $yvel--

            # Check if in target area
            if($x -ge $TargetMinX -and $x -le $TargetMaxX -and $y -ge $TargetMinY -and $y -le $TargetMaxY)
            {
                Write-output "Target hit! Initial velocities: x = $($initial_x_velocity) y = $($initial_y_velocity), highest point: $($highest_y)"
                $highestpoints += $highest_y

                break
            }

        }


    }

}

$highestpoint = ($highestpoints | Measure-Object -Maximum | Select Maximum)

Write-Output "Highest point of valid trajectories = $($highestpoint)"
