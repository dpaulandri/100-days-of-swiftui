// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// CONSTANTS 'let' & VARIABLES 'var'
// Create a Variable
var name = "Ted"
name = "Rebecca" // Change/overwrite 'name's String value


// Create a Constant - PREFERABLE
let user = "Daphne"

// 'print()' func - HELPFUL FOR LEARNING & DEBUGGING
print(user)





// STRINGS 'String' - Simple Data Type
// STRINGS ARE CASE-SENSTIVE

// Starts & ends with " "
let actor = "Tom Cruise"


// Works w/ Emoji too
let actorEmoji = "Tom Cruise 🏃‍♂️"


// Use Backslash ' \ ' before ' " ' to use it inside your String
let quote = "He tapped a sign saying \"Believe\" and walked away."


// Use  ' """ """ ' for String values that spans multiple lines
let movie = """
A day in
the life of an
Apple engineer
"""


// '.count' func - read how many item count
print(actor.count)

// '.hasPrefix()' - whether a String starts with specific letters
// '.hasSuffix()' - whether a String ends with specific letters
// Returns Bool: true or false
print(quote.hasPrefix("He"))
print(quote.hasSuffix("Away."))





// INTEGERS 'Int' - Simple Data Type
// WHOLE NUMBERS

// Supports a range of standard mathematical operators
let score = 10
let higherScore = score + 10
let halvedScore = score / 2


// Supports Compound Assignment Operators that modify Variables in place
var counter = 10
counter += 5 // Add 5 to current 'counter' value


// Has its own useful Functionalities, such as:
// 'isMultiple(of:)' Method - check whether an Int value is a mutiple of x
let number = 120
print(number.isMultiple(of: 3)) // Check whether 'number' value is a multiple of 3
// Returns Bool: true or false

// 'Int.random(in: x...y) - make random Integers in a specific range
let id = Int.random(in: 1...1000)   // '1...100' 1-100 Closed Range Operator





// DECIMALS 'Double' - Simple Data Type
// A number with Decimal point (ie. 0.00), CAN'T BE MIXED WITH 'Int' Data Type

// A Constant with 'Double' value
let scoreDecimal = 3.0





// BOOLEANS 'Bool' - Simple Data Type
// Value is either 'true' or 'false'

// Constants w/ 'Bool' value
let goodDogs = true
let gameOver = false


// 'toggle()' Method - flip a Boolean from 'true' to 'false'
var isSaved = false
isSaved.toggle()    // Flip current 'isSaved' value





// STRING INTERPOLATION - Syntax: ‘\(data)’
// Create Strings out of other Data using String Interpolation

// Example:
let nameTayTay = "Taylor"
let age = 26
let message = "I'm \(nameTayTay) and I'm \(age) years old."
print(message)  // Prints: "I'm Taylor and I'm 26 years old."





// ARRAYS '[ ]' - Complex Data Type
// Group Itmes into an Array Collection

// Array Examples:
var colors = ["Red", "Green", "Blue"]   // 'String' Array
let numbers = [4, 8, 15, 16]    // 'Int' Array
var readings = [0.1, 0.5, 0.8]  // 'Double' Array


// Read Data from Array by using its Index #/ Indecis (start from 0)
// Code will CRASH IF an item DIDN'T exists at the Index
print(colors[0])    // '0' = 1st Position - Prints: "Red"
print(readings[2])  // '2' = 3rd Position - Prints: "0.8"

// Use 'append()' to add new items into a 'var' type Array
// The type of Data you add must match whatever was already in there
colors.append("Tartan")
// Add a new 'String' value "Tartan" into the existing 'colors' 'String' type 'var' Array


// Has its own useful Functionalities, such as:
// '.count' - count how many items are in an Array
colors.remove(at: 0)    // Remove the item at Index position '0'

// 'remove(at:)'' - remove one item at a specific Index
print(colors.count) // Count how many items are in 'colors' Array

// '.contains()'- check whether an Array contains a particular item
print(colors.contains("Octarine"))
// check whether 'colors' Array contains "Octarine"





// DICTIONARIES '[Key: Value]' - Complex Data Type
// Store multiple Values according to a Key we specify

// A [String: String] Dictionary that store information about a person
let employee = [
    "name": "Taylor",
    "job": "Singer"
]

// Use "Key" to read Data from a Dictionary
// 'default' value will be used IF the Key we’ve asked for DOESN’T exist
print(employee["name",default: "Unknown"])
print(employee["job",default: "Unknown"])





