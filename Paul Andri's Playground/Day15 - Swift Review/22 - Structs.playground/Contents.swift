// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// STRUCTS 'struct'
// Syntax: 'struct Name { }'
// Create custom Data Types, complete w/ Properties and Methods
// Because Structs are Data Types, it's name starts w/ UPPERCASE LETTER

// Ex: a Struct w/ its Properties ('var' or 'let') & Methods ('func')
struct Album {  // a 'struct' named 'Album'
    let title: String   // Struct's Property
    let artist: String   // Struct's Property
    var isReleased = true   // Struct's Property w/ Default Value

    func printSummary() {   // Struct's Method, accepts NO Param
        print("\(title) by \(artist)")
    }
}

// Create an Instance of the Struct w/ Initializer
let red = Album(title: "Red", artist: "Taylor Swift")
print(red.title)    // Print 'red' Instance's 'title' value
// Prints: "Red"
red.printSummary()  // Call 'red' Instance's 'printSummary()' Method
// Prints: "Red by Taylor Swift"


// Mark a Method as 'mutating func' IF we want it to be able to change its Struct's Property value(s)
struct Example {
    var isReleased = true
    
    mutating func removeFromSale() {    // Marked as a 'mutating' Method
        isReleased = false
        // Change 'isReleased' Property value to 'false'
    }
}
