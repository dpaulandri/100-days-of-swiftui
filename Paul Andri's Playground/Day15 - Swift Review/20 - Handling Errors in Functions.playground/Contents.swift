// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// HANDLING ERRORS IN FUNCTIONS
// To handle Errors in Functions we NEED to tell Swift WHICH Errors CAN HAPPEN, write a Function that can throw Errors, then call it and handle any problems

// 1. Define the Errors that CAN occur using Enum that conform to Type 'Error'
enum PasswordError: Error { // Enum that conform to Type 'Error'
    case short, obvious // Possible 'Error' cases
}

// 2. write a Function that can THROW ERRORS
func checkPassword(_ password: String) throws -> String {   // Use 'throws' keyword
    if password.count < 5 { // IF 'password' String value counted LESS THAN 5
        throw PasswordError.short   // 'throw' 'PasswordError's 'short' case
    }
    
    if password == "12345" { // IF 'password' String value is "12345"
        throw PasswordError.obvious   // 'throw' 'PasswordError's 'obvious' case
    }
    
    if password.count < 10 { // IF 'password' String value counted LESS THAN 10
        return "OK" // Return String "OK"
    } else {    //ELSE
        return "Good"   // Return String "OK"
    }
}

// 3. call the Throwing Function by starting a 'do' block
//  Call the Function using 'try', THEN 'catch' Errors that occur

// Password String values to test
let password1 = "12345" // Will throw 'PasswordError.obvious' Error
let password2 = "1234" // Will throw 'PasswordError.short' Error
let password3 = "1234567" // Will throw "Rating: OK"
let password4 = "1234567890" // Will throw "Rating: Good"


// Start a 'do ' block to call Throwing Function in
do {
    let result = try checkPassword(password2)    // Call 'checkPassword() using 'try'
    print("Rating: \(result)")  // This will print the value of 'result' Constant
}


// 'catch' block to catch any Error that occurs (thrown from 'checkPassword()' func)
// MUST always have a catch block that can handle EVERY KIND OF ERROR
//'catch' any 'obvious' Error case from 'PasswordError' enum
catch PasswordError.obvious {
    print("Your Password is TOO COMMON!")
} catch PasswordError.short {
    print("Your Password is TOO SHORT!")
} catch { //'catch' ALL OTHER ERRORs NOT WITHIN 'PasswordError's cases
    print("OOPS! There was an error!")
}
