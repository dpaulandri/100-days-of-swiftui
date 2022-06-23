import UIKit


//Constant & Variable - TYPE INFERENCE
let surnameTI = "Lasso"
var scoreTI = 0

//Constant & Variable - TYPE ANNOTATION
let surnameTA: String = "Lasso"
var scoreTA: Int = 0
var scoreTAALT: Double = 0


//TYPE ANNOTATION Examples
//Simple Data Types
let playerName: String = "Roy" //String
var luckyNumber: Int = 13 //Int
let pi: Double = 3.141 //Double
var isAuthenticated: Bool = true //Bool

//Complex Data Types
var albums: [String] = ["Red", "Fearless"] //String-Array
var user: [String: String] = ["id": "@twostraws"] //String-Dictionary
var books: Set<String> = Set([ //String-Set
    "The Bluest Eye",
    "Foundation",
    "Girl, Woman, Other"
])

//Type Annotation is NOT needed for Arrays with Initial Value/Data,
//because Swift can automatically Type Reference using the initial Value
var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"] //Array w/ Initial Value/Data

//Type Annotation is NOT needed for Arrays without Initial Value/Data,
//You still need to know that an array of strings is written as [String] so that you can make the thing
var teamsTA: [String] = [String]() //empty Array with TYPE ANNOTATION
var teamsTI = [String]() //empty Array with TYPE INFERENCE
//Remember, you need to add the open and close parentheses ( ) when making empty arrays, dictionaries, and sets, because it’s where Swift allows us to customize the way they are created


//2 Methods to create empty Array
var cities: [String] = [] //TYPE ANNOTATION Method
var clues = [String]() //TYPE INFERENCE Method, Paul's preferred Method


//ENUMS Type
enum UIStyle { //"UIStyle" is the Data Type in Enum, no TYPE ANNOTATION NECESSARY
    case light, dark, system
}

var style = UIStyle.light
style = .system
//SWIFT auto TYPE INFERENCE subsequent "style" to "UIStyle" Data Type


//Using TYPE ANNOTATION for Constant that we don't have a Value at creation
var username: String //empty Constant with String TYPE ANNOTATION (requires it)
//Some other codes here in between
/*loc
 loc
 loc
 */
username = "@twostraws" //Added a String Value later on
//loc
print(username) ///returns:"@twostraws"


//Example of Invalid code, even with TYPE ANNOTATION
//SWIFT can't store a String Value into an Int-type Constant
let score: Int = "Zero"
