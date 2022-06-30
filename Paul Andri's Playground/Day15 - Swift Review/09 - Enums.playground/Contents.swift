// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// ENUMS 'enum' - Complex Data Types
// A set of named Values we can create and use, makes our code more efficient and safer

// Ex: An 'enum' of Weekdays
enum Weekday {
    case Monday, Tuesday, Wednesday, Thursday, Friday
}

// Make an Instance out of 'Weekday' w/ initial case value 'Monday'
var day = Weekday.Monday
// Assign poissibile Enum cases to the Instance
day = .Friday
print(day)
