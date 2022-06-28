// Created by Paul Andri on 28/06/2022

import UIKit


//OPTIONAL CHAINING '?' - a simplified syntax for READING Optionals INSIDE Optionals
// Optional chaining allows us to say “IF the Optional HAS a value inside, Unwrap it THEN…” and we can add more code


//OPTIONAL CHAINING
let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one" //'?' OPTIONAL CHAINING
/* COMMENT:
 IF we managed to GET a random element from the Array, THEN “uppercase” it.”
 Remember, randomElement() returns an Optional BECAUSE the Array might be EMPTY
 Optional chaining DOES NOTHING IF the optional was EMPTY,
 The return value of an Optional chain is ALWAYS an Optional,
 Which is why we still NEED '??' to provide a Default value */

print("Next in line: \(chosen)")
//Prints: "Next in line: (UPPERCASED randomElement from 'names' Array)"



//Ex: Place books in alphabetical order based on their author names
struct Book {
    let title: String
    let author: String? //Property w/ Optional String value
}

var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "A"
/* OPTIONAL CHAINING COMMENT:
 - IF we HAVE a book,
 - AND the book HAS an author,
 - AND the author HAS a first letter,
 - THEN UPPERCASE it AND send it back,
 - OTHERWISE send back “A” */

print(author) //Prints: "A"




//OPTIONAL MATERIALS

//Ex: Optional Chaining W/O '??' Default value
let painterNames = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = painterNames["Vincent"]?.first?.uppercased() //Returns: "V"


//Ex: Optional Chaining WITH '??' Default value
let surnameLetterNC = painterNames["Michael Angelo"]?.first?.uppercased() ?? "?" //Returns: ?
