// Created by Paul Andri on 27/06/2022

import UIKit
import Foundation


//'guard let' - SECOND MOST COMMON WAY TO UNWRAP OPTIONALS
/* Like 'if let', 'guard let' checks WHETHER there is a Value inside an Optional,
 and IF there is it will retrieve the value and place it into a Constant of our choosing */


//Ex: Using 'guard let' to Unwarp Optionals in a 'func' with Optional Int Parameter value
func printSquare(of number: Int?) { //'func' w/ Parameter that has a Optional Int value
    guard let number = number else {
        print("Missing input")
        return
    }
    
    print("\(number) x \(number) is \(number * number)")
}



//EXAMPLE: 'if let' VS 'guard let' way of Unwrapping
var myVar: Int? = 3 // 'myVar' have an Optional Int Data Type with a value set to 3

// 'if let' runs the code inside its braces IF the Optional HAD a value
if let unwrappedIfLet = myVar {
    print("Run if myVar has a value inside")
}
//Prints: "Run if myVar has a value inside"




// 'guard' let runs the code inside its braces IF the optional DIDN’T have a value
/*
guard let unwrappedGuardLet = myVar else {
    print("Run if myVar doesn't have a value inside")
}
 ERROR CODE: error: 'guard' body must not fall through, consider using a 'return' or 'throw' to exit the scope
 Reason:
 
 'guard' REQUIRES that we EXIT the current scope WHEN IT’S USED,
 which in this case means we MUST ‘return’ from the Function IF IT FAILS.
 This is NOT Optional: Swift WON’T compile our code WITHOUT the 'return'
 'return' only works inside a 'func'
 */




//Example Exlained
func printSquareExplained(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        
        // 1: We MUST exit the function here
        return
        /* If you use guard to check a Function’s inputs are Valid,
         Swift will ALWAYS require you to use return IF the check FAILS. */
    }
    
    // 2: `number` is still available in the 'func' Body OUTSIDE of `guard`
    print("\(number) x \(number) is \(number * number)")
    /* IF the check PASSES and the Optional you’re Unwrapping HAS a value inside,
     you can use it AFTER the guard code finishes */
}






//OPTIONAL MATERIALS
//WHEN TO USE 'guar let' RATHER THAN 'if let'

//Ex: Function that returns the meaning of life as an Optional Int
func getMeaningOfLife() -> Int? {
    42 //Int value that would be returned
}
getMeaningOfLife() //Returns: 42





//'printMeaningOfLife' func that uses 'getMeaningOfLife' func inside its body

//Using 'if let' to just Unwrap Optionals
func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

printMeaningOfLife() //DO NOT PRINT ANYTHING



//Use 'guard let' to check whether Conditions are CORRECT before continuing
func printMeaningOfLifeGuarLet() {
    guard let name = getMeaningOfLife() else {
        return //Swift will ALWAYS require you to use return IF the check FAILS
    }
    
    /* The check PASSES and the Optional we're Unwrapping HAS a value inside,
     We use 'name' here AFTER the guard code finishes */
    print(name)
}

printMeaningOfLifeGuarLet() //Prints: 42
