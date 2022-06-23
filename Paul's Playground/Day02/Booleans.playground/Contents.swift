import UIKit

var greeting = "Hello, playground"


//Booleans only returns TRUE/FALSE value
let filename = "paris.jpg"
print(filename.hasSuffix(".jpg")) //TRUE

let number = 120
print(number.isMultiple(of: 3)) //TRUE

let son = "Noah Chut"
print(son.hasSuffix("Bion")) //FALSE



//Setting initial value in Booleans
let goodDogs = true
let gameOver1 = false

//Boolean initial values can only be derived from calculation/formula
let isMultiple = 120.isMultiple(of: 3) //TRUE will be the value


//Boolean values can be "FLIP" with the symbol "!"
var isAuthenticated = false //initial value FALSE
isAuthenticated = !isAuthenticated //Value will be TRUE (flipped FALSE)
print(isAuthenticated)
isAuthenticated = !isAuthenticated //Value will be FALSE (flipped TRUE)
print(isAuthenticated)


//"TOGGLE" functionality in Boolean
var gameOver2 = false //initial value FALSE
print(gameOver2)

gameOver2.toggle() // Value will be TRUE (toggled FALSE)
print(gameOver2)

//"FLIP" & "TOGGLE" functionality is similar in Boolean
//However, "TOGGLE" uses significantly lesser code than "FLIP"
