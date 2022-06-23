import UIKit


//RETURN VALUES FROM FUNCTIONS

// "sqrt()" = Calculate Square Root(Mathematical Functions)
let root = sqrt(169)
print(root) //Result: 13.0



//RETURN VALUES in FUNCTION
//Rool Dice Function
func rollDice() -> Int { //the "roolDice" func MUST return an Int value
        return Int.random(in: 1...6) //loc will "return" the random Int value within the set 1...6 Range
}

//Create "result" Constant with the value from "roolDice" Function
let result = rollDice()
print(result) //Result varies with Int value within 1...6



//CHALLENGE 1
//My Solution
func sameLetters() -> Bool {
    let unsorted1 = "abc"
    let unsorted2 = "cab"
    let sorted1 = unsorted1.sorted()
    let sorted2 = unsorted2.sorted()
    
    return Bool(sorted1 == sorted2)
}
let sameResult = sameLetters()
print(sameResult) //Result: "true"

//Paul's Solution (Refactored)
func areLettersIdentical(string1: String, string2: String) -> Bool {
    string2.sorted() == string1.sorted()
}

areLettersIdentical(string1: "abc", string2: "cab")
areLettersIdentical(string1: "abc", string2: "cba")
print(areLettersIdentical(string1: "abc", string2: "cba"))
//Returns: "true"




//Rool Dice Function (Refactored)
func rollDiceR() -> Int {
    Int.random(in: 1...6)
}
let resultR = rollDiceR()
print(result) //Result varies with Int value within 1...6




//PHYTAGOREAN THEOREM Function (Refactored)
func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

print(pythagoras(a: 3, b: 4)) //Result: 5.0





//Use "return" for FORCE a FUNCTION to exit immediately
func sayHello() {
    return //FORCE Function exit with "return"
}




//OPTIONAL MATERIALS
//Short Codes resolvesable to a Single Value
5+8 //Resolve to: 13
/*
greet(Paul) - Might return "Hi, Paul" with other functions */

//Longer Codes resolvesable to a Single Value
let isAdmin = true
let isOwner = false
let isEditingEnabled = false
/* Resolves to:
isOwner == true && isEditingEnabled || isAdmin == true
*/


//OMITTING "return"
//Swift lets us skip using the "return" keyword when we have only ONE EXPRESSION in our FUNCTION
func doMath() -> Int {
        return 5 + 5
}

func doMoreMath() -> Int {
    5 + 5
}



//TERNARY OPERATOR: What ? "True" : "False"
//Primary use case: you want to have a single expression, but don’t want to have a full "if"

//Code w/o Ternary Operator
func greet(name: String) -> String {
        if name == "Taylor Swift" {
                return "Oh wow!"
        } else {
                return "Hello, \(name)"
        }
}

//Code w/ Ternary Operator
func greetTernary(name: String) -> String {
    name == "Taylor Swift" ? "Oh wow!" : "Hello, \(name)"
}
