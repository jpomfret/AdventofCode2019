# Day 2:
$InputData = 1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,19,5,23,2,10,23,27,2,27,13,31,1,10,31,35,1,35,9,39,2,39,13,43,1,43,5,47,1,47,6,51,2,6,51,55,1,5,55,59,2,9,59,63,2,6,63,67,1,13,67,71,1,9,71,75,2,13,75,79,1,79,10,83,2,83,9,87,1,5,87,91,2,91,6,95,2,13,95,99,1,99,5,103,1,103,2,107,1,107,10,0,99,2,0,14,0


# Part 1 - restore the gravity assist program (your puzzle input) to the "1202 program alarm"
$InputData[1] = 12
$InputData[2] = 2

function intcode {
    param (
        $InputData
    )

    $position = 0
    while ($position -lt $InputData.Length) {
        #Write-Host ('Working on {0}' -f $position)
        $int = $InputData[$position]
        $valueOne = $InputData[$position+1]
        $valueTwo = $InputData[$position+2]
        $storeIn = $InputData[$position+3]

        if ($int -eq 1) {
            # add
            #write-host "Adding value from position $valueOne ($($InputData[$valueOne])) with position $valueTwo ($($InputData[$valueTwo])) and then storing in position $StoreIn"
            $InputData[$storeIn] = $InputData[$valueOne] + $InputData[$valueTwo]
        }
        elseif ($int -eq 2) {
            # multiply
            #write-host "Adding value from position $valueOne ($($InputData[$valueOne])) with position $valueTwo ($($InputData[$valueTwo])) and then storing in position $StoreIn"
            $InputData[$storeIn] = $InputData[$valueOne] * $InputData[$valueTwo]
        }
        elseif ($int -eq 99) {
            #write-host '99'
            $position = $InputData.Length
        }
        else {
            end 'something went wrong'
        }
        $position += 4
    }

    $InputData -join ','
}

IntCode -InputData $InputData
#4570637

# Part 2

$InputData = 1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,19,5,23,2,10,23,27,2,27,13,31,1,10,31,35,1,35,9,39,2,39,13,43,1,43,5,47,1,47,6,51,2,6,51,55,1,5,55,59,2,9,59,63,2,6,63,67,1,13,67,71,1,9,71,75,2,13,75,79,1,79,10,83,2,83,9,87,1,5,87,91,2,91,6,95,2,13,95,99,1,99,5,103,1,103,2,107,1,107,10,0,99,2,0,14,0

$inputTwo = $InputData
$noun = 1
$verb = 0
$attempt = 1
while($true) {
    if($inputTwo[0] -ne 19690720) {

        write-host "attempt $attempt. Noun: $noun. Verb: $Verb"

        $inputTwo = $InputData
        $inputTwo[1] = $noun
        $inputTwo[2] = $verb

        IntCode -InputData $inputTwo

        $noun += 1
        $attempt += 1
    }
    else {
        write-host 'ending'
        break
    }
}

($inputTwo | select -first 5) -join ','