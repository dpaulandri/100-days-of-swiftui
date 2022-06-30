// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// DICTIONARIES '[Key: Value]' - Complex Data Type
// Store multiple Values according to a Key we specify

// A [String: String] Dictionary that store information about a person
let employee = [
    "name": "Taylor",
    "job": "Singer"
]

// Use "Key" to read Data from a Dictionary
// 'default' value will be used IF the Key we’ve asked for DOESN’T exist
print(employee["name",default: "Unknown"])
print(employee["job",default: "Unknown"])
