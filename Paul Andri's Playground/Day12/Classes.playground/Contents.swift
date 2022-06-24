import UIKit


//CLASSES

//CREATE & USE CLASSES
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

//Calling & using a Class
var newGame = Game()
newGame.score += 10 //Result: Score is now 10
