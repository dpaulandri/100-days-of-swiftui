// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// PROTOCOL EXTENSION 'extension'
// Extend a whole Protocol to add Computed Properties and Method Implementations, so ANY types conforming to that Protocol get them

// Ex: ADD a Computed Property to Array, Dictionary, and Set that CONFORM to the 'Collection' Protocol
extension Collection {
    var isNotEmpty: Bool {  // Add a 'var' Computed Property
        isEmpty == false    // Computation for Computed Property value
    }
}

let guests = ["Mario", "Luigi", "Peach"]    // A Constant String Array

// Use 'isNotEmpty' - our new Computed Property from 'Collection' Protocol Extension
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}
// Prints: Guest count: 3
