import UIKit
import Foundation


//Enumeration: a set of named Values we can create and use in our code

//Code not using Enum, inefficient, potentially intoducing wrong data
var selected = "Monday" //Name of Day, Correct Value
selected = "Tuesday" //Name of Day, Correct Value
selected = "January" //Name of Month, wrong Data! Would it affect our App?
selected = "Friday " //Name of Day, Incorrect Value: unintentional extra Space!


//Using Enum to solve the problem with Data inconsistency
//Method 1: Full Syntax
/*
enum Weekday {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
}
 */

//Method 2: Short Syntax
enum Weekday {
     case Monday, Tuesday, Wednesday, Thursday, Friday
 
}


//Calling Enum case
//1st Method: Full Syntax
/*
var day = Weekday.Monday //calling "Weekday" Enum's "Monday" case
print(day) //returns: Monday

day = Weekday.Thursday
print(day) //returns: Thursday

day = Weekday.Friday
print(day) //returns: Friday
*/

//2nd Method: Short Syntax
var day = Weekday.Monday //calling "Weekday" Enum's "Monday" case
//The complete "Weekday.Monday" syntax need to use only once
print(day) //returns: Monday

day = .Thursday //we could use .nameOfCase on the 2nd call onward, Swift auto-reference
print(day) //returns: Thursday

day = .Friday //we could use .nameOfCase on the 2nd call onward, Swift auto-reference
print(day) //returns: Friday