// SETS 'Set([ ])'
// Similar to Arrays
// CAN’T add duplicate items - Set will IGNORE duplicate values
// DON’T store items in a particular order - WON’T remember the order used in the Array

// Ex: Create a Set of Int numbers
var numberSet = Set([1, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21])
print(numberSet)

// '.insert()' Method - Add an item to a Set
numberSet.insert(10)
print(numberSet)

// ONE BIG ADVANTAGE OVER ARRAYS:
// Using 'contains()' on a Set is effectively instant NO MATTER how many items the Set contains
print(numberSet.contains(0))





// ENUMS 'enum' - Complex Data Types
// A set of named Values we can create and use, makes our code more efficient and safer

// Ex: An 'enum' of Weekdays
enum Weekday {
    case Monday, Tuesday, Wednesday, Thursday, Friday
}

// Make an Instance out of 'Weekday' w/ initial case value 'Monday'
var day = Weekday.Monday
// Assign poissibile Enum cases to the Instance
day = .Friday
print(day)





// TYPE ANNOTATIONS
// Force a specific Type for a new 'var' or 'let'

// Create a new 'var' with a Type Annotation set to 'Double'
var scoreType: Double = 0
// Without the ': Double', Swift would infer that to be an 'Int'
print(scoreType)    // Prints: 0.0 <- Stored & printed as a 'Double' value


// Examples of different Type Annotations
let player: String = "Roy"  // 'String' TA
var luckyNumber: Int = 13   // 'Int' TA
let pi: Double = 3.141  // 'Double' TA
var isEnabled: Bool = true  // 'Bool' TA
var albums: Array<String> = ["Red", "Fearless"] // '[String]' TA
// [String: String] TA
var userDict: Dictionary<String, String> = ["id": "@twostraws"]
// 'Set([String])' TA
var books: Set<String> = Set(["The Bluest Eye", "Foundation"])

// Special Syntax for Arrays & Dictionaries TA
var albumsSArr: [String] = ["Red", "Fearless"]  // '[String]' TA
var userSDict: [String: String] = ["id": "@twostraws"]   // [String: String] TA


// Knowing the exact Types of things is IMPORTANT for creating empty Collections
// Ex: Both of these create empty String Arrays
var teams: [String] = [String]()
var clues = [String]()


// Values of an ENUM have the SAME TYPE as the Enum itself
enum UIStyle {
    case light, dark, system
}

var style: UIStyle = .light





// CONDITIONS - 'if' 'else' 'else if' STATEMENTS
// Use to check a Condition and run some code as appropriate

//Ex:
let ageNow = 16

if ageNow < 12 {
    print("You can't vote")
} else if ageNow < 18 {
    print("You can vote soon.")
} else {
    print("You can vote now.")
}
// Prints: "You can vote soon."


// Use AND '&&' & OR '||' to combine two Conditions
let temp = 26
// '&&' AND
if temp > 20 && temp < 30 { // IF temp > 20 AND temp < 30
    print("It's a nice day.")
}   // Prints: "It's a nice day."

// '||' OR
if temp > 20 || temp < 30 { // IF temp > 20 OR temp < 30
    print("It's a nice day.")
}   // Prints: "It's a nice day."





// SWITCH STATEMENTS 'switch' 'case'
// Check a value against multiple Conditions ('case')
enum Weather {  //  'Weather' Enum & its cases
    case sun, rain, wind
}

// Make an Instance out of 'Weather' w/ initial case value 'sun'
let forecast = Weather.sun

// Check 'forecast' value by using 'switch' & ref. its 'case's from 'Weather'
switch forecast {
    case .sun:  // IF 'forecast' value is 'Weather.sun'
    print("A nice day.")
    case .rain:  // IF 'forecast' value is 'Weather.rain'
    print("Pack an umbrella.")
    default: // ELSE ('switch' Statements MUST be EXHAUSTIVE)
    print("Should be okay.")
}





// THE TERNARY CONDITIONAL OPERATOR
// Check a Condition AND return one of two values: 'x' IF 'true', AND 'y' IF 'false'

// Example:
let ageCurrent = 18
let canVote = ageCurrent >= 18 ? "Yes" : "No"   // WHAT ? 'true' : 'false'

// IF 'ageCurrent' IS or MORE THAN 18: return "Yes", ELSE: return "No"
print(canVote)  // Prints: "Yes"





// LOOPS - 'for' 'while'

// FOR LOOPS - 'for'
// Run some code for every item in a Collection, or in a custom range

