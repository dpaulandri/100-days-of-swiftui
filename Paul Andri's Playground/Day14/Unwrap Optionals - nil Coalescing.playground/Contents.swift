// Created by Paul Andri on 28/06/2022

import UIKit
import Darwin


// nil COALESCING OPERATOR '??'

//Example:
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] //tried to read a NON-existent Key in our captains Dictionary
//Constant 'new' will be an Optional String to set to 'nil'


//Use nil Coalescing Operator '??' to provide a Default value for any Optional
let newNilCoalescing = captains["Serenity"] ?? "N/A"
/* Attempt to read the value from the captains Dictionary and ATTEMPT to Unwrap it.
 IF the Optional has a value inside it will be sent back and stored in new,
 but IF IT DOESN’T then “N/A” will be used instead */

print(newNilCoalescing) //Prints: "N/A"



// Providing a 'default' value to use instead of using Coalescing Operator '??'
// Produces EXACTLY the same result as using '??' when working with Dictionary
let newDictionaryDefault = captains["Serenity",default: "N/A"]
print(newDictionaryDefault) //Prints: "N/A"




//"nil COALESCING OPERATOR" WORKS WITH ANY OPTIONALS

// Ex: Using '??' to provide a Default value for Array's 'randomElement()' Method
/* Note: Array's 'randomElement()' Method would've return an Optional without using '??',
 BECAUSE you might be calling it on an empty Array */
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"] //A constant String Array

//Create a new Constant out of a randomElement() from 'tvShows' String Array (not Empty)
// Using '??' to provide a Default value for Array's 'randomElement()' Method
let favorite = tvShows.randomElement() ?? "None"
//Will always return a different random item from 'tvShows' String Array on each run



//Ex2: Using '??' to provide a Default value for Array's 'randomElement()' Method
//An Empty String Array
let babyNames = [String]()
//Create a new Constant out of a randomElement() from 'babyNames' String Array (EMPTY)
// Using '??' to provide a Default value for Array's 'randomElement()' Method
let pickAName = babyNames.randomElement() ?? "No Name"
//Will always return Default value provided by ?? as long as the Array is EMPTY




//Ex: a Struct with an Optional Property, using '??' to provide a Default value
struct Book {
    let title: String //a NON-Optional Property
    let author: String? //an OPTIONAL Property
}

//Create a new Instance with Initilizer values ('author' Optional Value set to 'nil')
let book = Book(title: "Beowulf", author: nil)
//Create new Constant with value taken from 'book's 'author' Property value
let author = book.author ?? "Anonymous" //Used '??' to provide a Default value
print(author) //Prints: "Anonymous"  <- the Default value provided using '??'




/* Ex: Create an Integer from a String,
 where you actually get back an Optional 'Int?' BECAUSE we might have provided an INVALID Integer,
 CAUSING the conversion to FAILED.
 We can use nil Coalescing to provide a Default value */

//Provided an Empty String as 'input' value
let input = ""

//Trying to create an Int out of the value of 'input' which have a INVALID Int value
let number = Int(input) //returns a 'nil' Optional value
print(number) //Prints: 'nil'


//Trying to create an Int out of the value of 'input' which have a INVALID Int value
//But we provide a Default value using '??' IN CASE it FAILS
let numberilCoalescing = Int(input) ?? 0
print(numberilCoalescing)  //Prints: '0'  <- Default value provided by '??'





//OPTIONAL MATERIALS

//Ex: Working on a Chat app and wanted to load whatever message draft the user had saved

//CODE: let savedData = loadSavedMessage() ?? ""
/* COMMENT: IF 'loadSavedMessage()' returns an Optional with a 'String' inside,
 it will be Uwrapped and placed into 'savedData'.
 BUT IF the Optional is ’nil’ THEN Swift will set 'savedData' to be an empty String.
 Either way, 'savedData' will end up being a 'String' and NOT a 'String?'
 */



//Ex: Chaining multiple '??'

//CODE: let savedData = first() ?? second() ?? ""
/* COMMENT: This codes will attempt to run first(),
 and IF that returns ‘nil’ attempt to run second(),
 and IF that returns ‘nil’ then it will use an empty String "" */

 
 
//Ex: Use '??' to ensure return of NON-Optional value from a Dictionary
let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0 //Returns: 0  <- Default value from '??'
/* COMMENT: Reading a Dictionary Key will ALWAYS return an Optional,
 So you MIGHT want to use nil Coalescing here to ensure you get back a NON-Optional */


//Ex: Specific to Dictionary, It's own approach for adding a Default value
let crusherScoreDictDefault = scores["Crusher",default: 0] //Returns: 0 <- Dictionary's Default value
