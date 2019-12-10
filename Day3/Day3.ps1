function Get-AllCoordinates {
    param (
        $currentCoord,
        $move
    )
    $allCoords = @()

    $currentX = $currentCoord.X
    $currentY = $currentCoord.Y

    $moveSpaces = [convert]::ToInt32($move.Substring(1,$move.Length-1),10)

    if ($move[0] -eq 'R') {
        for ($i=0; $i -le $moveSpaces; $i++) {
            $allCoords += New-Object -TypeName psobject -Property @{
                'x' = $currentX
                'y' = ($currentY + $i)
            }
        }
    }
    elseif ($move[0] -eq 'L') {
        for ($i=0; $i -le $moveSpaces; $i++) {
            $allCoords += New-Object -TypeName psobject -Property @{
                'x' = $currentX
                'y' = ($currentY - $i)
            }
        }
    }
    elseif ($move[0] -eq 'U') {
        for ($i=0; $i -le $moveSpaces; $i++) {
            $allCoords += New-Object -TypeName psobject -Property @{
                'x' = ($currentX + $i)
                'y' = ($currentY)
            }
        }
    }
    elseif ($move[0] -eq 'D') {
        for ($i=0; $i -le $moveSpaces; $i++) {
            $allCoords += New-Object -TypeName psobject -Property @{
                'x' = ($currentX - $i)
                'y' = ($currentY)
            }
        }
    }
    $allCoords
}


function Get-WireCoordinates {
    param (
        $WireMoves
    )
    $WireCoord = @()
    foreach($move in $WireMoves) {
        if($WireCoord) {
            $currentOneCoord = $WireCoord[-1]
        }
        else {
            $currentOneCoord = New-Object -TypeName psobject -Property @{
                'x' = 0
                'y' = 0
            }
        }
        $WireCoord += Get-AllCoordinates -currentCoord $currentOneCoord -Move $move
    }
    $WireCoord
}


function Get-ManhattanDistance {
    param (
        $coords
    )

    foreach ($c in $coords) {
        if($c.X -ne 0 -and $c.Y -ne 0) {
            $mh = [math]::abs($c.X) + [math]::abs($c.Y)
            New-Object -TypeName psobject -Property @{
                'Coord' = $c
                'ManhattanDistance' = $mh
            }
        }
    }
}

#$wireOne = "R8","U5","L5","D3"
#$wireTwo = "U7","R6","D4","L4"

$wireOne = (get-content .\Day3\Wire1.txt) -split (',')
$wireTwo = (get-content .\Day3\Wire2.txt) -split (',')

$WireOneCoords = Get-WireCoordinates -WireMoves $wireOne | Select * -Unique | Sort-Object
$WireTwoCoords = Get-WireCoordinates -WireMoves $wireTwo | Select * -Unique | Sort-Object

$crosses = Compare-Object -DifferenceObject  $WireOneCoords -ReferenceObject $WireTwoCoords -IncludeEqual -Property y,x -ExcludeDifferent -PassThru | select x,y

Get-ManhattanDistance -coords $crosses | sort ManhattanDistance



