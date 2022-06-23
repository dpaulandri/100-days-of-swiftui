import UIKit


//Ternary Conditional Operator

//3-PARTS of a Ternary Conditional Operator
let age = 18
let canVote = age >= 18 ? "Yes" : "No" //Returns: "Yes"
//" 18 ? "Yes" : "No" " is the Ternary Conditional Operator
//1st PART: "18 ? "Yes"" - the CONDITIONAL Operator
//2nd PART: "Yes" - Value to send back when the CONDITION is "true"
//3rd PART: "No" - Value to send back when the CONDITION is "false"


//Time of the Day Example
let hourNow = 23
print(hourNow < 12 ? "It's before noon" : "It's after noon")
//Result: "It's after noon"


//Reading whether an Array is EMPTY with .isEmpty
let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
//names.isEmpty returned "false"
//Hence crewCount value = "\(names.count) people"
//names.count returned = 3
//Final value for crewCount = "3 people"
print(crewCount) //Result: "3 people"



//Ternary Conditional Operator with Enum and Comparison Operator
enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = theme == .dark ? "black" : "white"
print(background) //Result: "black"



//OPTIONAL MATERIAL - SHORT CODE vs EASY-TO-READ CODE
let isAuthenticated = true

//SHORT CODE - Ternary Operator
print(isAuthenticated ? "Welcome!" : "Who are you?")
//Result: "Welcome!"

//EASY-TO-READ CODE - IF-ELSE
if isAuthenticated { //IF "isAuthenticated" value = "true"
    print("Welcome!")
} else {
    print("Who are you?")
}
//Result: "Welcome!"
