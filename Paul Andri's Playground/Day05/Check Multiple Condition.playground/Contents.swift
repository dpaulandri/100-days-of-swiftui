import UIKit


//Checking Multiple Conditions

//METHOD 1 - Multiple IFs (NOT EFFICIENT! Swift had do 2x Checking on "age" value)
let age = 16

if age >= 18 { //Returns: "false"
    print("You can vote in the next election.")
}

if age < 18 { //Returns: "true"
    print("Sorry, you're too young to vote.")
}
//Result: "Sorry, you're too young to vote."


//METHOD 2 - IF & ELSE (MORE EFFIFICENT! Swift only had do check "age" value ONCE!)
let age2 = 16

if age2 >= 18 {  //Exectute this line of code if "age2" >= 18 is "true" and STOP
    print("You can vote in the next election.")
} else { //Exectute this line of code if the 1st condition is "false" and STOP
    print("Sorry, you're too young to vote.")
}
//Result: "Sorry, you're too young to vote."

/*Format of IF ELSE
if someCondition {
    print("This will run if the condition is true")
} else {
    print("This will run if the condition is false")
}
 */


//METHOD 3 - IF - ELSE IF - ELSE
//SIMILAR TO IF - ELSE, but Swift do 1 more checking below if Condition 1 returned "false"
//We can have AS MANY "ELSE IF" as we want
let a = false
let b = true

if a { //check if a = "true". If "true", execute the loc below and STOP
    print("Code to run if a is true")
} else if b { //check if b = "true". If "true", execute the loc below and STOP
    print("Code to run if a is false but b is true")
} else { //both are "false", execute the code below and STOP
    print("Code to run if both a and b are false")
}
//Result: "Code to run if a is false but b is true"


//METHOD 4 - Nested IFs
let temp = 25

if temp > 20 { // IF "temp" values is > 20
        if temp < 30 { //AND IF "temp" value is <30
        print("It's a nice day.")
    }
}
//Result: "It's a nice day."


//METHOD 5 - && (AND, Swift Alternative to Method 4 (Nested Ifs)
if temp > 20 && temp < 30 { //IF "temp" value is > 20 AND < 30
    print("It's a nice day.")
} //Result: "It's a nice day."


//METHOD 6 - || (OR)
let userAge = 14
let hasParentalConsent = true

//Condition: IF "userAge" value >= 18 OR "hasParentalConsent" value = "true"
if userAge >= 18 || hasParentalConsent == true {
    print("You can buy the game")
} //Result: "You can buy the game"

//Simplified Code
if userAge >= 18 || hasParentalConsent {
    print("You can buy the game")
} //Result: "You can buy the game"


//COMBINED METHODS with Enum Values
enum TransportOption {
        case airplane, helicopter, bicycle, car, scooter
}

let transport = TransportOption.car

if transport == .airplane || transport == .helicopter {
//IF "transport" = .airplane OR .helicopter, run the below loc and STOP
    print("Let's fly!")
} else if transport == .bicycle {
//ELSE IF "transport" = .bicycle, run the below loc and STOP
    print("I hope there's a bike path…")
} else if transport == .car { //IF "transport" = .car
//ELSE IF "transport" = .car, run the below loc and STOP
    print("Time to get stuck in traffic.")
} else {
//ELSE IF no Condition returns "true", run the below loc and STOP
    print("I'm going to hire a scooter now!")
}
//Result: "Time to get stuck in traffic."



//OPTIONAL MATERIALS - IF - ELSE IF - ELSE
//TWO CONDITIONS: Multiple IFS
let score = 9001

if score > 9000 {
    print("It's over 9000!")
}

if score <= 9000 {
    print("It's not over 9000!")
}
//Result: "It's over 9000!"


//TWO CONDITIONS: Rewritten with IF - ELSE
if score > 9000 {
    print("It's over 9000!")
} else {
    print("It's not over 9000!")
}
//Result: "It's over 9000!"


//THREE CONDITIONS: Multiple IFs and ELSEs
if score > 9000 {
    print("It's over 9000!")
} else {
if score == 9000 {
        print("It's exactly 9000!")
    } else {
        print("It's not over 9000!")
    }
}
//Result: "It's over 9000!"


//THREE CONDITIONS: Rewritten with IF - ELSE IF - ELSE
if score > 9000 {
    print("It's over 9000!")
} else if score == 9000 {
    print("It's exactly 9000!")
} else {
    print("It's not over 9000!")
}
//Result: "It's over 9000!"



//OPTIONAL MATERIALS - && (AND) and || (OR)
// || (OR) Conditions
let isOwner = true
let isAdmin = false
let isEditingEnabled = true

//Condition: IF either "isOwner" OR "isAdmin" value is "true"
if isOwner == true || isAdmin == true {
    print("You can delete this post")
}
//Result: "You can delete this post"


//Condition: IF BOTH "isOwner" AND "isEditingEnabled" values are "true", OR "isAdmin" value is "true"
if isOwner == true && isEditingEnabled || isAdmin == true {
    print("You can delete this post")
}
//Result: "You can delete this post"

//A perspective to the ORDER of CONDITION CHECKING & GROUPING
//"isOwner" AND "isEditingEnabled" values are "true" Condition are check first,
//then followeb by the checking of "isAdmin" value is "true"
if (isOwner == true && isEditingEnabled) || isAdmin == true {
    print("You can delete this post")
}
//Result: "You can delete this post"

//Another perspective of HOW the CONDITION CHECKING can be GROUPED
//IF "isOwner" value = "true" AND either "isEditingEnabled" OR "isAdmin" values = "true"
if isOwner == true && (isEditingEnabled || isAdmin == true) {
    print("You can delete this post")
}
//Result: "You can delete this post"

//HOW SWIFT INTERPRET OUR ORIGINAL CODE
if (isOwner == true && isEditingEnabled) || isAdmin == true {
    print("You can delete this post")
}
//Result: "You can delete this post"

//ALWAYS A GOOD IDEA to insert the parentheses ( ) ourselves to clarify exactly what we mean
