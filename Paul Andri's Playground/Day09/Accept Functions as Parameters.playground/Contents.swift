import UIKit


//ACCEPT FUNCTIONS AS PARAMETERS

//Previous Example code of func 'greetUser() & the copied var 'greetCopy'
func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy: () -> Void = greetUser //Added in Tyoe Annotation
//Type Annotation: Accept NO Parameters, returns NOTHING
greetCopy() //Call 'greetCopy' w/o sending any Argument value
/*Print Result:
 Hi there!
 Hi there!
*/




//SPECIFYING FUNCTIONS AS PARAMETER
//Ex: A function that generates an Array of Integers by repeating a function a certain number of times
/*1st Loc BREAKDOWN:
 1. We’re creating a new Function.
 2. The Dunction is called `makeArray()`.
 3. The first Parameter is an Integer called `size`.
 4. The second Parameter is a Function called `generator', which itself accepts NO parameters and returns an Integer.
 5. The whole thing – `makeArray()` – returns an Array of Integers.
*/
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}
/*ENTIRE FUNCTIONCODE BREAKDOWN:
 1. The function is called `makeArray()`. It takes two Parameters, one of which is the number of Integers we want, and also returns an Array of Integers.
 2. The second Parameter is a Function. This accepts NO parameters itself, but will return one Integer every time it’s called.
 3. Inside `makeArray()` we create a new empty Array of Integers, then loop as many times as requested.
 4. Each time the loop goes around we call the `generator` function that was passed in as a Parameter. This will return one new Integer, so we put that into the `numbers` array.
 5. Finally the finished Array is returned.
*/


//Create a new 'rolls' Closure acceoting 'makeArray' func as a Parameter
let rolls = makeArray(size: 50) { //Make an 50-sized Int Array (50)
    Int.random(in: 1...20) //A Function to generate Random Int number (range 1...20)
}

print(rolls)
//Result varies each run


//Rewritten as a Function that accept other Functions as Parameters
func generateNumber() -> Int { //'generateNumber' func DO NOT ACCEPT Params, returns an Int value
    Int.random(in: 1...20) //A Function to generate Random Int number (range 1...20)
}

//Make a 50-sized Int Array and calls 'generateNumber' func 50times to fill in the Array
let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)
//Result varies each run





//MAKE A FUNCTION ACCEPT MULTIPLE FUNCTION PARAMETERS
//Ex: A 'func'' that accepts three Function Parameters, each of which accept NO parameters and return NOTHING
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}


//CALL 'doImportantWork' WITH TRAILING CLOSURE
doImportantWork {
    
    print("This is the first work") //Corresponds to 'first()' in 'doImportantWork' func
    
} second: { //'second:' - write the External Param Naem 'second' and a colon':' and start a {
   
    print("This is the second work")

} third: { //'thied:' - write the External Param Naem 'third' and a colon':' and start a {
    
    print("This is the third work")

}
/* Print Results:
 About to start first work
 This is the first work
 About to start second work
 This is the second work
 About to start third work
 This is the third work
 Done!

*/
