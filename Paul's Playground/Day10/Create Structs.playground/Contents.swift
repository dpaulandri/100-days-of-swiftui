import UIKit


//CREATE STRUCTs

//Example of a simple Struct
struct Album { //The name of a Struct starts w/ Capital letter - the srandard in Swift
    let title: String //Properties - 'var' or 'let' thst belong to Structs
    let artist: String //Properties - 'var' or 'let' thst belong to Structs
    let year: Int //Properties - 'var' or 'let' thst belong to Structs

        func printSummary() { //Methods - 'func' that belong to Structs
        print("\(title) (\(year)) by \(artist)")
    }
}
/* Struct Breakdwon:
 1. Creates a new Type called Album
 2. Two String constants called 'title' and 'artist', plus an Integer constant called 'year'
 3. A simple Function that summarizes the values of our three Constants
*/

//Creating new Albums using the 'Album' Struct above
//we can create a new Album as if we were calling a Function:
//We just need to provide Values for each of the Constants in the order they were defined.
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
//Instance - Create a 'let' or 'var' out of a Struct
//Initializer - Initialises the initial value of the Properties inside the Struct: Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)
//Instance - Create a 'let' or 'var' out of a Struct
//Initializer - Initialises the initial value of the Properties inside the Struct: Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title) //Result: "Red"
print(wings.artist) //Result: "BTS"

red.printSummary() //Result: "Red (2012) by Taylor Swift"
wings.printSummary() //Result: "Wings (2016) by BTS"





//STRUCT W/ 'mutating func' THAT CHANGES ITS PROPERTY VALUE(s)
//Ex: an Employee struct that can take vacation as needed:
struct Employee {
    let name: String //Properties - 'var' or 'let' thst belong to Structs
    var vacationRemaining: Int //Properties - 'var' or 'let' thst belong to Structs
    
    //Functions that change data (Property) belonging to the Struct MUST be marked with a special 'mutating' keyword
    mutating func takeVacation(days: Int) { //Methods - 'func' that belong to Structs
        if vacationRemaining > days {
                vacationRemaining -= days //This loc changes the value of a Struct Property
                print("I'm going on vacation!")
                print("Days remaining: \(vacationRemaining)")
        } else {
                print("Oops! There aren't enough days remaining.")
                print("You only have \(vacationRemaining) remaining days off.")
        }
    }
}

//Calling 'takeVacation' mutating Function on a Variable Struct
//if you change 'var archer' to 'let archer' you’ll find Swift refuses to build your code – trying to call a mutating Function on a Constant Struct IS NOT allowed
var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
//Instance - Create a 'let' or 'var' out of a Struct
//Initializer - Initialises the initial value of the Properties inside the Struct: Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)
/*Print Result:
 I'm going on vacation!
 Days remaining: 9
 9
*/

var paul = Employee(name: "Nanas Paul", vacationRemaining: 3)
//Instance - Create a 'let' or 'var' out of a Struct
//Initializer - Initialises the initial value of the Properties inside the Struct: Employee(name: "Nanas Paul", vacationRemaining: 3)
paul.takeVacation(days: 15)
print(paul.vacationRemaining)
/*Print Result:
 Oops! There aren't enough days remaining.
 You only have 3 remaining days off.
 3
*/


//SYNTACTIC SUGAR
/*Swift silently creates a special Function inside the Struct called 'init()', using all the Properties of the Struct as its Parameters. It then automatically treats these two pieces of code as being the same:*/
//Our Instance & Initializer code
var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
//What Swift is doing: silently creates a 'init()' function in our 'Employee' Struct
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)



//SWIFT IMPLEMENTS ITS OWN DATA TYPES AS A STRUCT
//Ex: Adding a Int and a Double values
let a = 1
let b = 2.0
let c = Double(a) + b //Final Value= 3
/* WHAT REALLY HAPPEN:
 Swift’s own Double type is implemented as a Struct that has an initializer function that accepts an Integer.
*/


//
struct EmployeeVacation {
    var name = "Anonymous"
    var vacationRemaining = 14 //Property with default value that can be override
    // To assign a default but leave open the possibility of overriding it when needed, use a Variable Property
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
                vacationRemaining -= days
                print("I'm going on vacation!")
                print("Days remaining: \(vacationRemaining)")
        } else {
                print("Oops! There aren't enough days remaining.")
                print("You only have \(vacationRemaining) remaining days off.")
        }
    }
}

//The incomplete Initializer below is valid because the Property 'vacationRemaining' in the Struct abpve have been assigned a default value!
let kane = EmployeeVacation(name: "Lana Kane") //Incomplete Initializer, but Valid
print(kane.vacationRemaining) //Result: 14 (default value)


let anon = EmployeeVacation(vacationRemaining: 10) //Incomplete Initializer, but Valid
print(anon.name) //Result: "Anonymous" (default value)