// Example: 'for' Loop that run some code for every item in a Collection
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

//Run the code for every item in 'platforms' Array
for os in platforms {   // 'os' is a temporary 'var' for 'for' loop func
    print("Swift works on \(os).")
}
/* Print Results:
 Swift works on iOS.
 Swift works on macOS.
 Swift works on tvOS.
 Swift works on watchOS.
 */


// Example: 'for' Loop that run some code in a custom range
// Run the code for 12 Iterations (Closed Range 1...12)
for i in 1...12 {   // 'i' is a temporary 'var' for 'for' loop func
    print("5 x \(i) is \(5 * i)")
}
/* Print Results:
 5 x 1 is 5
 5 x 2 is 10
 5 x 3 is 15
 5 x 4 is 20
 5 x 5 is 25
 5 x 6 is 30
 5 x 7 is 35
 5 x 8 is 40
 5 x 9 is 45
 5 x 10 is 50
 5 x 11 is 55
 5 x 12 is 60
 */


// Run the code for 12 Interations (Half-Open Range 1..<13)
for i in 1..<13 {   // 'i' is a temporary 'var' for 'for' loop func
    print("5 x \(i) is \(5 * i)")
}
/* Print Results:
 5 x 1 is 5
 5 x 2 is 10
 5 x 3 is 15
 5 x 4 is 20
 5 x 5 is 25
 5 x 6 is 30
 5 x 7 is 35
 5 x 8 is 40
 5 x 9 is 45
 5 x 10 is 50
 5 x 11 is 55
 5 x 12 is 60
 */


// 'for' loop using '_' to omit the temporary Loop Variable
var lyric = "Haters gonna"

for _ in 1...5 {    // '_' to omit the temporary Loop Variable
    lyric += " hate"    // Add " hate" to 'lyric' Variable for every Loop Iteration
}

print(lyric)    // Prints: "Haters gonna hate hate hate hate hate"





// WHILE LOOPS - 'while'
// Execute their Loop Body until a Condition is 'false'

// Example:
var count = 10

while count > 0 {   // KEEP RUNNING WHILE 'count' value is MORE THAN 0
    print("\(count)…")  // Print this
    count -= 1  // Substract 1 from 'count's value
}
/* Print Results:
 10…
 9…
 8…
 7…
 6…
 5…
 4…
 3…
 2…
 1…
*/
print("Go!")    // Prints: "Go!"


// Use 'continue' to SKIP the current Loop iIeration AND proceed to the following one
let files = ["work.txt", "me.jpg", "sophie.jpg"]

for file in files { // Run this 'for' Loop for every item in 'files' Array
    // IF temp 'file' value HAS NO '.jpg' Suffix (end): RUN THE BODY CODE
    if file.hasSuffix(".jpg") == false {
        continue    // SKIP CURRENT LOOP ITERATION & RUN THE NEXT LOOP ITERATION (item)
    }
    // PRINT THIS IF temp 'file' value HAS '.jpg' Suffix (end)
    print("Found picture: \(file)")
}
/* Print Results:
 Found picture: me.jpg
 Found picture: sophie.jpg
 */


// Use 'break' to EXIT a Loop and SKIP ALL remaining iterations
for file in files { // Run this 'for' Loop for every item in 'files' Array
    // IF temp 'file' value HAS NO '.jpg' Suffix (end): RUN THE BODY CODE
    if file.hasSuffix(".jpg") == false {
        break    // SKIP CURRENT LOOP ITERATION & EXIT ENTIRE LOOP FUNCTION
    }
    // PRINT THIS IF temp 'file' value HAS '.jpg' Suffix (end)
    print("Found picture: \(file)")
}   // Prints NOTHING





// FUNCTIONS 'func'
// Syntax: 'func funcName(parameters) { }

// Ex: Create a new 'func'
// Parameter 'number' accept 'Int' type Argument value
func printTimesTables(number: Int) {
    for i in 1...12 {   // 'for' Loop that runs for 12 Iterations
        print("\(i) x \(number) is \(i * number)")
    }
}

//'func' Call Site
printTimesTables(number: 5) // Provided 5 as an Int Argument value for 'number' Param
/* Print Results:
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
 */



// Ex: Dice Rool 'func' that returns an 'Int' value
func rollDice() -> Int {    // '-> Int' returns an 'Int' value
    return Int.random(in: 1...6) // return an random Int value between 1-6
}

// 'func' Call Site
let result = rollDice()
print(result)   // Prints a random Int value returned from 'rollDice()' func


