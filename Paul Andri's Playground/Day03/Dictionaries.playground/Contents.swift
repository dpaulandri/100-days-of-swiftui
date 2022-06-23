import UIKit


//Example where using Arrays might not be the appropriate Method to access datas
var employee = ["Taylor Swift", "Singer", "Nashville"]
print("Name: \(employee[0])")
employee.remove(at: 1) //This loc removed "Singer" from the Array
print("Job title: \(employee[1])")
//print("Location: \(employee[2])") <- triggers error: Index out of range


//The solution im Swift is to use Dictionary
//Dictionaries don’t store items according to their position like Arrays do, but instead let us decide where items should be stored
let employee2 = [
    "name": "Taylor Swift", //"name" is "the Key" & "Taylor Swift" is "the Value"
    "job": "Singer",
    "location": "Nashville"]

print(employee2["name"]) //retuns: Optional("Taylor Swift")
print(employee2["job"]) //returns: Optional("Singer")
print(employee2["location"]) //returns Optional("Nashville")
//Regarding "Optional";
//Swift calls these Optionals because the existence of data is optional - it might be there or it might not.

//With Dictionary, unlike Array, our App doesn't crash even if we try to access Key value that don't exist like the example below
print(employee2["password"]) //returns: nil
print(employee2["status"]) //returns: nil
print(employee2["manager"]) //returns: nil


//We could also provide the default value to use in case the data doesn't exist in Dictionary
print(employee2["name",default: "Unknown"]) //returns: "Taylor Swift"
print(employee2["job",default: "Unknown"]) //returns: "Singer"
print(employee2["location",default: "Unknown"]) //returns: "Nashville"
print(employee2["maritalStatus",default: "Unknown"]) //returns: "Unknown" <- default Value


//Diictionary can have unique Data Type for each of its Key & its Value
//Example: Dictionary with String-Key Bool-Value
let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false,
]

//The default value below need to be in Boolean type!
print(hasGraduated["Maeve",default: false]) //returns: "true"
print(hasGraduated["Paul",default: false]) //returns: "false" <-default Value


//Example: Dictionary with Int-Key String-Value
let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo",
]

print(olympics[2012,default: "Unknown"]) //returns: "London"
print(olympics[2022,default: "Unknown"]) //returns: "Unknown" <- default Value


//Creating empty Dictionary & add new Keys & Values after
//Example:  [Key-String: Value-Int]()
var heights = [String: Int]() //[Key-DataType: Value-DataType]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

print(heights["Yao Ming",default: 0]) //returns: 229
print(heights["Paul",default: 0]) //returns: 0 <-default Value

//Example:  [Key-Int: Value-Bool]()
var forFun = [Int: Bool]()
forFun[1] = true
forFun[2] = false
forFun[3] = false
forFun[4] = true

print(forFun[1,default: false]) //returns: true
print(forFun[10,default: false]) //returns: false <-default Value


//Dictionary doesn't allow duplicate "Key"
//New Values will overwrite the existing Value in the Dictionary
var archEnemies = [String: String]() //[Key-String: Value-String]()
archEnemies["Batman"] = "The Joker"
print(archEnemies["Batman",default: "Unknown"]) //returns : "The Joker"

archEnemies["Superman"] = "Lex Luthor"
print(archEnemies["Superman",default: "Unknown"]) //returns : "Lex Luthor

archEnemies["Batman"] = "Penguin" //This loc replaces "The Joker" from "Batman"'s Value
print(archEnemies["Batman",default: "Unknown"]) //returns : "Penguin"

print(archEnemies["Thor",default: "Unknown"]) //returns : "Unknown" <-default Value

