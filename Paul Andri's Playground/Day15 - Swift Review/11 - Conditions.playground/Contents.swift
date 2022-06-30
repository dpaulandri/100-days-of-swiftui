// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// CONDITIONS - 'if' 'else' 'else if' STATEMENTS
// Use to check a Condition and run some code as appropriate

//Ex:
let ageNow = 16

if ageNow < 12 {
    print("You can't vote")
} else if ageNow < 18 {
    print("You can vote soon.")
} else {
    print("You can vote now.")
}
// Prints: "You can vote soon."


// Use AND '&&' & OR '||' to combine two Conditions
let temp = 26
// '&&' AND
if temp > 20 && temp < 30 { // IF temp > 20 AND temp < 30
    print("It's a nice day.")
}   // Prints: "It's a nice day."

// '||' OR
if temp > 20 || temp < 30 { // IF temp > 20 OR temp < 30
    print("It's a nice day.")
}   // Prints: "It's a nice day."
