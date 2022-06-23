import UIKit


//HANDLING ERRORS IN FUNCTIONS

//Ex:  Password Strength Checker code
//Step 1. Create an Enum that builds on Swift's 'Error'-type
enum PasswordError: Error { // 'Error'-type Enum named 'PasswordError'
    case short, obvious
    //there are two possible errors with password: 'short' and 'obvious'. It doesn’t define what those mean, only that they exist
}


//Step 2. write a Function that will trigger one of those Errors based on Conditions
func checkPassword(_ password: String) throws -> String {//func MUST return a String value
    if password.count < 5 { //Condition: <5 Characters
        throw PasswordError.short //Trigger Error '.short'
    }

    if password == "12345" { //Condition: Obvious password: 12345
        throw PasswordError.obvious //Trigger Error '.obvious
    }

    if password.count < 8 { //Condition: <8 Characters
        return "OK"
    } else if password.count < 10 { //Condition: <10 Characters
        return "Good"}
    else { //Trigger this loc for other String conditions
        return "Excellent"
    }
}
//Function Call Site
checkPassword("12345131535") //Returns: "Excellent" because 'password' value is >= 10 chars



//Step 3. Run the Function and handle any Errors that might happen
/*pseudocode for Step 3
do { // 'try' need to be used inside a 'do' block
 
        try someRiskyWork() //someRiskyWork() Function that can throw Errors
 
} catch { //Handling any thrown errors using 'catch'
    print("Handle errors here")
}
*/



//The Loc below will throw an general Error message
let string1 = "12345" //Password Value to test: Obvious

do { // 'try' need to be used inside a 'do' block
    //Calling *one or more throwing functions*, using `try'
    let result = try checkPassword(string1) //checkPassword() Function that can throw Errors
    print("Password rating: \(result)")
} catch { //Handling any thrown errors using 'catch'
    print("There was an error.")
}
//Results: "There was an error."


//The Loc below will NOT throw an general Error message
let string1B = "1234567891" //Password Value to test: 10 chars

do { // 'try' need to be used inside a 'do' block
    //Calling *one or more throwing functions*, using `try'
    let result = try checkPassword(string1B) //checkPassword() Function that can throw Errors
    print("Password rating: \(result)")
} catch { //Handling any thrown errors using 'catch'
    print("There was an error.")
}
//Results: "Password rating: Excellent"




//The loc below will throw more specific Error messages
//Obvious Password
let string2 = "12345" //Password Value to test: Obvious

do { // 'try' need to be used inside a 'do' block
    //Calling *one or more throwing functions*, using `try'
    let result = try checkPassword(string2) //checkPassword() Function that can throw Errors
    print("Password rating: \(result)")
} catch PasswordError.short { //Handling any thrown errors using 'catch'
    print("Please use a longer password.")
} catch PasswordError.obvious { //Handling any thrown errors using 'catch'
    print("I have the same combination on my luggage!")
} catch { //Handling any thrown errors using 'catch'
    print("There was an error.")
}
//Result: "I have the same combination on my luggage!"



//Short Password
let string3 = "123" //Password Value to test: Short

do { // 'try' need to be used inside a 'do' block
    //Calling *one or more throwing functions*, using `try'
    let result = try checkPassword(string3) //checkPassword() Function that can throw Errors
    print("Password rating: \(result)")
} catch PasswordError.short { //Handling any thrown errors using 'catch'
    print("Please use a longer password.")
} catch PasswordError.obvious { //Handling any thrown errors using 'catch'
    print("I have the same combination on my luggage!")
} catch { //Handling any thrown errors using 'catch'
    print("There was an error.")
}
//Result: "Please use a longer password."






//OPTIONAL MATERIALS
/*pseudocode
do {
    try throwingFunction1()
    nonThrowingFunction1()
    try throwingFunction2()
    nonThrowingFunction2()
    try throwingFunction3()
} catch {
    // handle errors
}
*/
