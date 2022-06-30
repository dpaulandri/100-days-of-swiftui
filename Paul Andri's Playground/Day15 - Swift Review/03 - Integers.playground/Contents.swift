// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// INTEGERS 'Int' - Simple Data Type
// WHOLE NUMBERS

// Supports a range of standard mathematical operators
let score = 10
let higherScore = score + 10
let halvedScore = score / 2


// Supports Compound Assignment Operators that modify Variables in place
var counter = 10
counter += 5 // Add 5 to current 'counter' value


// Has its own useful Functionalities, such as:
// 'isMultiple(of:)' Method - check whether an Int value is a mutiple of x
let number = 120
print(number.isMultiple(of: 3)) // Check whether 'number' value is a multiple of 3
// Returns Bool: true or false

// 'Int.random(in: x...y) - make random Integers in a specific range
let id = Int.random(in: 1...1000)   // '1...100' 1-100 Closed Range Operator
