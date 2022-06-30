// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// LOOPS - 'for' 'while'

// FOR LOOPS - 'for'
// Run some code for every item in a Collection, or in a custom range

// Example: 'for' Loop that run some code for every item in a Collection
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

//Run the code for every item in 'platforms' Array
for os in platforms {   // 'os' is a temporary 'var' for 'for' loop func
    print("Swift works on \(os).")
}
/* Print Results:
 Swift works on iOS.
 Swift works on macOS.
 Swift works on tvOS.
 Swift works on watchOS.
 */


// Example: 'for' Loop that run some code in a custom range
// Run the code for 12 Iterations (Closed Range 1...12)
for i in 1...12 {   // 'i' is a temporary 'var' for 'for' loop func
    print("5 x \(i) is \(5 * i)")
}
/* Print Results:
 5 x 1 is 5
 5 x 2 is 10
 5 x 3 is 15
 5 x 4 is 20
 5 x 5 is 25
 5 x 6 is 30
 5 x 7 is 35
 5 x 8 is 40
 5 x 9 is 45
 5 x 10 is 50
 5 x 11 is 55
 5 x 12 is 60
 */


// Run the code for 12 Interations (Half-Open Range 1..<13)
for i in 1..<13 {   // 'i' is a temporary 'var' for 'for' loop func
    print("5 x \(i) is \(5 * i)")
}
/* Print Results:
 5 x 1 is 5
 5 x 2 is 10
 5 x 3 is 15
 5 x 4 is 20
 5 x 5 is 25
 5 x 6 is 30
 5 x 7 is 35
 5 x 8 is 40
 5 x 9 is 45
 5 x 10 is 50
 5 x 11 is 55
 5 x 12 is 60
 */


// 'for' loop using '_' to omit the temporary Loop Variable
var lyric = "Haters gonna"

for _ in 1...5 {    // '_' to omit the temporary Loop Variable
    lyric += " hate"    // Add " hate" to 'lyric' Variable for every Loop Iteration
}

print(lyric)    // Prints: "Haters gonna hate hate hate hate hate"
