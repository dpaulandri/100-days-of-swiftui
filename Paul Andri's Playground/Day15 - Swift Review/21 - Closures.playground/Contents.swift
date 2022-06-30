// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// CLOSURES { }
// Assign Functionality directly to a 'let' or 'var
// Syntax: 'let' OR 'var' 'name = { Closure's Body }'

// Ex: a simple Closure w/ 'print()' function
let sayHello = {
    print("Hi there!")
}

//Call Closure
sayHello()  // Prints: "Hi there!"



//IF you want the Closure to ACCEPT Parameters, they MUST be written INSIDE { }
// Ex: a Closure that ACCEPT Parameters & returns a 'String' value
let sayHelloAgain = { (name: String) -> String in "Hi \(name)!"}
// 'in' is used to MARK the END of the Parameters and return Type
// Everything AFTER that is the body of the Closure itself



// Ex: filter an Array to include ONLY names that begin with T
let team = ["Gloria", "Suzanne", "Tiffany", "Tasha"]

// Use Closure inside Array's 'filter()' Method to find elements in 'team' that starts w/ a Prefix "T" AND returns them into a new Array called 'onlyT'
// This Closure accept a 'name: String' Parameter
let onlyT = team.filter({ (name: String) -> Bool in return name.hasPrefix("T")
})
/* CLOSURE CODE BREAKDOWN:
 - Inside the Closure we list the Parameter 'filter()' passes us: a String from the Array.
 - Our Closure returns a 'Bool'
 - Mark the start of the Closure’s code by using 'in'
 – Everything else AFTER 'in' is normal Function code.
 */



// Single line Closures DO NOT NEED 'return' Keyword
let onlyTNoReturn = team.filter({ (name: String) -> Bool in
    name.hasPrefix("T") // NO 'return' KEYWORD NEEDED
    
})


/* 'filter()' MUST be given a Function that ACCEPTS one item from its Array, and RETURNS true IF it should be in the returned Array
 
 Because the Function we pass in MUST behave like that, we DON’T need to specify the Types in our Closure*/
let onlyTNoTA = team.filter({ name in
    name.hasPrefix("T")
})

print(onlyTNoTA)    // Prints: "["Tiffany", "Tasha"]"


// TRAILING CLOSURE
// Using special syntax called Trailing Closure Syntax
// Parentheses '( )' NOT NEEDED
let onlyTTrailing = team.filter { name in // NO '( )' NEEDED!
    name.hasPrefix("T")
}


// SHORTHAND SYNTAX - '$0' '$1' '$2'
// Swift can provide Short Parameter Names for us so we DON’T even write name in any more, and instead rely on a specially named value provided for us: $0:
let onlyTSH = team.filter {
    $0.hasPrefix("T")
}

print(onlyTSH)    // Prints: "["Tiffany", "Tasha"]"
