// Created by Paul Andri on 28/06/2022

import UIKit
import Darwin


//CHECKPOINT 9

/* Your challenge is this:
 1. Write a Function that accepts an Optional Array of Integers, and returns one randomly
 2. IF the Array is missing OR empty, return a random number in the range 1 through 100**.

 If that sounds easy, it’s because I haven’t explained the catch yet:
 I want you to WRITE YOUR FUNCTION IN A SINGLE LINE OF CODE.
 No, that doesn’t mean you should just write lots of code then remove all the line breaks,
 you should be able to WRITE THIS WHOLE THING IN ONE LINE OF CODE.
 */



//Paul Andri's Solution
func randomInt(_ array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

//Send 'nil' value back to 'randomInt's parameter
randomInt(nil)
//ALWAYS returns a Random Int between 1-100


//Send an Int Array back to 'randomInt's parameter
let anIntArray = [1, 3, 7, 9, 11]
randomInt(anIntArray)
//ALWAYS returns a Random Element from 'anIntArray'

