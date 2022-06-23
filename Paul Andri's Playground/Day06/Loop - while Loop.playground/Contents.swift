import UIKit


//while LOOP
//CODE EXAMPLE: Count Down from 10
var countdown = 10 //Int Variable, Initial value 10

while countdown > 0 { //While the countdown value is greater than 0
    print("\(countdown)…") //print this line
    countdown -= 1
    //"countdown" value -1 for each CODE ITERATION run and will be the new value for "countdown"
}

print("Blast off!") //This line will print when the Condition "countdown > 0" is "false", the end of the loop
/*Final Print Result:
 10…
 9…
 8…
 7…
 6…
 5…
 4…
 3…
 2…
 1…
 Blast off!
*/



// random(in:) FUNCTIONALITY for Int and Double
//Creates a random new Int between 1 and 1000
let id = Int.random(in: 1...1000)
print(id) //Result varies in every run


//Creates a random Double between 0 and 1
let amount = Double.random(in: 0...1)
print(amount) //Result varies in every run




//EXAMPLE CODE of USING while Loop: Keep "rolling" a 20-sided Dice until we get "20
//Roll some virtual 20-sided dice again and again, ending the loop only when a "20" is rolled
//Create an Int Variable to store our roll
var roll = 0 //Initial Variable Value = 0

//Keep looping until we get "20"
while roll != 20 { //While roll is NOT 20, keep running the locs in { }
    roll = Int.random(in: 1...20) //roll a new "dice" with 20-sides
    print("I rolled a \(roll)") //print out what it was
}

//If the condition: roll NOT EQUAL 20 returns "false". END the loop and run the code below!
print("Critical hit!")
//Results varies in every run, but it will always ends with "Critical hit!" printed



var numbers = 0 //Initial Variable Value = 0

//Keep looping until we get "20"
while numbers != 5 { //While roll is NOT 5, keep running the locs in { }
    numbers = Int.random(in: 1...12) //12 numbers to randomly choose from
    print("You've got \(numbers)") //print out what it was
}

//If the condition: numbers NOT EQUAL 5 returns "false". END the loop and run the code below!
print("5 is the number of Grace!")
//Results varies in every run, but it will always ends with "Critical hit!" printed
