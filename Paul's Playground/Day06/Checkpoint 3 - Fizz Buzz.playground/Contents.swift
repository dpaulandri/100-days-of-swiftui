import UIKit


//Checkpoint 3 - FIZZ BUZZ
/*
 The problem is called "fizz buzz", and has been used in job interviews, university entrance tests, and more for as long as I can remember. Your goal is to loop from 1 through 100, and for each number:

 1. If it’s a multiple of 3***, print “Fizz”
 2. If it’s a multiple of 5,*** print “Buzz”
 3. If it’s a multiple of 3 and 5, print “FizzBuzz”
 4. Otherwise, just print the number.
 
 
 So, here are some ***example values*** you should have *when your code runs*:
 - 1 should print “1”
 - 2 should print “2”
 - 3 should print “Fizz”
 - 4 should print “4”
 - 5 should print “Buzz”
 - 6 should print “Fizz”
 - 7 should print “7”
 - …
 - 15 should print “FizzBuzz”
 - …
 - 100 should print “Buzz”
*/


//My Solution
let number1 = 3
let number2 = 5

for i in 1...100{
    if i.isMultiple(of: number1) {
        print("Fizz")
    } else if i.isMultiple(of: number2) {
        print("Buzz")
    } else if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        print("FizzBuzz")
    } else {
        print(i)
    }
}


//Solution based on Paul's hints
for i in 1...100{
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    } else {
        print(i)
    }
}
