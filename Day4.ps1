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
    $good = $true
    for($i = 0; $i -le $codeArray.Count-1; $i++){
        if($codeArray[$i+1] -and ($codeArray[$i] -gt $codeArray[$i+1])) {
            $good = $false
        }
    }
    return $good
}


$puzzleInput = @{
    "Low"  = 171309
    "High" = 643603
}

<#
$Stepone = @()
for ($i = $puzzleInput.Low; $i -le $puzzleInput.High; $i++) {
    if(Get-DigitIncrease -code $i) {
        $i
        $stepOne += $i
    }
}


$code = $puzzleInput.Low

$codeArray = $code -split '' | Where-Object { $_ }

$codeArray
#>
<#
function Set-Digit {
    param (
        $code,
        $digit,
        $value
    )
    $codeArray = $code -split '' | Where-Object { $_ }
    $codeArray[$digit] = $value

    return $codeArray -join ''

}
#>


# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
$code = $puzzleInput.Low
$Stepone = @()
while ($code -lt $puzzleInput.High) {
    if($code -le $puzzleInput.High) {
        $codeArray = $code -split '' | Where-Object { $_ }

        if ($codeArray[1..5] -join '' -eq '99999') {
            $codeArray[0] = [int32]$codeArray[0] + 1
            $code = [int32]$code + 1
        }

        for($i = 1; $i -le $codeArray.Count-1; $i++){
            $i
            if ($codeArray[$i] -lt $codeArray[$i+1]) {
                $codeArray[$i]
                $codeArray[$i] = [int32]$codeArray[$i] + 1
            }
        }

    }
    $code = $codeArray -join ''
    if (Get-DigitIncrease -Code $code) {
        $code
        $stepOne += $code
    }
}