// We can remove 'return' keyword for 'func' that contains only a SINGLE loc
func singleCode() -> Int {
    Int.random(in: 1...100) // return an random Int value between 1-100
}

// 'func' Call Site
print(singleCode()) // Prints a random Int value returned from 'rollDice()' func





// TUPLES
// Tuples store a FIXED number of values of specific Types, a convenient way to return multiple Values from a Function
// RETURNING MULTIPLE VALUSE FROM FUNCTIONS

// Ex: Returning Multiple values from a 'func' into a Tuple
func getUser() -> (firstName: String, lastName: String) {   // 'func' returns a Tuple
    (firstName: "Taylor", lastName: "Swift")    // Tuples w/ values
}

// 'func' Call Site
let userData = getUser()
// Access the returned Tuple values from 'func' using String Interpolation
print("Name: \(userData.firstName) \(userData.lastName)")
// Prints: Name: Taylor Swift

// De-Structure 'func's returned Tuple values & get only 'firstName' value
let (firstName, _) = getUser()  // '_' tell Swift to ignore the rest
print("Name: \(firstName)") // Prints: "Name: Taylor"





// PARAMETER LABELS
// Use '_' If we DON’T want to pass a Parameter’s name when calling a Function
// An alternative is to write a SECOND NAME before the FIRST:
// one to use OUTSIDE, and one INSIDE the 'func's Body

//Ex: Used '_' to hide Parameter's EXT name,
// 'string' is used ONLY INSIDE the 'func' Body
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLd"
// Check whether 'string' value is ALL Uppercased Letters, returns 'Bool'
let resultString = isUppercase(string)  //Return 'false'


// Ex: Write an INTERNAL & EXTERNAL Parameter names
// 'for' is used OUTSIDE the 'func' Body, ie. at the Call Site's Initializers
// 'number' is used INSIDE the 'func' Body
func printTimesTables(for number: Int) {
    for i in 1...12 {   // 'for' Loop that'll run for 12 Iterations
        print("\(i) x \(number) is \(i * number)")
    }
}

// 'func' Call Site
printTimesTables(for: 5)    // Uses 'for' the EXTERNAL Parameter name
/* Print Results:
 1 x 5 is 5
 2 x 5 is 10
 3 x 5 is 15
 4 x 5 is 20
 5 x 5 is 25
 6 x 5 is 30
 7 x 5 is 35
 8 x 5 is 40
 9 x 5 is 45
 10 x 5 is 50
 11 x 5 is 55
 12 x 5 is 60
 */





// DEFAULT PARAMETER VALUE
// Write an equals '=' AFTER the Type THEN provide a Default Value

// Ex: 'func' with a Default value for its Parameter
// 'formal' has a 'Bool' Default value 'false'
func greet(_ person: String, formal: Bool = false) {
    if formal { // IF 'formal' is 'true'
        print("Welcome, \(person)!")
    } else { // ELSE (IF 'formal' is 'false')
        print("Hi, \(person)!")
    }
}

// 2 ways of calling 'greet()'
// 1. Provide ALL values back to the Parameters in the Initailizer
greet("Tim", formal: true)  // Prints: "Welcome, Tim!"

// 2. Provide value back only to Parameter 'person' in the Initailizer
// Swift will use the Default value 'false' for the Parameter 'formal'
greet("Taylor") // Prints: "Hi, Taylor!/"





// HANDLING ERRORS IN FUNCTIONS
// To handle Errors in Functions we NEED to tell Swift WHICH Errors CAN HAPPEN, write a Function that can throw Errors, then call it and handle any problems

// 1. Define the Errors that CAN occur using Enum that conform to Type 'Error'
enum PasswordError: Error { // Enum that conform to Type 'Error'
    case short, obvious // Possible 'Error' cases
}

// 2. write a Function that can THROW ERRORS
func checkPassword(_ password: String) throws -> String {   // Use 'throws' keyword
    if password.count < 5 { // IF 'password' String value counted LESS THAN 5
        throw PasswordError.short   // 'throw' 'PasswordError's 'short' case
    }
    
    if password == "12345" { // IF 'password' String value is "12345"
        throw PasswordError.obvious   // 'throw' 'PasswordError's 'obvious' case
    }
    
    if password.count < 10 { // IF 'password' String value counted LESS THAN 10
        return "OK" // Return String "OK"
    } else {    //ELSE
        return "Good"   // Return String "OK"
    }
}

// 3. call the Throwing Function by starting a 'do' block
//  Call the Function using 'try', THEN 'catch' Errors that occur

