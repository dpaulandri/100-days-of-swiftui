// Created by Paul Andri on 27/06/2022

import UIKit


//OPTIONALS - Swift’s solution to "null references"

//A Constant [String: String] Dictionary
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

//Accessing a Dictionary W/O using Optionals
//Attempt to read the value attached to the key “Peach”, which DOESN’T exist & have NO Default Value
let peachOpposite = opposites["Peach"]
print(peachOpposite) //Print: "nil"


//'if let' - The MOST COMMON PRIMARY WAY to Unwrap Optionals
//COMBINES creating a Condition 'if' WITH creating a Constant 'let'
//The Condition’s Body will ONLY be run IF the Optional HAD a value inside
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
//Prints: "Mario's opposite is Wario"


//Creates a 'var' with Optional String Data type set to 'nil'
var username: String? = nil //'String?' Optional set to 'nil'

//Using 'if else' Conditions to Unwrap Optionals
if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}
//Print: "The optional was empty."




//A CURRENTLY EMPTY NON-OPTIONAL DATA TYPE IS NOT THE SAME AS OPTIONAL DATA TYPE SET TO 'nil'
//Ex: Trying to pass an Optional Int into a 'func' that REQUIRES a non-Optional Int
//'func' REQUIRES a non-Optional Int for its "number" Parameter's value
func square(number: Int) -> Int { //'func' will return a non-Optional Int value
    number * number
}

//Create a 'var' with Optional Int Data type set to 'nil'
var number: Int? = nil

//Trying to PASS an Optional Int set to 'nil' to 'square' that REQURIES a non-Optional Int
//print(square(number: number))

/* The LOC above IS NOT VALID!
We CAN’T use an Optional value where a non-Optional is NEEDED:
because IF there were NO value inside we’d hit a problem. */


//To use the Optional we MUST first UNWRAP it
//Unwrapping the Optional Int Data type in 'number' var using 'if let' Condition
//COMBINES creating a Condition 'if' WITH creating a Constant 'let' called 'unwrappedNumber'
//The Condition’s Body will ONLY be run IF the 'number' Optional Int HAD a value inside
if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}

//Using 'if else' Conditions to Unwrap Optionals
if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
} else { //ELSE RUN THIS IF the 'number' Optional Int HAVE NO value inside OR set to 'nil'
    print("Number is an Optional Int set to 'nil'.")
}
//Print: "Number is an Optional Int set to 'nil'."



/* SHADOWING:
 It's very COMMON to Unwrap them into a Constant of the SAME NAME. It's allowed in Swift
 Creates a tempporary second Constant of the SAME NAME (available INSIDE the Condition’s Body ONLY)
 
 INSIDE the Condition’s Body we have an Unwrapped value (a real non-Opt Int) to work with
 OUTSIDE we still have the Optional Int */
//Example:
if let number = number { //Creates a tempporary 'number' Constant of the SAME NAME
    print(square(number: number))
    //We've an Unwrapped value (a real non-Opt Int) available ONLY INSIDE the Condition's Body
}





//OPTIONAL MATERIAL
//Using 'if let' to Unwrap Optional
func getUsername() -> String? { //a 'func' that returns an Optional String value
    "Taylor"
    
}


//Using 'if let' with 'else' Condtions to unwrap 'getUsername's Optional String
if let username = getUsername() {
    //ONLY be run IF the 'getUsername' Optional String HAD a value inside
    print("Username is \(username)")
} else {
    //ELSE RUN THIS IF the 'getUsername' Optional String HAVE NO value inside OR set to 'nil'
    print("No username")
}
//Prints: "Username is Taylor"
