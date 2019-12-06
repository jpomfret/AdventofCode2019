# Day 1: The Tyranny of the Rocket Equation

## Part 1
$inputData = 137113,91288,62216,61150,143536,69244,102261,105683,58305,67377,107379,108666,56279,123299,120794,60286,112665,144945,100039,60631,77509,106891,103638,132144,119960,96479,131631,105498,124620,88703,101268,72720,135531,108871,90019,129257,69947,69968,104725,95262,119107,111562,81709,102441,129733,84750,101748,107232,113844,115357,125062,83869,69129,79132,144282,115941,144188,58559,92455,135538,146503,142974,73517,112043,143187,130617,144656,114329,130205,92973,134265,120776,62569,145143,131663,130428,121409,109042,111748,99222,102198,63934,130811,139884,107805,107306,140757,149374,119437,131554,55182,69234,54593,92531,69679,111405,143524,66057,93150,53854

function RequiredFuel {
    param (
        $Modules
    )
    $fuel = 0
    foreach ($mass in $modules) {
        $fuel = $fuel + [Math]::Floor($mass / 3) - 2
    }
    $fuel
}

RequiredFuel -Modules $inputdata
# 3490763


## Part 2
function CalcFuelForFuel {
    param (
        $Fuel
    )
    $fuelForFuel = RequiredFuel -Modules $fuel
    $totalFuel = 0
    while ($true) {
        $totalFuel = $totalFuel + $fuelForFuel
        $fuelForFuel = RequiredFuel -Modules $fuelForFuel
        if($fuelForFuel -le 0) {
            break
        }
    }

    return $totalFuel
}

CalcFuelForFuel -Fuel $fuel

function RequiredFuel_v2 {
    param (
        $Modules
    )
    $fuel = 0
    foreach ($mass in $modules) {
        $initalFuel = [Math]::Floor($mass / 3) - 2
        $fuelForFuel = CalcFuelForFuel -Fuel $initalFuel
        $fuel = $fuel + $initalFuel + $fuelForFuel
    }
    $fuel
}

RequiredFuel_v2 -Modules $inputdata
# 3490763
