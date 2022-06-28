// Created by Paul Andri on 28/06/2022

import UIKit


//HANDLING FUNCTION FAILURE USING OPTIONAL 'try?'
// 'try?' CONVERTS a throwing Function call into an Optional

//Example: 'try?' Optional try
/* All we care about is WHETHER the Function SUCCEEDED OR FAILED,
 We use an 'try' to have the Function return an Optional value.
 IF the Function ran WITHOUT throwing any ERRORS THEN the Optional will contain the return value,
 BUT IF any ERROR was thrown the Function will return ‘nil' */

// An Enum with Error type
enum UserError: Error {
    case badID, networkFailed
}

//A 'func' that throws could throw Error and returns a String
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}
/* getUser() Function will ALWAYS throw a 'networkFailed' Error from 'userError' Enum
 We DON'T actually care WHAT ERROR was thrown,
 All we care about is WHETHER the call SEND BACK A USER OR NOT */


// Using 'try?' with 'if let' to convert a throwing Function call into an Optional
// 'try?' makes 'getUser()' return an Optional String, which will be ‘nil’ IF any ERRORS are thrown
if let user = try? getUser(id: 23) { //WITHOUT '??' providing Default value to fall back on
    print("User: \(user)")
} //Retuns Optional 'nil', FAIL because 'getUser' func will always throw an Error


// Using 'try?' WITH '??' providing Default value
// NEED to add some parentheses ( ) BEFORE nil Coalescing
// ONLY CARE WHETHER 'getUser' func WORKS CORRECTLY OR NOT, IF NOT ASSIGN DEFAULT VALUE FROM '??'
let user = (try? getUser(id: 23)) ?? "Anonymous"
//LOGIC: execute 'try?' Method, IF IT FAIL, assign 'user' value with the value provided from '??'
print(user) //Prints: Anonymous  -< Default value from '??'





//OPTIONAL MATERIALS

/* Calling an Error throwing 'func' with 'try' inside a 'do'
 //WE WILL KNOW WHAT ERROR WAS THROWN AS THEY'RE 'catch'
do {
let result = try runRiskyFunction()
    print(result)
} catch {
    // it failed!
}
*/



/* EXAMPLE 2 CODE: Using 'try?' with 'if let' to convert a throwing Function call into an Optional
 // ONLY CARE WHETHER 'runRiskyFunction' func WORKS CORRECTLY OR NOT,
 // IF NOT ASSIGN DEFAULT VALUE FROM '??'
 
 if let result = try? runRiskyFunction() {
     print(result)
 }
*/
