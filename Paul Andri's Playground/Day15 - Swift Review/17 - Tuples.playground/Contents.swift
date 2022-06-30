// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// TUPLES
// Tuples store a FIXED number of values of specific Types, a convenient way to return multiple Values from a Function
// RETURNING MULTIPLE VALUSE FROM FUNCTIONS

// Ex: Returning Multiple values from a 'func' into a Tuple
func getUser() -> (firstName: String, lastName: String) {   // 'func' returns a Tuple
    (firstName: "Taylor", lastName: "Swift")    // Tuples w/ values
}

// 'func' Call Site
let userData = getUser()
// Access the returned Tuple values from 'func' using String Interpolation
print("Name: \(userData.firstName) \(userData.lastName)")
// Prints: Name: Taylor Swift

// De-Structure 'func's returned Tuple values & get only 'firstName' value
let (firstName, _) = getUser()  // '_' tell Swift to ignore the rest
print("Name: \(firstName)") // Prints: "Name: Taylor"