// Password String values to test
let password1 = "12345" // Will throw 'PasswordError.obvious' Error
let password2 = "1234" // Will throw 'PasswordError.short' Error
let password3 = "1234567" // Will throw "Rating: OK"
let password4 = "1234567890" // Will throw "Rating: Good"


// Start a 'do ' block to call Throwing Function in
do {
    let result = try checkPassword(password2)    // Call 'checkPassword() using 'try'
    print("Rating: \(result)")  // This will print the value of 'result' Constant
}


// 'catch' block to catch any Error that occurs (thrown from 'checkPassword()' func)
// MUST always have a catch block that can handle EVERY KIND OF ERROR
//'catch' any 'obvious' Error case from 'PasswordError' enum
catch PasswordError.obvious {
    print("Your Password is TOO COMMON!")
} catch PasswordError.short {
    print("Your Password is TOO SHORT!")
} catch { //'catch' ALL OTHER ERRORs NOT WITHIN 'PasswordError's cases
    print("OOPS! There was an error!")
}





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





// STRUCTS 'struct'
// Syntax: 'struct Name { }'
// Create custom Data Types, complete w/ Properties and Methods
// Because Structs are Data Types, it's name starts w/ UPPERCASE LETTER

// Ex: a Struct w/ its Properties ('var' or 'let') & Methods ('func')
struct Album {  // a 'struct' named 'Album'
    let title: String   // Struct's Property
    let artist: String   // Struct's Property
    var isReleased = true   // Struct's Property w/ Default Value

    func printSummary() {   // Struct's Method, accepts NO Param
        print("\(title) by \(artist)")
    }
}

// Create an Instance of the Struct w/ Initializer
let red = Album(title: "Red", artist: "Taylor Swift")
print(red.title)    // Print 'red' Instance's 'title' value
// Prints: "Red"
red.printSummary()  // Call 'red' Instance's 'printSummary()' Method
// Prints: "Red by Taylor Swift"


// Mark a Method as 'mutating func' IF we want it to be able to change its Struct's Property value(s)
struct Example {
    var isReleased = true
    
    mutating func removeFromSale() {    // Marked as a 'mutating' Method
        isReleased = false
        // Change 'isReleased' Property value to 'false'
    }
}





// COMPUTED PROPERTIES & READ 'get' WRITE 'set' PERMISSION
// Calculates its Property value every time it’s accessed/ran

// Ex: a Struct w/ Stored Property & Computed Property
struct Employee {
    let name: String  // Stored Property (no Default value)
    var vacationAllocated = 14  // Stored Property
    var vacationTaken = 0  // Stored Property

    var vacationRemaining: Int { // Computed Property value
        vacationAllocated - vacationTaken   // Computation
    }
    
    // To be able to WRITE to to a Computed Property we NEED to provide both a 'get' and a 'set' permission
    var vacationRemainingGS: Int {  // Computed Property value
        get {   // 'get' permission to READ Property value
            vacationAllocated - vacationTaken
        }

        set {   // 'set' permisison to WRITE new value to Property
            vacationAllocated = vacationTaken + newValue
        }
        // 'newValue' provided by Swift, stores whatever value the user was assigning to the Property. Available ONLY for 'set'
    }
}

var timeOff = Employee(name: "Baba", vacationTaken: 5)
timeOff.vacationRemaining   // Returns: 9 (Computed Property)

// Write value to a Read ('get') & Write ('set') Computed Property
timeOff.vacationRemainingGS = 5
timeOff.vacationRemainingGS // Returns: 5 (NOT Computed!)





// PROPERTY OBSERVERs - 'didSet' & 'willSet'
// Pieces of code that run WHEN Properties CHANGE
// 'willSet' runs BEFORE the Property changed
// 'didSet' runs WHEN the Property JUST CHANGED

