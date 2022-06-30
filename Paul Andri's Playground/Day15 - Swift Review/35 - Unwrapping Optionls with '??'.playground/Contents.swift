// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// UNWRAPPING OPTIONALs with NIL COALESCING Operator '??'
// Unwraps an Optional AND provides a Default value IF the Optional was EMPTY

// Ex: Providing a Default value using '??' in case a Constant Array is EMPTY
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
// Use '??' to provid a Default value IN CASE FAILED
let favorite = tvShows.randomElement() ?? "None"


// Ex: Use '??' to provide a Default value when creating an 'Int' Constant
let input = ""  // a 'let' with EMPTY 'String' type data

// Trying to create an 'Int' value out of 'input'
let numberInt = Int(input) ?? 0 // Provided Default value using '??'
// The conversion WILL FAIL & assign the Default value to 'numberInt'

print(numberInt)    // Prints: 0 (Default value)
