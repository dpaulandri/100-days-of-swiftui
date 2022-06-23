import UIKit


//Method 1 - using the "+"
let firstPart = "Hello, "
let secondPart = "world!"
let greeting = firstPart + secondPart
print(greeting) //"Hello, world!"

//Method 1B - using the "+" & Operator Overloading
let people = "Haters"
let action = "hate"
let lyric = people + " gonna " + action //<- "Operator Overloading"
print(lyric) //"Haters gonna hate"


//Operator Overloading with String value
let luggageCode = "1" + "2" + "3" + "4" + "5" //Value = "12345"
//How the Operator Overloading works to join the values together:
//Step1 - "12" + "3" + "4" + "5"
//Step2 - "123" + "4" + "5"
//Step3 - "1234" + "5"
//Step4 - "12345"  <-Final value
//This method of Operator Overloading is Not optimal for use to join many things
//The better solution is to use "String Interpolation" method in Swift


//Method 2 - using String Interpolation "\(var/letName)"
//We are able to join not just String values, but also adding an Int or Double Data value. They all work with String Interpolation joining method!
let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message)

let childName = "Noah"
let toddlerAge = 6
let noahMessage = "Hello, my name is \(childName), I'm \(toddlerAge) year old."
print(noahMessage)

let number = 11
let missionMessage = "Apollo \(number) landed on the moon."
print(missionMessage)

//We can also include Calculation with String Interpolation
print("5 x 5 is \(5 * 5)")
print("Noah is \(12/2) years old")
