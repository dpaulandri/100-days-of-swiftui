// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// SETS 'Set([ ])'
// Similar to Arrays
// CAN’T add duplicate items - Set will IGNORE duplicate values
// DON’T store items in a particular order - WON’T remember the order used in the Array

// Ex: Create a Set of Int numbers
var numberSet = Set([1, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21])
print(numberSet)

// '.insert()' Method - Add an item to a Set
numberSet.insert(10)
print(numberSet)

// ONE BIG ADVANTAGE OVER ARRAYS:
// Using 'contains()' on a Set is effectively instant NO MATTER how many items the Set contains
print(numberSet.contains(0))
