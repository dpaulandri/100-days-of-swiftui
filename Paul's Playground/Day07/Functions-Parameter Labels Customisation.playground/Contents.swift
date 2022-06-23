import UIKit


//PARAMETER LABELS

//A Function to roll a dice a certain number of times, using Parameters to control the number of sides on the dice and the number of rolls
func rollDice(sides: Int, count: Int) -> [Int] { //Parameters
    // Start with an empty Array
        var rolls = [Int]()

    // Roll as many dice as needed
        for _ in 1...count {
        // Add each result to our Array
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }

    // Send back all the rolls
    return rolls
}

let rolls = rollDice(sides: 6, count: 4) //Argumwnts
print(rolls) //Result varies Int value 1...6


//Valid Parameters Naming in Swift
func hireEmployee(name: String) { }
func hireEmployee(title: String) { }
func hireEmployee(location: String) { }



//Checking with .hasPrefix()
let lyric = "I see a red door and I want it painted black"
print(lyric.hasPrefix("I see")) //Result: true






// _ TO REMOVE EXTERNAL PARAMETER LABEL NAME
//Code with repetitive EXT Parameter Label names
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result = isUppercase(string: string) //"string" ext Parameter Label
//Result: true


//Code with _ (OMIT EXT Param Label Name)
func isUppercaseUS(_ string: String) -> Bool { //use of _ before Param Name
    string == string.uppercased()
}

let stringUS = "HELLO, WORLD"
let resultUS = isUppercaseUS(stringUS) //NO use of "string" EXT Param Name
//Result: true




//NATURAL READING EXT PARAMETER LABEL NAME
//Code w/ Ext Parameter Label Name that DON'T READ NATURALLY at the Function's Call Site
func printTimesTables(number: Int) { //Parameter Label name "number"
        for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

//Function Call Site
printTimesTables(number: 5) //Label don't read naturally well
/*Print Result
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



//Codw with EXT LABEL NAME that READS NATURALLY at Function Call Site
//TWO PARAMETER NAME: INTERNAL & EXTERNAL NAMES
func printTimesTables(for number: Int) { //"for" = INT, "number" = EXT
        for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }   //Using INT NAME inside the Function Code Block
}

//Function Call Site
printTimesTables(for: 5) //Used EXT PARAM LABEL NAME "for"
/*Print Results:
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
