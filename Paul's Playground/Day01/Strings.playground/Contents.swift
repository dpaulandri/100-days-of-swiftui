import UIKit

var greeting = "Hello, playground"


//String Data Type is Case-sensitive
let actor = "Denzel Washington" //Case-sensitive


//Punctuation marks, Emojis, and other Chracters as Data value in String Data Type
let filename = "paris.jpg" //Case-sensitive
let result = "⭐️ You win! ⭐️" //Case-sensitive


//Inserting Double Quote (") signs in String Data value
let quote = "Then he tapped a sign saying \"Believe\" and walked away."
//Case-sensitive


//Multi line break String Data value
//Incorrect Method
//let movie = "A dayin
//the life of an
//Apple engineer"

//Correct Method (using """...""")
let movie = """
A day in
the life of an
Apple engineer
"""
//Case-sensitive


// .count = reaing the length of a String value
//reading the length of the String value of "let actor = "Denzel Washington""
print(actor.count)
//another Method by cerating a new Constant
let nameLength = actor.count
print(nameLength)

//reading the length of the String value of
//let quote = "Then he tapped a sign saying \"Believe\" and walked away."
print(quote.count)
//another Method by cerating a new Constant
let quoteLength = quote.count
print(quoteLength)


//Printing String value of the Constant "result" in Uppercase/Captial letter foomat
print(result.uppercased())
//Printing String value of Constant "actor" in Uppercase/Captial letter foomat
print(actor.uppercased())


//Checking TRUE/FALSE that the Constant "movie" value starts with the Prefix "A day"
print(movie.hasPrefix("A day")) //Case-sensitive
//Checking TRUE/FALSE that the Constant "actor" value starts with the Prefix "denzel"
print(actor.hasPrefix("denzel")) //Case-sensitive
//Checking TRUE/FALSE that the Constant "actor" value starts with the Prefix "Denz"
print(actor.hasPrefix("Denz")) //Case-sensitive


//Checking TRUE/FALSE that the Constant "filename" value ends with the Suffix ".jpg"
print(filename.hasSuffix(".jpg")) //Case-sensitive
//Checking TRUE/FALSE that the Constant "filename" value ends with the Suffix "Ton"
print(actor.hasSuffix("Ton")) //Case-sensitive
//Checking TRUE/FALSE that the Constant "filename" value ends with the Suffix "ton"
print(actor.hasSuffix("ton")) //Case-sensitive
