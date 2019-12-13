## Day 4: Secure Container

<#

It is a six-digit number.
The value is within the range given in your puzzle input.
Two adjacent digits are the same (like 22 in 122345).
Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).

#>

function Get-Double {
    param (
        $code
    )
    #Two adjacent digits are the same (like 22 in 122345).
    $codeArray = $code -split '' | Where-Object { $_ }
    for($i = 1; $i -le $codeArray.Count; $i++){
        if($codeArray[$i+1] -and ($codeArray[$i] -eq $codeArray[$i+1])) {
            Return $True
        }
    }
}

function Get-DigitIncrease {
    param (
        $code
    )
    # Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
    $codeArray = $code -split '' | Where-Object { $_ }
    for($i = 1; $i -le $codeArray.Count; $i++){
        if($codeArray[$i+1] -and ($codeArray[$i+1] -ge $codeArray[$i])) {
            Return $True
        }
    }
}

$puzzleInput = @{
    "Low"  = 171309
    "High" = 643603
}
$counter = 0
for ($i = $puzzleInput.Low; $i -le $puzzleInput.High; $i++) {
    if((Get-Double -Code $i) -and (Get-DigitIncrease -code $i)) {
        $i
        $counter ++
    }
}
$counter