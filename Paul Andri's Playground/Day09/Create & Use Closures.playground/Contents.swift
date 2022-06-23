import UIKit


//CREATE & USE CLOSURES



// 'func' that get copied and its copy called
func greetUser() { //Original 'func'
    print("Hi there!")
}

greetUser() // Call Site of OG 'func'

var greetCopy = greetUser // Copy 'greetUser' func as a value to 'greetCopy' var
greetCopy() //Call 'greetCopy()'

/* Print Results:
 Hi there!
 Hi there!
*/



//CREATE & USE CLOSURE

//CREATE CLOSURE as Anonymous Functions, storing the Closure inside 'let' and 'var'
//Create 'sayHello' function, stored in a 'let' Constant
let sayHello = {        //Effectivelty same as a 'func', with NO NAME, No PARAMs, DOESN'T return a Value
    print("Hi there!")
}

sayHello() //Send no Argument Value back to 'sayHello'
//Result: "Hi there!"



//Closure 'sayHello'
//Put codes INSIDE the Closure's { } to control Params or return Value
let sayHelloParam = { (name: String) -> String in // HAVE Param, RETURNS a 'String' value
    "Hi \(name)!"
}

print(sayHelloParam("Baby")) //Send Argument value "Baby" to Param 'name'
//Result: "Hi Baby!"




//FUNCTION TYPES

//Rewriting loc #15 - Copy 'greetUser' func - with Type Annotation
var greetCopyFunctionType: () -> Void = greetUser
// '( )' marks a Function that takes NO Params
// '->' to declare the Returm Type for the FUnction
// 'Void' meant NOTHING
// '-> Void' meant this Function RETURNS NOTHING





//COPY FUNCTION WITHOUT COPYING ITS EXT PARAMETER NAME
func getUserData(for id: Int) -> String { // 'func' accepts an Int 'id', returns a String value
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"}
}

let data: (Int) -> String = getUserData //Copy 'getUserData' func to a new 'let' named 'data'
//The copying code above DOES NOT copy the PARAMETERS from 'getUserData' func
let user = data(1989) //bcoz of that, 'data()' send the Argument value back OMITTING EXT Param Name 'for'
print(user) //Result: "Taylor Swift"






//PASSING FUNCTION INTO OTHER FUNCTION

//Using 'sorted() function with an Array to sort out its Elements w/o Passing in Custom Sorting Function
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted() // '.sorted()' sorts out the element of 'team' String Array alphabetically
print(sortedTeam) //Results: ["Gloria", "Piper", "Suzanne", "Tasha", "Tiffany"]


//Passing in Custom Sorting Function into 'sorted() with an Array to sort out its Elements
//Function MUST accept two Strings, and return 'true' if the 'name1' should be sorted BEFORE 'name2'', or 'false' if 'name1' should be sorted after 'name2'
//"Suzanne" is the Team Captain, and MUST appear as the first name in the sorted Array elements
func captainFirstSorted(name1: String, name2: String) -> Bool { //accepts two String Params, returns Bool
    
    if name1 == "Suzanne" {
        
        return true //if 'name1' is "Suzanne", return true: 'name1' is sorted BEFORE 'name2'
        
    } else if name2 == "Suzanne" {
        
        return false //if 'name2' is "Suzanne", return false: 'name1' is sorted AFTER 'name2'
        
    }
        return name1 < name2 //If NEITHER name is "Suzanne", use '<' to do normal Alphabetical sorting
}

//PASS FUNCTION INTO OTHER FUNCTION - Pass 'captainFirstSorted' function to '.sorted()' function
let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)
//Result: ["Suzanne", "Gloria", "Piper", "Tasha", "Tiffany"]







//COMBINING ANAONYMOUS CLOSUREs & CLOSUREs THAT PASS FUNCTIONs INTO OTHER FUNCTIONs
let teamName = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

let listCaptainFirst = teamName.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
            return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
})

/*CODE BREAK DOWN:
 1. We’re **calling the `sorted()` function as before.
 2. Rather than passing in a function*, we’re passing a Closure – everything from the opening brace { after `by:` down to the closing brace } on the last line is part of the Closure.
 3. Directly inside the closure we list the two Parameters* `sorted()` will pass us, which are two Strings. We also say that our Closure will return a Boolean, then mark the start of the closure’s code by using `in`.
 4. Everything else is just normal function code.
*/

print(listCaptainFirst) //Calling the Closure 'listCaptainFirst'
//Result: ["Suzanne", "Gloria", "Piper", "Tasha", "Tiffany"]




//OPTIONAL MATERIALS

//FUNCTIONs vs CLOSUREs
//'func' that accepts a String & a Int
func pay(user: String, amount: Int) { //Params are declared outside {} in 'func'
    //CODE
}

//Same code written as CLOSURE
let payment = { (user: String, amount: Int) in //Params are declared inside Closure's {}, ends with 'in'
    //CODE
}




//RETURN A VALUE FROM A CLOSURE THAT TAKES NO PARAMETERS and/or RETURNS NO BOOLEAN

//Closures that accepts one Param & returns Nothing
let payment = { (user: String) in //Acceot a String & returns NOTHING
    print("Paying \(user)…")
}

//Closures that accepts one Param & returns a Bool
let payment = { (user: String) -> Bool in //Acceot a String & returns a Bool
    print("Paying \(user)…")
    return true
}

//Closures that DO NOT accept Param & returns a Bool
let payment = { () -> Bool in  // '( )' : DO NOT accept Parameters & returns a Bool
    print("Paying an anonymous person…")
    return true
}

