// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// FUNCTIONS 'func'
// Syntax: 'func funcName(parameters) { }

// Ex: Create a new 'func'
// Parameter 'number' accept 'Int' type Argument value
func printTimesTables(number: Int) {
    for i in 1...12 {   // 'for' Loop that runs for 12 Iterations
        print("\(i) x \(number) is \(i * number)")
    }
}

//'func' Call Site
printTimesTables(number: 5) // Provided 5 as an Int Argument value for 'number' Param
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



// Ex: Dice Rool 'func' that returns an 'Int' value
func rollDice() -> Int {    // '-> Int' returns an 'Int' value
    return Int.random(in: 1...6) // return an random Int value between 1-6
}

// 'func' Call Site
let result = rollDice()
print(result)   // Prints a random Int value returned from 'rollDice()' func


// We can remove 'return' keyword for 'func' that contains only a SINGLE loc
func singleCode() -> Int {
    Int.random(in: 1...100) // return an random Int value between 1-100
}

// 'func' Call Site
print(singleCode()) // Prints a random Int value returned from 'rollDice()' func
