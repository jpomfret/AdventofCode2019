function Get-LineCoordinates {
    param (
        $currentCoord,
        $currentCount,
        $move
    )

    $lineCoord = New-Object -TypeName psobject -Property @{
        'start' = $currentCoord
        'end' = $null
        'count' = $currentCount
    }

    $newX = $currentCoord.X
    $newY = $currentCoord.Y

    $moveSpaces = [convert]::ToInt32($move.Substring(1,$move.Length-1),10)
    $lineCoord.count += $moveSpaces

    switch ($move[0]) {
        'R' {$newX += $moveSpaces}
        'L' {$newX -= $moveSpaces}
        'U' {$newY += $moveSpaces}
        'D' {$newY -= $moveSpaces}
    }

    $lineCoord.end = New-Object -TypeName psobject -Property @{
        'x' = $newX
        'y' = $newY
    }

    $lineCoord
}

function Get-AllLines {
    param (
        $wireMoves
    )

    $current = New-Object -TypeName psobject -Property @{
        'x' = 0
        'y' = 0
    }
    $lines = @()

    foreach($move in $wireMoves) {
        $WireOneCoords = Get-LineCoordinates -currentCoord $current -move $move -currentCount $WireOneCoords.Count
        $current = $WireOneCoords.end
        $lines += $WireOneCoords
    }

    return $lines
}

function get-intersect {
    param (
        $lineOne,
        $lineTwo
    )
    #Line AB represented as a1x + b1y = c1
    $a = New-Object -TypeName psobject -Property @{
        'x' = $lineOne.start.x
        'y' = $lineOne.start.y
    }
    $b = New-Object -TypeName psobject -Property @{
        'x' = $lineOne.end.x
        'y' = $lineOne.end.y
    }
    $a1 = $b.y - $a.y
    $b1 = $a.x - $b.x
    $c1 = $a1 * $a.x + $b1 * $a.y

    #Line CD represented as a2x + b2y = c2
    $c = New-Object -TypeName psobject -Property @{
        'x' = $lineTwo.start.x
        'y' = $lineTwo.start.y
    }
    $d = New-Object -TypeName psobject -Property @{
        'x' = $lineTwo.end.x
        'y' = $lineTwo.end.y
    }
    $a2 = $d.y - $c.y
    $b2 = $c.x - $d.x
    $c2 = $a2 * $c.x + $b2 * $c.y

    $determinant = $a1 * $b2 - $a2 * $b1

    if ($determinant -ne 0)
    {
        $x = ($b2 * $c1 - $b1 * $c2) / $determinant;
        $y = ($a1 * $c2 - $a2 * $c1) / $determinant;
        # make sure x is on the lines
        if((($x -ge $a.x -and $x -le $b.x) -or ($x -ge $b.x -and $x -le $a.x)) -and (($x -ge $c.x -and $x -le $d.x) -or ($x -ge $d.x -and $x -le $c.x))) {
            # make sure y is on the lines
            if((($y -ge $a.y -and $y -le $b.y) -or ($y -ge $b.y -and $y -le $a.y)) -and (($y -ge $c.y -and $y -le $d.y) -or ($y -ge $d.y -and $y -le $c.y))) {
                New-Object -TypeName psobject -Property @{
                    'x' = $x
                    'y' = $y
                    'lineOnecount' = $lineOne.count - [math]::abs($x - $b.x) - [math]::abs($y - $b.y)
                    'lineTwocount' = $lineTwo.count - [math]::abs($x - $d.x) - [math]::abs($y - $d.y)
                }
            }
        }
    }
}

function Get-ManhattanDistance {
    param (
        $coords
    )

    foreach ($c in $coords) {
        if($c.X -ne 0 -or $c.Y -ne 0) {
            $mh = [math]::abs((0 - [math]::abs($c.X)) + (0 - [math]::abs($c.Y)))
            New-Object -TypeName psobject -Property @{
                'Coord' = $c
                'ManhattanDistance' = $mh
            }
        }
    }
}
#part 1

$wireOne = (get-content .\Day3\Wire1.txt) -split (',')
$wireTwo = (get-content .\Day3\Wire2.txt) -split (',')

$wireOneLines = Get-AllLines -wireMoves $wireOne
$wireTwoLines = Get-AllLines -wireMoves $wireTwo

$crosses = @()
foreach ($lineOne in $wireOneLines) {
    foreach($linetwo in $wireTwoLines) {
        $crosses += get-intersect -lineOne $lineOne -lineTwo $lineTwo
    }
}

Get-ManhattanDistance -coords $crosses | sort ManhattanDistance | select -first 1
#227


#part 2


$wireOne = (get-content .\Day3\Wire1.txt) -split (',')
$wireTwo = (get-content .\Day3\Wire2.txt) -split (',')

$wireOneLines = Get-AllLines -wireMoves $wireOne
$wireTwoLines = Get-AllLines -wireMoves $wireTwo

$crosses = @()
foreach ($lineOne in $wireOneLines) {
    foreach($linetwo in $wireTwoLines) {
        $crosses += get-intersect -lineOne $lineOne -lineTwo $lineTwo |
        select x,y,lineonecount,linetwocount, @{l='TotalDistance';e={($_.linetwocount + $_.lineOnecount)}}
    }
}

$crosses | sort TotalDistance | ft
#20286