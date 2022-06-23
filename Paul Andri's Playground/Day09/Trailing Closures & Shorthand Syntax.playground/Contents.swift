import UIKit


//TRAILING CLOSURES & SHORTHAND SYNTAX

//The Sorting Closure codes
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

print(captainFirstTeam)



//Sorting Closure rewritten - omitting Data Types in Parameters list
//'name1' & 'name2' Data Types omitted, because they MUST be Strings
// '-> Bool' ommitted, because it MUST be Bool
let captainFirstTeam = team.sorted(by: { name1, name2 in
    if name1 == "Suzanne" { //'name1' compares to a String value
        return true //'return' type 'true' Bool
    } else if name2 == "Suzanne" { //'name2' compares to a String value
        return false //'return' type 'false' Bool
    }

    return name1 < name2
})




//Sorting Closure rewritten - Trailing Closure syntax
// Removed '(by: )'
let captainFirstTeam = team.sorted { name1, name2 in
    if name1 == "Suzanne" { //'name1' compares to a String value
        return true //'return' type 'true' Bool
    } else if name2 == "Suzanne" { //'name2' compares to a String value
        return false //'return' type 'false' Bool
    }

    return name1 < name2
}




//Sorting Closure rewritten - Shorthand Syntax
//Removed 'name1' & 'name2' Param names
//Swift provided us with Parameter names
let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" { //'$0' = first STring parameter name
        return true
    } else if $1 == "Suzanne" { //'$4' = second STring parameter name
        return false
    }

    return $0 < $1 //'$0' & '$1' Shorthand Syntax
}
//SHORTHAND SYNTAX IS NOT RECOMMENDED THE CLOSURE ABOVE, BECAUSE WE'RE USING EACH VALUE MORE THAN ONCE



//SHORTHAND SYNTAX in CLOSURES with SIMPLE FUNCTION CALLS
//SHORTHAND SYNTAX is suite for a simpler Function calls
//Ex: if we just wanted a simple Reverse Sort
let reverseTeam = team.sorted {
    return $0 > $1 //Uses Shorthand Syntax
    //'$0 > $1' = '$0' have higher Index number than '$1'
    //Reverse Alphabetical Sort
}

//Closure Rewritten
//Closures with single Line of Code can OMIT 'return' Keyword
let reverseTeam = team.sorted { $0 > $1 }



//CLOSURES with '.fliter()' function
//'filter()' function lets us run some code on every item in the Array, and will send back a new Array containing every item that returns 'true' for the function
//Ex: Find all team players whose name begins with "T"
let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly) //Result: ["Tiffany", "Tasha"]



//CLOSURES with '.map()' function
//'map()' function lets us transform every item in the Array using some code of our choosing, and sends back a new Array of all the transformed item
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)
//Result: print ["GLORIA", "SUZANNE", "PIPER", "TIFFANY", "TASHA"]






//OPTIONAL MATERIALS

//TRAILING CLOSURE SYNTAX

//Ex: a Function that accepts a Double then a Closure full of changes to make
func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}

//Call 'animate' Function W/O a Trailing Closure
animate(duration: 3, animations: {
    print("Fade out the image")
})


//Call 'animate' Function WITH a Trailing Closure
animate(duration: 3) {
    print("Fade out the image")
}
