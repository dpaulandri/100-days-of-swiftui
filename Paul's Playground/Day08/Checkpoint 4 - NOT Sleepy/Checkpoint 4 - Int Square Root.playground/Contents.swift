import UIKit
import CoreFoundation


//INT SQUARE ROOT
/*
 Write a *function* that accepts an Int from 1 through 10,000, and returns the Int Square Root of that number. That sounds easy, but there are some catches:

 1. You can’t use Swift’s built-in `sqrt()` function* or similar – you need to find the square root yourself.
 2. If the number is  < 1 or > 10,000, you should throw an "out of bounds” error.
 3. You should only consider Int Square Roots – don’t worry about the Square Root of 3 being 1.732, for example.
 4. If you can’t find the Square Root, throw* a “no root” error.

 As a reminder, if you have number X, the square root of X will be another number that, when multiplied by itself, gives X. So, the Square Root of 9 is 3, *because 3x3 is 9, and the Square Root of 25 is*5, because 5x5 is 25.
*/



enum numberBound: Error {
    case out, noRoot
}

func findSquareRoot(_ numberValues: Int) throws -> Int {
    
    if numberValues < 1 || numberValues > 10_000 {
        throw numberBound.out
    }
    
    var squareRoot = 0
    
    for i in 1...100 {
        if (i * i) != numberValues {
            continue
        }
        squareRoot = i
    }
    
    if  squareRoot == 0 {
        throw numberBound.noRoot
    }
    
    return squareRoot
}

do {
    let result = try findSquareRoot(9)
    print(result)
} catch numberBound.out {
    print("Out of Bound")
} catch numberBound.noRoot{
    print("No Root")
}
