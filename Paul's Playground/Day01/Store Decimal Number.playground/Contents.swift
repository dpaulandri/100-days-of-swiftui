import UIKit

var greeting = "Hello, playground"


//Floating Point (Double) Data Type
let number = 0.1 + 0.2
print(number)


//Mixing Int and Double Data Type
let a = 1
let b = 2.0
//let c = a + b //This line trigger an error
//Swift is trying to  prevent mixing of different Data Type by accident
//Instead we decalre the Data Type as below to allow the Data Type mixture
let c = a + Int(b) //Option 1 ("c" will be in Int Data Type)
//let c = Double(a) + b // Option 2 ("c" will be in Double Data Type)
print(c)


//Declaring Double & Int Data Type
let double1 = 3.1 //decimal numbers (double)
let double2 = 3131.3131 //decimal numbers (double)
let double3 = 3.0 //decimal numbers (double)
let int1 = 3 //whole number (int)
print(double1)
print(double2)
print(double3)
print(int1)


//Swift will hold on to a Data Type after the initial value
var name1 = "Nicolas Cage"
name1 = "John Travolta"
print(name1)

var name2 = "Nicolas Cage"
//name2 = 57 //this line triggers an error because "name2" has a String Data Type
//while the replacement "57" is an Integer Data Type
//Instead we could still store "57" as the new value for "name2" with the code below
name2 = "57" //Using Double Quotes to indicate "57" as a String Data Type value
print(name2)


//Compound Assignment Operators are used the same way in both Double & Int Data Type
var rating = 5.0
rating *= 2 //The resulting new value of "rating" is still in Double Data Type
print(rating)
