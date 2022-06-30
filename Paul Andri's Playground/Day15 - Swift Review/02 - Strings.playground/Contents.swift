// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// STRINGS 'String' - Simple Data Type
// STRINGS ARE CASE-SENSTIVE

// Starts & ends with " "
let actor = "Tom Cruise"


// Works w/ Emoji too
let actorEmoji = "Tom Cruise 🏃‍♂️"


// Use Backslash ' \ ' before ' " ' to use it inside your String
let quote = "He tapped a sign saying \"Believe\" and walked away."


// Use  ' """ """ ' for String values that spans multiple lines
let movie = """
A day in
the life of an
Apple engineer
"""


// '.count' func - read how many item count
print(actor.count)

// '.hasPrefix()' - whether a String starts with specific letters
// '.hasSuffix()' - whether a String ends with specific letters
// Returns Bool: true or false
print(quote.hasPrefix("He"))
print(quote.hasSuffix("Away."))
