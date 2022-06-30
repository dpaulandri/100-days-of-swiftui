// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// OPTIONAL 'try?'
// CONVERT the result of a Throwing Function into an Optional containing a value ON SUCCESS, OR 'nil' otherwise

//Ex:
// An Enum w/ 'Error' type casses
enum UserError: Error {
    case badID, networkFailed
}

// A 'func' that CAN 'throw' Error & returns a 'String' value
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

// Using OPTIONAL 'try?' in 'if let' to convert the result of the Throwing Function into an Optional
if let user = try? getUser(id: 23) {
    print("User: \(user)")
}
/* COMMENT & RESULT:
 The 'getUser()' Function will ALWAYS throw networkFailed,
 but we DON’T care WHAT was thrown,
 ALL WE CARE ABOUT is WHETHER the call sent back a user OR NOT
 */
