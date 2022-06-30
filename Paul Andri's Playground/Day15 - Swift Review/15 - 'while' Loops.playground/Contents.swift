// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// WHILE LOOPS - 'while'
// Execute their Loop Body until a Condition is 'false'

// Example:
var count = 10

while count > 0 {   // KEEP RUNNING WHILE 'count' value is MORE THAN 0
    print("\(count)…")  // Print this
    count -= 1  // Substract 1 from 'count's value
}
/* Print Results:
 10…
 9…
 8…
 7…
 6…
 5…
 4…
 3…
 2…
 1…
*/
print("Go!")    // Prints: "Go!"


// Use 'continue' to SKIP the current Loop iIeration AND proceed to the following one
let files = ["work.txt", "me.jpg", "sophie.jpg"]

for file in files { // Run this 'for' Loop for every item in 'files' Array
    // IF temp 'file' value HAS NO '.jpg' Suffix (end): RUN THE BODY CODE
    if file.hasSuffix(".jpg") == false {
        continue    // SKIP CURRENT LOOP ITERATION & RUN THE NEXT LOOP ITERATION (item)
    }
    // PRINT THIS IF temp 'file' value HAS '.jpg' Suffix (end)
    print("Found picture: \(file)")
}
/* Print Results:
 Found picture: me.jpg
 Found picture: sophie.jpg
 */


// Use 'break' to EXIT a Loop and SKIP ALL remaining iterations
for file in files { // Run this 'for' Loop for every item in 'files' Array
    // IF temp 'file' value HAS NO '.jpg' Suffix (end): RUN THE BODY CODE
    if file.hasSuffix(".jpg") == false {
        break    // SKIP CURRENT LOOP ITERATION & EXIT ENTIRE LOOP FUNCTION
    }
    // PRINT THIS IF temp 'file' value HAS '.jpg' Suffix (end)
    print("Found picture: \(file)")
}   // Prints NOTHING
