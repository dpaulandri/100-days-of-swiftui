// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// OPTIONAL CHAINING '?'
// Optional chaining reads Optionals inside Optionals
// “IF the Optional HAS a value inside, Unwrap it, THEN…” and add more code

// Ex:
let names = ["Arya", "Bran", "Robb", "Sansa"]   // a [String]

// Create a new 'let' w/ Optional Chaining
let chosen = names.randomElement()?.uppercased()
// CODE LOGIC: IF we got a random element from the Array, then, UPPERCASE it.

print("Next in line: \(chosen ?? "No one")")
