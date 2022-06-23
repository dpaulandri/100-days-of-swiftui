import UIKit


//SKIPPING one or more Items in a Loop: continue & break

//CONTINUE - IMMEDIATELY STOP executing the current LOOP ITERATION & jump to the next Item in the Loop
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
        if filename.hasSuffix(".jpg") == false {
            continue
        }

    print("Found picture: \(filename)")
}
/*Results:
 Found picture: me.jpg
 Found picture: sophie.jpg
*/


//BREAK - EXITS a Loop IMMEDIATELY and SKIP ALL remaining LOOP ITERATIONS
let number1 = 4
let number2 = 14
var multiples = [Int]() //Create and empty var Int Array to store Int Data

for i in 1...100_000 { //Count from 1 through 100,000, assigning each loop variable to "i"
        if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        //If "i" value .isMultiple of BOTH the "number1" AND "number2", .append (add) it to the "multiples" Array

                if multiples.count == 10 {
                        break
                } //Once we hit 10 Items in "multiples" Array, call "break" to EXIT the Loop
    }
}

print(multiples) //Print out the resulting array
//Print Array Result: [28, 56, 84, 112, 140, 168, 196, 224, 252, 280]



//OPTIONAL MATERIALS - break
//We had an Array of "scores" and we want to figure out how many of them the player achieved WITHOUT getting a 0
let scores = [1, 8, 4, 3, 0, 5, 2] //Int Array of "scores"
var count = 0 //Int Variable with initial Value = 0

for score in scores {
        if score == 0 {
                break
        } //Once we accessed 0 in "scores" Array, call "break" to EXIT the Loop

    count += 1 //Add 1 to the "count" var at the end of each LOOP ITERATION
}

print("You had \(count) scores before you got 0.") //Print out the final "count" value with String Interpolation
//Print Result: "You had 4 scores before you got 0."
