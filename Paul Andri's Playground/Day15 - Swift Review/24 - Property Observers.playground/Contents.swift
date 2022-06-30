// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

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
