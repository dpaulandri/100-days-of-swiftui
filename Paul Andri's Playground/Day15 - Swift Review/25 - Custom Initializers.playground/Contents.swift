// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// CUSTOM INITIALIZERS - 'init()'
// Special Functions that prepare a new Struct Instance to be used, ensuring ALL Properties have an initial value
// Initializers DON’T have 'func' before them, and DON’T explicitly return a value

// Ex: a Struct w/ Custom Initializer
struct Player {
    let name: String    // Struct's Property
    let number: Int     // Struct's Property

    // Custom Initializers that accept 'name' Param value
    // All Properties in the Struct MUST have a Value when this is done
    init(name: String) {
        // Assign the received 'name' Param value to the Struct's Property of the same name
        self.name = name
        
        // Assign a random 'Int' value between 1-99 to the Struct's'number' Property
        number = Int.random(in: 1...99)
    }
}
