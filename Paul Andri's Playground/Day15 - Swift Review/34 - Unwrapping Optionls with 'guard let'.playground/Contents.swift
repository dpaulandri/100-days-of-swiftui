// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// UNWRAPPING OPTIONALs with 'guard let'
/* Very similar to `if let' EXCEPT it FLIP THINGS AROUND:
 `if let` runs the code inside its braces { } IF the Optional HAD a value, and
 `guard let` runs the code IF the Optional DIDN’T have a value. */

func printSquare(of number: Int?) {
    guard let number = number else {    // Check if 'func' input value is Valid
        print("Missing input")
        print("Input can't be '\(number)'")// 'else' (IF FAIL) print this & 'return'
        return
    }
    
    // IF Checking SUCCEEDED, 'number' value can be use OUTSIDE the 'guard let' Body
    print("\(number) x \(number) is \(number * number)")
    // Use the VALID 'number' value
}
//COMMENT: use 'guard' to check a Function’s inputs are VALID, Swift REQUIRED you to use 'return' IF the check FAILS. However, IF the Optional you’re unwrapping HAS a value inside, you can use it AFTER the guard code finishes

// Calling 'printSquare' func w/ INVALID value inside the Initializer
printSquare(of: nil)
/* Print Results:
 Missing input
 Input can't be 'nil'
 */

// Calling 'printSquare' func w/ VALID value inside the Initializer
printSquare(of: 2)  //Prints: "2 x 2 is 4"
