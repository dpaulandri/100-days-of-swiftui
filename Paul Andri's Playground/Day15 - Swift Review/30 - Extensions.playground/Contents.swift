// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// EXTENSION 'extension'
// Extensions let us add Functionality to ANY Type (own or Swift's)
// Ex: Adding an Extension to Swift's 'String' Data Type Functionality
extension String {
    func trimmed() -> String {  // Create a 'func' called 'trimmed'
    self.trimmingCharacters(in: .whitespacesAndNewlines)
    // Using existing Swift's 'String' built-in Method
    }
}

var quoteOfTheDay = "   The truth is rarely pure and never simple   "
let trimmed = quoteOfTheDay.trimmed()   // Call the 'trimmed()' func
print(trimmed)  // Prints: "The truth is rarely pure and never simple"


// Alterntivelt, mark a 'func' as 'mutating' to change a value DIRECTLY
extension String {
    mutating func trim() {  // Mark this 'func' as 'mutating'
        self = self.trimmed()   // Utilised the previous 'trimmed()' func
    }
}

// Call 'trim()' func
quoteOfTheDay.trim()
print(quoteOfTheDay)    // Prints: "The truth is rarely pure and never simple"


// Add Computed Properties using Extension
extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
        // Computation for Computed Property value
    }
}
// COMMENT: The 'components(separatedBy:)' Method splits a String into an Array of Strings using a boundary of our choosing, which in this case is new lines

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
"""

print(lyrics.lines.count) // Prints: 2
/* CODE BREAKDOWN:
 1. Take the Multiple-line String value from 'lyrics' Variable
 2. Run it through our String Extension to create a new 'lines' Variable that will contain Computed Property values from 'lyrics' in a String Array
 3. Use 'String's ' 'count' Functionality to count the number of Item inside 'lines' String Array
*/
