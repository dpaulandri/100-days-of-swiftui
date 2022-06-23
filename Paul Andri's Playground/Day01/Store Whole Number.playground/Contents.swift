import UIKit

var greeting = "Hello, playground"


//Int Interger (Whole Number) Data Type
let score = 10


//Int Large Numbers Seperator (_)
//let reallyBig = 100000000 //without _
let reallyBig = 100_000_000 //Swift ignores the "_", but its helpful for us
let reallyRidiculous = 1_00__00___00____00 //"_" placements are also ignored


//Arithmetic Operators + - * / and Int Data Type
let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)
print(lowerScore)
print(higherScore)
print(doubledScore)
print(squaredScore)
print(halvedScore)


//Compound Assignment (Shorthand) Operator Examples
var counter = 10
//counter = counter + 5 //Common Method
counter += 5 //Compound Assignment (Shorthand) Operator Ex01
print(counter)
counter *= 2 //Compound Assignment (Shorthand) Operator Ex0
print(counter)
counter -= 10 //Compound Assignment (Shorthand) Operator Ex0
print(counter)
counter /= 2 //Compound Assignment (Shorthand) Operator Ex0
print(counter)


//BOOLEAN Functionality with Int Data Type
let number = 120
print(number.isMultiple(of: 3)) //TRUE/FALSE value of "number" is made up of multiple "3"
//Another Method without creating a new Constant
print(120.isMultiple(of: 3)) //TRUE/FALSE value of "120" is made up of multiple "3"
