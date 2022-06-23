import UIKit


//SWITCH STATEMENT to check Multiple Conditions

//WEATHER FORECAST Example Codes
enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

//Using IF - ELSE IF - ELSE (NOT ADVISABLE! REPETITIVE!)
if forecast == .sun {
    print("It should be a nice day.")
} else if forecast == .rain {
    print("Pack an umbrella.")
} else if forecast == .wind {
    print("Wear something warm")
} else if forecast == .rain { //<- Wrong Enum Case name, it was supposed to be ".snow"
    print("School is cancelled.")
    //Causes School to be cancelled when "rain" instead of the intended ".snow
} else {
    print("Our forecast generator is broken!")
}
//Result: "It should be a nice day."

//Using SWITCH STATEMENT (CLEANER CODE! NOT REPETITIVE!)
//SWITCX only allowed the checking of each Enum Case ONCE
//SWITCH BLOCKs are EXHAUSTIVE, covering & enforcing all the Enum Cases value to be checked
switch forecast {
    case .sun: // ":" when "true", run the loc below
        print("It should be a nice day.")
    case .rain: // ":" when "true", run the loc below
        print("Pack an umbrella.")
    case .wind: // ":" when "true", run the loc below
        print("Wear something warm")
    case .snow: // ":" when "true", run the loc below
        print("School is cancelled.")
    case .unknown: // When the value of "forecast" Constant is unknown, run the loc below
        print("Our forecast generator is broken!")
}
//Result: "It should be a nice day."


//SWITCHing with String Enum - "DEFAULT" Case
//"default" NEEDs TO BE PLACED AFTER all the other Enum Cases
//Xcode will trigger an Error if there're other Cases placed AFTER "default"
let place = "Metropolis"

switch place {
    case "Gotham": //IF "place" = "Gotham"
        print("You're Batman!")
    case "Mega-City One": //IF "place" = "Mega-City On"
        print("You're Judge Dredd!")
    case "Wakanda": //IF "place" = "Wakanda"
        print("You're Black Panther!")
    default: //The "default" Enum Case to fallback on
        print("Who are you?")
}
//Result: "Who are you?"



//SWITCHing with Int Enum - "FALLTHROUGH"
//Code w/o "FALLTHROUGH" - execute code of matched Enum Case and STOP
let day = 5
print("My true love gave to me…")

switch day {
    case 5: //Retuns: "true"
    print("5 golden rings") // execute this loc and STOP
    case 4:
    print("4 calling birds")
    case 3:
    print("3 French hens")
    case 2:
    print("2 turtle doves")
    default:
    print("A partridge in a pear tree")
}
//Result: "5 golden rings"

//Rewritten with "FALLTHROUGH" - execute code of matched Enum Case & continue checking
let dayFT = 5
print("My true love gave to me…")

switch dayFT {
    case 5: //Retuns: "true"
        print("5 golden rings") // execute this loc
        fallthrough //continue execute next locs
    case 4:
        print("4 calling birds") // execute this loc
        fallthrough
    case 3:
        print("3 French hens") // execute this loc
        fallthrough
    case 2:
        print("2 turtle doves") // execute this loc
        fallthrough
    default:
        print("A partridge in a pear tree") // execute this loc
}
/*Results:
"5 golden rings"
"4 calling birds"
"3 French hens"
"2 turtle doves"
"A partridge in a pear tree"
*/
