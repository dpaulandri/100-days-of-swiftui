// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// PARAMETER LABELS
// Use '_' If we DON’T want to pass a Parameter’s name when calling a Function
// An alternative is to write a SECOND NAME before the FIRST:
// one to use OUTSIDE, and one INSIDE the 'func's Body

//Ex: Used '_' to hide Parameter's EXT name,
// 'string' is used ONLY INSIDE the 'func' Body
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLd"
// Check whether 'string' value is ALL Uppercased Letters, returns 'Bool'
let resultString = isUppercase(string)  //Return 'false'


// Ex: Write an INTERNAL & EXTERNAL Parameter names
// 'for' is used OUTSIDE the 'func' Body, ie. at the Call Site's Initializers
// 'number' is used INSIDE the 'func' Body
func printTimesTables(for number: Int) {
    for i in 1...12 {   // 'for' Loop that'll run for 12 Iterations
        print("\(i) x \(number) is \(i * number)")
    }
}

// 'func' Call Site
printTimesTables(for: 5)    // Uses 'for' the EXTERNAL Parameter name
/* Print Results:
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
 */
