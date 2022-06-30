// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// ARRAYS '[ ]' - Complex Data Type
// Group Itmes into an Array Collection

// Array Examples:
var colors = ["Red", "Green", "Blue"]   // 'String' Array
let numbers = [4, 8, 15, 16]    // 'Int' Array
var readings = [0.1, 0.5, 0.8]  // 'Double' Array


// Read Data from Array by using its Index #/ Indecis (start from 0)
// Code will CRASH IF an item DIDN'T exists at the Index
print(colors[0])    // '0' = 1st Position - Prints: "Red"
print(readings[2])  // '2' = 3rd Position - Prints: "0.8"

// Use 'append()' to add new items into a 'var' type Array
// The type of Data you add must match whatever was already in there
colors.append("Tartan")
// Add a new 'String' value "Tartan" into the existing 'colors' 'String' type 'var' Array


// Has its own useful Functionalities, such as:
// '.count' - count how many items are in an Array
colors.remove(at: 0)    // Remove the item at Index position '0'

// 'remove(at:)'' - remove one item at a specific Index
print(colors.count) // Count how many items are in 'colors' Array

// '.contains()'- check whether an Array contains a particular item
print(colors.contains("Octarine"))
// check whether 'colors' Array contains "Octarine"
