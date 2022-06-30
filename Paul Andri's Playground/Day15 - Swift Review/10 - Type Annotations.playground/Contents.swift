// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// TYPE ANNOTATIONS
// Force a specific Type for a new 'var' or 'let'

// Create a new 'var' with a Type Annotation set to 'Double'
var scoreType: Double = 0
// Without the ': Double', Swift would infer that to be an 'Int'
print(scoreType)    // Prints: 0.0 <- Stored & printed as a 'Double' value


// Examples of different Type Annotations
let player: String = "Roy"  // 'String' TA
var luckyNumber: Int = 13   // 'Int' TA
let pi: Double = 3.141  // 'Double' TA
var isEnabled: Bool = true  // 'Bool' TA
var albums: Array<String> = ["Red", "Fearless"] // '[String]' TA
// [String: String] TA
var userDict: Dictionary<String, String> = ["id": "@twostraws"]
// 'Set([String])' TA
var books: Set<String> = Set(["The Bluest Eye", "Foundation"])

// Special Syntax for Arrays & Dictionaries TA
var albumsSArr: [String] = ["Red", "Fearless"]  // '[String]' TA
var userSDict: [String: String] = ["id": "@twostraws"]   // [String: String] TA


// Knowing the exact Types of things is IMPORTANT for creating empty Collections
// Ex: Both of these create empty String Arrays
var teams: [String] = [String]()
var clues = [String]()


// Values of an ENUM have the SAME TYPE as the Enum itself
enum UIStyle {
    case light, dark, system
}

var style: UIStyle = .light
