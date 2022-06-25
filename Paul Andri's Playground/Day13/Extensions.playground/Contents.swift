import UIKit


//EXTENSIONS

//'trimmingCharacters(in:)'
//a String Method that REMOVES certain kinds of Characters from the START or END of a String
//Ex: a String that has white spaces on either side
var quote = "   The truth is rarely pure and never simple   "
print(quote) //Print: "   The truth is rarely pure and never simple   "

//Using 'trimmingCharacters(in: .whitespacesAndNewlines)' to trim Whitespace & New lines
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)
print(trimmed) //Print: "The truth is rarely pure and never simple"


//Writing an Extension that adds 'trimmingCharacters(in:)' String Method to Swfit's String Data Type
extension String { //'extension': add 'func' Method to an existing Type (String)
    func trimmed() -> String { //Add a Method called 'trimmed()', returns a new String
        self.trimmingCharacters(in: .whitespacesAndNewlines)
        //'self' : auto-refers to the current String, because we're currently in a String Extension
        //call 'trimmingCharacters(in: .whitespacesAndNewlines)' Method
        //then "return" its result as a new String value to 'trimmed()' Method
    }
}

//Call 'trimmingCharacters(in: .whitespacesAndNewlines)' Method inside 'String' Extension
let trimmedExt = quote.trimmed()
print(trimmedExt) //Print: "The truth is rarely pure and never simple"





//GLOBAL FUNCTIONs - a 'func' that is vailable everywhere in our Project
//Uses LESS code than an Extension: in terms of MAKING & USING it
//Writing a Global Function instead of an Extension
func trim(_ string: String) -> String { //Accept a String Parameter & returns a String value
    string.trimmingCharacters(in: .whitespacesAndNewlines) //Method applied to 'string' input Value
}

//Call 'trim' Functionality using 'quote' as its Parameter Value
let trimmed2 = trim(quote)
print(trimmed2) //Print: "The truth is rarely pure and never simple"




//USING A METHOD in EXTENSION TO MOIDFY THE STRING DIRECTLY
extension String { //'extension': add 'func' Method to an existing Type (String)
    mutating func trim() { //Mutaing Method that DOES NOT RETURN A VALUE
        self = self.trimmed() //refers to its own Value & called the 'trimmed' Extension Method
    }
}

//Because 'quote' is a 'var', we can trim 'quote' Value in Place, w/o using a Method that returns Value
quote.trim() //Print: "The truth is rarely pure and never simple"






//ADDING PROPERTIES TO TYPES using EXTENSION

//Add a Property 'lines' into String Extension
//It breaks the String up into an Array of individual lines
extension String {
    var lines: [String] { //'line' Property that stores its Value in a String Array
        
        //String Method: components(separatedBy:)
        //Breaks the String up by splitting it on a BOUNDARY of our choosing
        self.components(separatedBy: .newlines)
        //Breaks the String up by splitting it on each new line
        
    }
}

//Create a Constant with multilines String Value
let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

//Using the 'lines' Property on 'lyrics' Constant String Value
print(lyrics.lines)
/* Resulted 'lines' Value:
["But I keep cruising", "Can\'t stop, won\'t stop moving", "It\'s like I got this music in my mind", "Saying it\'s gonna be alright"]
*/






//Ex: Struct w/ Custom Initializer (Memberwise Initializer DISABLED)
struct BookCustInit {
    let title: String
    let pageCount: Int
    let readingHours: Int
    
    init(title: String, pageCount: Int) { //Custom Initializer w/ Parameters
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50 //Custom Logic to computed Property value of 'readingHours'
    }
}
 



//HAVING BOTH CUSTOM & MEMBERWISE INITIALIZER in a STRUCT

//Ex: Struct w/ Memberwise Initializer
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}


//Add Custom Initializer in the Strut's Extension
//THIS WON'T DISABLE THE MEMBERWISE INITIALIZER FROM THE ORIGINAL STRUCT
extension Book {
    init(title: String, pageCount: Int) { //Custom Initializer
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50 //Custom Logic to compute 'readingHours' Property Value
    }
}


//Struct Instance using Memberwise Initializer values
let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)
lotr.title
lotr.pageCount
lotr.readingHours

//Struct Instance using Custom Initializer values
let harryPotter = Book(title: "Harry Potter", pageCount: 2150)
harryPotter.readingHours
