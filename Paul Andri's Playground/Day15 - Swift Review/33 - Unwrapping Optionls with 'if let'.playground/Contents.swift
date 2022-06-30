// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// UNWRAPPING OPTIONALs
// Swift WON’T let us use Optional Data DIRECTLY, because it MIGHT BE EMPTY. That means we NEED to Unwrap the Optional to use it – we need to look inside to see IF there’s a value, and, IF THERE IS, take it out and use it.


// UNWRAPPING OPTIONAL with 'if let'
// `if let` runs the code inside its braces { } IF the Optional HAD a value
// The MOST COMMON way for Unwrapping Optionals
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
// Prints: "Mario's opposite is Wario"
// COMMENT: That reads the Optional value from the Dictionary, and IF it has a String inside it gets Unwrapped – the String inside gets placed into the marioOpposite Constant, and ISN’T Optional any more. Because we were ABLE to Unwrap the Optional, the Condition is a SUCCESS so the print() code is run.
