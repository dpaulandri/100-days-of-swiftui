import UIKit


//FUNCTIONs - MAKE A BLOCK OF CODES REUSABLE

//MAKE A BLOCK OF CODES REUSABLE USING FUNCTION
//Code without using Function - can onlt be used once in a single place
print("Welcome to my app!")
print("By default This prints out a conversion")
print("chart from centimeters to inches, but you")
print("can also set a custom range if you want.")


//Same Code using Function - can be used in various places
//Create a Function named "showWelcome"
func showWelcome() { // The BODY of the Function is contained within { }
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

//Function "Call Site"
showWelcome() //Call the "showWelcome" Function to be executed where this loc is placed
//Results: All "print" locs & its values will be printed




//PARANTHESIS () IN FUNCTION - add CONFIGURATION OPTIONS for FUNCTION
//Ex 01
let number = 139

if number.isMultiple(of: 2) { // (of: 2) is a CONFIGURATION OPTIONS
    print("Even")
} else {
    print("Odd")
} //Result: "Odd"

//Ex 02
let roll = Int.random(in: 1...20) // (in: 1...20) is a CONFIGURATION OPTIONS
//This CONFIGURATION OPTIONS above allows us to control the RANGE
//Result: varies single Int value between 1 to 20 on each run



//FUNCTION - PARAMETER (Customisation Point)
func printTimesTables(number: Int) { // (number: Int) is a PARAMETER
        for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

// (number: 5) NEED TO EXPLICITLY write the PARAMETER name & its Value as part of the FUNCTION CALL
printTimesTables(number: 5) // FUNCTION CALL, "5" is called ARGUMENTS
/*Print Results:
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
*/


//To customize how HIGH our multiplication tables WENT. SET the END of our RANGE using a second PARAMETER
func otherTimesTables(number: Int, end: Int) { //Added "end" Int PARAMETER
        for i in 1...end { //Range: 1 to the "end" Int Value
        print("\(i) x \(number) is \(i * number)")
    }
}

//EXPLICITLY write the PARAMETER names & Values as part of the FUNCTION CALL
otherTimesTables(number: 5, end: 20) // FUNCTION CALL, "5" and "20" are called ARGUMENTS
/*When you ask Swift to call the FUNCTION, you MUST always pass the PARAMETER IN THE ORDER they were LISTEN when you created the FUNCTION
 The Code below won't work because it puts "end" before "number"!
 printTimesTables(end: 20, number: 5)
 */

/*Print Results:
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
 13 x 5 is 65
 14 x 5 is 70
 15 x 5 is 75
 16 x 5 is 80
 17 x 5 is 85
 18 x 5 is 90
 19 x 5 is 95
 20 x 5 is 100
*/
