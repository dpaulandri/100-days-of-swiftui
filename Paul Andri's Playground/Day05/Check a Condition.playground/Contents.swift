import UIKit


//CHECKING A CONDITION

//IF
//Example Code
/*
if someCondition { //If "someCondition is "true", do the following lines of codes
    print("Do something")
    print("Do something else")
    print("Do a third thing")
}
*/


//"Comparison Operator": comparing 2 different things & retuns Bool result
//Available "Comparison Operator"
//> = is greater than
//< = less than
//>= = greater than OR equal
//<= = less than OR equal
//== = equal to
//!= = not equal


//"Comparison Operator": >
let score = 85

//">" is a "Comparison Operator"
if score > 80 { //Condition: If "score" value is more than 80
    print("Great job!")
}


//"Comparison Operator": >= , < , >=
let speed = 88
let percentage = 85
let age = 18

if speed >= 88 { //returns Bool: "true": condition MET
    print("Where we're going we don't need roads.") //loc will be printed
}

if percentage < 85 { //returns Bool: "false": condition NOT MET
    print("Sorry, you failed the test.") //loc won't be printed
}

if age >= 18 { //returns Bool: "true": condition MET
    print("You're eligible to vote") //loc will be printed
}


//"Comparison Operators" with String Data Type
let ourName = "Cat Lady"
let friendName = "Baby Bieber"

//Condition: The 1st Letter of "ourName" come before the 1st Letter of "friendName" alphabetically
if ourName < friendName { //ourName: "C"3 vs friendName: "B"2. Returns: "false"
    print("It's \(ourName) vs \(friendName)") //loc will NOT be executed
}

//Condition: The 1st Letter of "friendName" come before the 1st Letter of "ourName" alphabetically
if ourName > friendName { //ourName: "C"3 vs friendName: "B"2. Returns: "true"
    print("It's \(friendName) vs \(ourName)") //loc will be executed
}
//Returns: "It's Baby Bieber vs Cat Lady/"


//"Comparison Operators" with Arrays
var numbers = [1, 2, 3]
numbers.append(4) //Add a 4th item

//Condition: If we have >3 items in "number" Array
if numbers.count > 3 { //returns: Bool "true"
    numbers.remove(at: 0) //Remove the item at position [0]. Loc will be executed
}

print(numbers) //result: [2, 3, 4] The oldest one (1) removed


//"Comparison Operator": ==
let country = "Japan"

if country == "Japan" { //Condition: "country" value equals to "Japan". Returns: "true"
    print("おはようございます!") //loc will be executed
} //Result: "おはようございます!"


//"Comparison Operator": !=
let name = "Crazy Bear"

if name != "Anonymous" { //Condition: "name" value NOT equals to "Anonymous". Returns: "true"
    print("Welcome, \(name)!") //loc will be executed
} //Result: "Welcome, Crazy Bear!"



//DIFFERENT METHODS FOR CONDITION CHECKING

//METHOD 1 - ==
var username = "@dpaulandri" //NOT EMPTY, .count = 10

//Condition: If "username" contains an empty String. Returns: "false"
if username == "" {
    username = "Anonymous" //Make "username" value equal to "Anonymous"
} //loc NOT executed

print("Welcome, \(username)!") //Result: "Welcome, @dpaulandri!"


//METHOD 2 - .count (NOT recommended for use in Swift: Inefficient & Slow)
var emptyUserName = ""//EMPTY, .count = 0

//Conditiion: If "username" String .count returns "0" (empty String). Returns = "true"
if emptyUserName.count == 0 {
    emptyUserName = "Anonymous" //Make "emptyUserName" value equal to "Anonymous"
} //loc EXECUTED

print("Welcome, \(emptyUserName)!") //Result: "Welcome, Anonymous!"



//METHOD 3 - .isEmpty (Recommended over .count)
//.isEmpty only cares about whether "var" or "let" is empty without any value
//.isEmpty returns only Bool "true" or "false"

//1st way of typing .isEmpty
var isItEmpty = ""

if isItEmpty.isEmpty == true { //Returns: "true"
    isItEmpty = "Anonymous" //loc will be executed
}

print("Welcome, \(isItEmpty)!") //Results: "Welcome, Anonymous!"

//2nd way of typing .isEmpty (RECOMMENDED! Simple code)
var notEmpty = "Schnapp"

if notEmpty.isEmpty { //Returns: "false"
    notEmpty = "Anonymous" //loc will NOT be executed
}

print("Welcome, \(notEmpty)!") //Results: "Welcome, Schnapp!"



//OPTIONAL MATERIAL
//Comparison Operator returns Bool "true" or "false"
let firstName = "Paul"
let secondName = "Sophie"
let firstAge = 40
let secondAge = 10

print(firstName == secondName) //Returns: "false"
print(firstName != secondName) //Returns: "true"
print(firstName < secondName) //Returns: "true" Alpahbetically "P" comes before "S"
print(firstName >= secondName) //Returns: "false" Alpahbetically "P" comes before "S"
print(firstAge == secondAge) //Returns: "false"
print(firstAge != secondAge) //Returns: "true"
print(firstAge < secondAge) //Returns: "false"
print(firstAge >= secondAge) //Returns: "true"


//Enum with Comparison Operator
//"Comparable" enables Enum case values to be used with Comparison Operator
enum Sizes: Comparable {
    case small, medium, large
}

let first = Sizes.small
let second = Sizes.large
print(first < second) //Returns: "true"
