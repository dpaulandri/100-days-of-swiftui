// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// DEFAULT PARAMETER VALUE
// Write an equals '=' AFTER the Type THEN provide a Default Value

// Ex: 'func' with a Default value for its Parameter
// 'formal' has a 'Bool' Default value 'false'
func greet(_ person: String, formal: Bool = false) {
    if formal { // IF 'formal' is 'true'
        print("Welcome, \(person)!")
    } else { // ELSE (IF 'formal' is 'false')
        print("Hi, \(person)!")
    }
}

// 2 ways of calling 'greet()'
// 1. Provide ALL values back to the Parameters in the Initailizer
greet("Tim", formal: true)  // Prints: "Welcome, Tim!"

// 2. Provide value back only to Parameter 'person' in the Initailizer
// Swift will use the Default value 'false' for the Parameter 'formal'
greet("Taylor") // Prints: "Hi, Taylor!/"