// Ex: a Struct that print messages BEFORE & WHEN a Property value is changed
struct Game {
    var score = 0 {
        willSet {   // runs BEFORE the Property changed
            print("Score was \(score)")
        }
        didSet {    // runs WHEN the Property JUST CHANGED
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
/* Print Result:
 Score was 0
 Score is now 10
 */

game.score -= 3
/* Print Result:
 Score was 10
 Score is now 7
 */





// CUSTOM INITIALIZERS - 'init()'
// Special Functions that prepare a new Struct Instance to be used, ensuring ALL Properties have an initial value
// Initializers DON’T have 'func' before them, and DON’T explicitly return a value

// Ex: a Struct w/ Custom Initializer
struct Player {
    let name: String    // Struct's Property
    let number: Int     // Struct's Property

    // Custom Initializers that accept 'name' Param value
    // All Properties in the Struct MUST have a Value when this is done
    init(name: String) {
        // Assign the received 'name' Param value to the Struct's Property of the same name
        self.name = name
        
        // Assign a random 'Int' value between 1-99 to the Struct's'number' Property
        number = Int.random(in: 1...99)
    }
}





// ACCESS CONTROL
/* FOUR most common options for Access Control inside Structs:
 - `private' “DON’T let anything OUTSIDE the Struct use this.”
 - 'private(set)' “anything OUTSIDE the Struct CAN READ this, BUT DON’T let them CHANGE it.”
 - `fileprivate` “DON’T let anything OUTSIDE the CURRENT file USE this.”
 - `public` “LET anyone, anywhere USE this.”
 */

//Ex: A BankAccount Struct w/ Access Control to its Property
struct BankAccount {
    private(set) var funds = 0  // 'private(set)' Access Control
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}
/* CODE COMMENT:
 'private(set)':  READING 'funds' from OUTSIDE the Struct is FINE BUT WRITING ISN’T POSSIBLE.
 */





// STATIC PROPERTIES & METHODS - 'static'
// Add a Property or Method directly to the Struct itself w/o creating an Instance

//Ex: a Struct w/ static Properties
struct AppData {
    static let version = "1.3 beta 2"   // 'static' Property
    static let settings = "settings.json"   // 'static' Property
}
// CODE COMMENT: everywhere we need to check or display something like the app’s version number we can read 'AppData.version'





// CLASSES 'class'
// Create custom Data Types, different from Structs in five ways:

// 1. CLASS INHERITANCE - create Classes by inheriting Functionality from other Classes
class EmployeeClass {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

//Class 'Developer' inherit 'EmployeeClass' Poperty, Method & custom Initializer
class Developer: EmployeeClass {
    func work() {
        print("I'm coding for \(hours) hours.")
    }
    
    // Use 'override' to allow change/modification of an Inherited Method
    override func printSummary() {
        print("I spend \(hours) hours a day searching Stack Overflow.")
    }
}

let novall = Developer(hours: 8)    // Create a 'Developer' Class Instance
// Call Class Instance's Methods
novall.work()
// Prints: "I'm coding for 8 hours."
novall.printSummary()
// Prints: "I spend 8 hours a day searching Stack Overflow."


// 2. INITIALIZERS:
/*
 1. Swift WON'T generate a Memberwise Initializer for Classes.
 2. If a child Class has Custom Initializers, it MUST always call the parent’s Initializer AFTER it has finished setting up its own Properties.
 3. If a subClass DOESN’T have any Initializers, it automatically INHERITS the Initializers of its parent Class.
 */
class Vehicle { // Parent Class
    let isElectric: Bool    // Parent Class' Property

    init(isElectric: Bool) {    // Parent Class' Custom Initializers
        self.isElectric = isElectric
    }
}

class Car: Vehicle {    // Child Class
    let isConvertible: Bool    // Child Class' Property

    // Child Class' Custom Initializers
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        // Use 'super.init' to call parent Class' Initializer
        super.init(isElectric: isElectric)
    }
}


// 3. ALL COPIES OF A CLASS INSTANCE SHARES THE SAME DATA - Struct copies DON'T
// Changes made to one Class Instance copy will automatically change other copies
class Singer {
    var name = "Adele"
}

var singer1 = Singer()  // Create a 'Singer' Class Instance
var singer2 = singer1   // Create a Class Instance copy from 'singer1'
singer2.name = "Justin" // Changes' 'singer2' Instance copy's Property value
print(singer1.name) // Prints: "Justin"
print(singer2.name) // Prints: "Justin"


// 4. CLASSES CAN HAVE A 'DEINITIALIZER"
// Gets called WHEN the last reference to an object is DESTROYED
// EX: a Class that prints a message WHEN it’s CREATED and DESTROYED
class User {
    let id: Int
    
    init(id: Int) { // Custom Initializer
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {    // DeInitializer will run AFTER each Loop Iteration
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {    // 'for' Loop that will run for 3 Iterations
    let user = User(id: i)  //  Create a Class Instance w/ a Initializer value
    print("User \(user.id): I'm in control!")
}
/* Print Results:
 User 1: I'm alive!
 User 1: I'm in control!
 User 1: I'm dead!
 User 2: I'm alive!
 User 2: I'm in control!
 User 2: I'm dead!
 User 3: I'm alive!
 User 3: I'm in control!
 User 3: I'm dead!
*/


// 5. CHANGING A 'var' PROPERTIES VALUE INSIDE A 'let' INSTANCE IS ALLOWED
// As a result, Classes DON'T need to add 'mutating' with Methods that can change Data
class UserClass {
    var name = "Paul"
}

let userClass = UserClass() // Create a 'let' Class Instance
userClass.name = "Taylor"   // Change the Poperty value of the 'let' Class Instance
print(userClass.name)   // Prints: "Taylor"





// PROTOCOLS 'protocol'
// Protocols DEFINE Functionality we EXPECT a Data Type to support
// Ex: Define a 'Vehicle' Protocol:
protocol VehicleProtocol {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
// COMMENT: That lists the REQUIRED Methods for this Protocol to work, but DOESN’T contain any code

// Make a 'CarStruct' Struct that conforms to 'VehicleProtocol'
struct CarStruct: VehicleProtocol {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
}
// COMMENT: All the Methods listed in 'VehicleProtocol' MUST EXIST EXACTLY in 'CarStruct', with the SAME name, Parameters, and Return Types


// Write a 'func'' that accepts ANY kind of Type that conforms to 'VehicleProtocol'
func commute(distance: Int, using vehicle: VehicleProtocol) {   // 'using' Keyword
    if vehicle.estimateTime(for: distance) > 100 {
        print("Too slow!")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = CarStruct()   // Create a 'CarStruct' Struct Instance
commute(distance: 100, using: car)  // Call 'func' w/ Initializer values
// Prints: "I'm driving 100km."


// Protocols can also require Properties
protocol AnotherVehicle {
    var name: String { get }    // Required Property w/ 'get' READ PERMISSION
    var currentPassengers: Int { get set }
    // Required Property w/ 'get' READ & 'set' WRITEPERMISSION
    
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}


// We can CONFORM TO AS MANY PROTOCOL AS WE NEED
// Ex: 'struct ConformMany: VehicleProtocol, AnotherVehicle { }'





// EXTENSION 'extension'
// Extensions let us add Functionality to ANY Type (own or Swift's)
// Ex: Adding an Extension to Swift's 'String' Data Type Functionality
extension String {
    func trimmed() -> String {  // Create a 'func' called 'trimmed'
    self.trimmingCharacters(in: .whitespacesAndNewlines)
    // Using existing Swift's 'String' built-in Method
    }
}

var quoteOfTheDay = "   The truth is rarely pure and never simple   "
let trimmed = quoteOfTheDay.trimmed()   // Call the 'trimmed()' func
print(trimmed)  // Prints: "The truth is rarely pure and never simple"


// Alterntivelt, mark a 'func' as 'mutating' to change a value DIRECTLY
extension String {
    mutating func trim() {  // Mark this 'func' as 'mutating'
        self = self.trimmed()   // Utilised the previous 'trimmed()' func
    }
}

// Call 'trim()' func
quoteOfTheDay.trim()
print(quoteOfTheDay)    // Prints: "The truth is rarely pure and never simple"


// Add Computed Properties using Extension
extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
        // Computation for Computed Property value
    }
}
// COMMENT: The 'components(separatedBy:)' Method splits a String into an Array of Strings using a boundary of our choosing, which in this case is new lines

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
"""

print(lyrics.lines.count) // Prints: 2
/* CODE BREAKDOWN:
 1. Take the Multiple-line String value from 'lyrics' Variable
 2. Run it through our String Extension to create a new 'lines' Variable that will contain Computed Property values from 'lyrics' in a String Array
 3. Use 'String's ' 'count' Functionality to count the number of Item inside 'lines' String Array
*/





// PROTOCOL EXTENSION 'extension'
// Extend a whole Protocol to add Computed Properties and Method Implementations, so ANY types conforming to that Protocol get them

// Ex: ADD a Computed Property to Array, Dictionary, and Set that CONFORM to the 'Collection' Protocol
extension Collection {
    var isNotEmpty: Bool {  // Add a 'var' Computed Property
        isEmpty == false    // Computation for Computed Property value
    }
}

let guests = ["Mario", "Luigi", "Peach"]    // A Constant String Array

// Use 'isNotEmpty' - our new Computed Property from 'Collection' Protocol Extension
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}
// Prints: Guest count: 3





// OPTIONALS 'Type?'
// Represent THE ABSENCE OF DATA
// Any kind of Data can be Optional, including 'Int', 'Double', and 'Bool', as well as Instances of Enums, Structs, and Classes

//Ex: Constant that returns an Optional value from a Dictionary
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"]

let peachOpposite = opposites["Peach"]
// Returns String? special value: 'nil' (NO VALUE)
// COMMENT: attempts to read the value attached to the key “Peach”, which DOESN’T EXIST, this returns an Optional 'String?' special value 'nil'





// UNWRAPPING OPTIONALs
// Swift WON’T let us use Optional Data DIRECTLY, because it MIGHT BE EMPTY. That means we NEED to Unwrap the Optional to use it – we need to look inside to see IF there’s a value, and, IF THERE IS, take it out and use it.


// UNWRAPPING OPTIONAL with 'if let'
// `if let` runs the code inside its braces { } IF the Optional HAD a value
// The MOST COMMON way for Unwrapping Optionals
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
// Prints: "Mario's opposite is Wario"
// COMMENT: That reads the Optional value from the Dictionary, and IF it has a String inside it gets Unwrapped – the String inside gets placed into the marioOpposite Constant, and ISN’T Optional any more. Because we were ABLE to Unwrap the Optional, the Condition is a SUCCESS so the print() code is run.





// UNWRAPPING OPTIONALs with 'guard let'
/* Very similar to `if let' EXCEPT it FLIP THINGS AROUND:
 `if let` runs the code inside its braces { } IF the Optional HAD a value, and
 `guard let` runs the code IF the Optional DIDN’T have a value. */

func printSquare(of number: Int?) {
    guard let number = number else {    // Check if 'func' input value is Valid
        print("Missing input")
        print("Input can't be '\(number)'")// 'else' (IF FAIL) print this & 'return'
        return
    }
    
    // IF Checking SUCCEEDED, 'number' value can be use OUTSIDE the 'guard let' Body
    print("\(number) x \(number) is \(number * number)")
    // Use the VALID 'number' value
}
//COMMENT: use 'guard' to check a Function’s inputs are VALID, Swift REQUIRED you to use 'return' IF the check FAILS. However, IF the Optional you’re unwrapping HAS a value inside, you can use it AFTER the guard code finishes

// Calling 'printSquare' func w/ INVALID value inside the Initializer
printSquare(of: nil)
/* Print Results:
 Missing input
 Input can't be 'nil'
 */

// Calling 'printSquare' func w/ VALID value inside the Initializer
printSquare(of: 2)  //Prints: "2 x 2 is 4"





// UNWRAPPING OPTIONALs with NIL COALESCING Operator '??'
// Unwraps an Optional AND provides a Default value IF the Optional was EMPTY

// Ex: Providing a Default value using '??' in case a Constant Array is EMPTY
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
// Use '??' to provid a Default value IN CASE FAILED
let favorite = tvShows.randomElement() ?? "None"


// Ex: Use '??' to provide a Default value when creating an 'Int' Constant
let input = ""  // a 'let' with EMPTY 'String' type data

// Trying to create an 'Int' value out of 'input'
let numberInt = Int(input) ?? 0 // Provided Default value using '??'
// The conversion WILL FAIL & assign the Default value to 'numberInt'

print(numberInt)    // Prints: 0 (Default value)





// OPTIONAL CHAINING '?'
// Optional chaining reads Optionals inside Optionals
// “IF the Optional HAS a value inside, Unwrap it, THEN…” and add more code

// Ex:
let names = ["Arya", "Bran", "Robb", "Sansa"]   // a [String]

// Create a new 'let' w/ Optional Chaining
let chosen = names.randomElement()?.uppercased()
// CODE LOGIC: IF we got a random element from the Array, then, UPPERCASE it.

print("Next in line: \(chosen ?? "No one")")





// OPTIONAL 'try?'
// CONVERT the result of a Throwing Function into an Optional containing a value ON SUCCESS, OR 'nil' otherwise

//Ex:
// An Enum w/ 'Error' type casses
enum UserError: Error {
    case badID, networkFailed
}

// A 'func' that CAN 'throw' Error & returns a 'String' value
func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

// Using OPTIONAL 'try?' in 'if let' to convert the result of the Throwing Function into an Optional
if let user = try? getUser(id: 23) {
    print("User: \(user)")
}
/* COMMENT & RESULT:
 The 'getUser()' Function will ALWAYS throw networkFailed,
 but we DON’T care WHAT was thrown,
 ALL WE CARE ABOUT is WHETHER the call sent back a user OR NOT
 */

