import UIKit


//PROPERTY OBSERVERS - 'willSet' & 'didSet'

//Example: 'Game' struct
//Creates a Game struct, and modifies its ‘score’ a few times. Each time the ‘score’ changes, a print()line follows it so we can keep track of the changes.
struct Game {
    var score = 0 // 'score' Property with initial default value 0
}

var game = Game() //New Variable 'game' Instance
game.score += 10 //modify 'score' property by adding 10
print("Score is now \(game.score)") //Result: "Score is now 10"
game.score -= 3 //modify 'score' property by subtracting 3
print("Score is now \(game.score)") //Result: "Score is now 7"
game.score += 1 //modify 'score' property by adding 1
//BUG ALERT! No 'print()' line for after the last 'score' modification!!!



//Solving the potential of having the above "BUG" by using 'didSet' Property Obeserver
struct GameObserved {
    var score = 0 {
        //'didSet' Property Observer that run codes WHEN the Property has jusr changed
        didSet { //'didSet' will run the code inside { } WHEN there's a change in 'score' Property value
            print("Score is now \(score)")
        }
    }
}

var gameOb = GameObserved()
gameOb.score += 10 //Result: "Score is now 10"
gameOb.score -= 3 //Result: "Score is now 7"
gameOb.score += 1 //Result: "Score is now 8"



struct swiftDay {
    var day = 0 {
        didSet {
            print("You're on Day \(day) of #100OfSeiftUI!")
        }
    }
}

var paulLog = swiftDay()
paulLog.day += 1 //Result: "You're on Day 1 of #100OfSeiftUI!"
paulLog.day += 1 //Result: "You're on Day 2 of #100OfSeiftUI!"
paulLog.day += 1 //Result: "You're on Day 3 of #100OfSeiftUI!"




//DEMONSTARTION 'willSet' & 'didSet' PROPERTY OBSERVERS
struct App {
    var contacts = [String]() {
        willSet { //'didSet' will run the code inside { } BEFORE there's a change in 'contacts' Property value
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)") //'newValue' constant that is Swift provided
            //'newValue' is only available in 'willSet'
        }

        didSet { //'didSet' will run the code inside { } WHEN there's a change in 'contacts' Property value
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)") //'oldValue' constant that is Swift provided
            //'oldValue' is only available in 'didSet'
        }
    }
}

var app = App()
app.contacts.append("Adrian E") //append "Adrian E" to 'contacts' Property's String Array
/* PRINT RESULTs:
 Current value is: []
 New value will be: ["Adrian E"]
 There are now 1 contacts.
 Old value was []
*/

app.contacts.append("Allen W") //append "Allen W" to 'contacts' Property's String Array
/* PRINT RESULTs:
 Current value is: ["Adrian E"]
 New value will be: ["Adrian E", "Allen W"]
 There are now 2 contacts.
 Old value was ["Adrian E"]
*/

app.contacts.append("Ish S") //append "Allen W" to 'contacts' Property's String Array
/* PRINT RESULTs:
 Current value is: ["Adrian E", "Allen W"]
 New value will be: ["Adrian E", "Allen W", "Ish S"]
 There are now 3 contacts.
 Old value was ["Adrian E", "Allen W"]
*/

print(app.contacts) //Result: ["Adrian E", "Allen W", "Ish S"]

