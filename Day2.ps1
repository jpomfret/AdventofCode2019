# Day 2:
#$InputData = 1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,19,5,23,2,10,23,27,2,27,13,31,1,10,31,35,1,35,9,39,2,39,13,43,1,43,5,47,1,47,6,51,2,6,51,55,1,5,55,59,2,9,59,63,2,6,63,67,1,13,67,71,1,9,71,75,2,13,75,79,1,79,10,83,2,83,9,87,1,5,87,91,2,91,6,95,2,13,95,99,1,99,5,103,1,103,2,107,1,107,10,0,99,2,0,14,0
$InputData = 1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,9,1,19,1,5,19,23,2,9,23,27,1,27,5,31,2,31,13,35,1,35,9,39,1,39,10,43,2,43,9,47,1,47,5,51,2,13,51,55,1,9,55,59,1,5,59,63,2,6,63,67,1,5,67,71,1,6,71,75,2,9,75,79,1,79,13,83,1,83,13,87,1,87,5,91,1,6,91,95,2,95,13,99,2,13,99,103,1,5,103,107,1,107,10,111,1,111,13,115,1,10,115,119,1,9,119,123,2,6,123,127,1,5,127,131,2,6,131,135,1,135,2,139,1,139,9,0,99,2,14,0,0

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
            throw 'something went wrong'
        }
        $position += 4
    }

    $InputData -join ','
}

IntCode -InputData $InputData
#4570637


# Part 2

$originalInputData = 1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,6,1,19,1,19,5,23,2,10,23,27,2,27,13,31,1,10,31,35,1,35,9,39,2,39,13,43,1,43,5,47,1,47,6,51,2,6,51,55,1,5,55,59,2,9,59,63,2,6,63,67,1,13,67,71,1,9,71,75,2,13,75,79,1,79,10,83,2,83,9,87,1,5,87,91,2,91,6,95,2,13,95,99,1,99,5,103,1,103,2,107,1,107,10,0,99,2,0,14,0

$inputTwo = $originalInputData | % {, $_}
$noun = 1
$verb = 0
$attempt = 1
while($true) {
    if($inputTwo[0] -ne 19690720) {

        write-host "attempt $attempt. Noun: $noun. Verb: $Verb"

        $inputTwo = $originalInputData | % {, $_}

        $inputTwo[1] = $noun
        $inputTwo[2] = $verb
        try {
            $result = IntCode -InputData $inputTwo
            if($result -eq 19690720) {
                write-host (100 * $noun * $verb)
                break
            }
        }
        catch {
            throw 'error'
        }

        if($verb -eq 99) {
            $noun += 1
            $verb = 0
        }
        else {
            $verb += 1
        }

        $attempt += 1
    }
    else {
        write-host 'ending'
        break
    }
}

($inputTwo | select -first 5) -join ','