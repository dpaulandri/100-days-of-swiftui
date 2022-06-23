import UIKit


//"for" LOOP

//EXAMPLE CODE: LOOPING OVER AN ARRAY
//The code below loops over all the items in "platforms", putting them one by one into "os"
//a Loop Cycle is called "LOOP ITERATION"
//LOOP VARIABLE "os" is created for us as part of the for loop code
//The name of LOOP VARIABLE IS NOT SPECIAL, we could name it as what we want
//The "os" value changes with every LOOP ITEGRATION
//"os" value is made available ONLY inside { }, we CAN NOT use its value OUTSIDE the loop

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

//Inside the braces is the code we want to run for EACH ITEM in the Array "platforms"
for os in platforms { //"os" is called the "LOOP VARIABLE"
    print("Swift works great on \(os).") //<- this loc is called "LOOP BODY"
}
/*Code Logic 1x CODE ITERATION:
1. for loop took the 1st Value of the "platforms" Array = "iOS" and set it as the value of "os"
2. for loop runs the code inside the { } resulting in print of "Swift works great on iOS."
3. for loop took the next Value of the "platforms" Array and set it as the new value of "os"
4. for loop runs the code inside the { } resulting in print of "Swift works great on (\os)."
5. This processes are repeated until all the values in "platforms" Array have been run through the code in {}
*/

/*Final Print Results:
 Swift works great on iOS.
 Swift works great on macOS.
 Swift works great on tvOS.
 Swift works great on watchOS.
*/




//EXAMPLE CODE: LOOPING OVER A FIXED RANGE OF NUMBERS
for i in 1...12 { //"1...12" = Int range from 1 to 12
    print("5 x \(i) is \(5 * i)")
}
/*Final Print Results:
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


/*Common Coding Convention for Loop Variable name:
"i" : number you’re counting with
"j" : counting a second number
"k" : counting a third number
counting a fourth maybe you should pick better variable names */




//NESTED LOOPS: Putting Loops inside Loops
for i in 1...12 {  //"1...12" = Int range from 1 to 12
    print("The \(i) times table:")

for j in 1...12 {  //"1...12" = Int range from 1 to 12
        print("  \(j) x \(i) is \(j * i)")
    }

    print()
}

//Final Print Results: Complete 12 Times table
 
/*Code Logic 1x CODE ITERATION:
 1. Parent "i" for loop took the 1st Int Value from the Int range and set it as the value of "i"
 2. "i" for loop runs the code inside the { } - print our "The \(i) times table:" and run MESTED Child for loop
 3. NESTED Child "j" for loop took the 1st Int Value from the Int range and set it as the value of "j"
 4. for loop runs the code inside the { } - print("  \(j) x \(i) is \(j * i)")

 The NESTED Child for loop will run 12 times before completing: this completes 1x CODE ITERATION of the Parent for loop
 The PARENT for loop will run 12x CODE ITERATION
*/



//RANGE TYPES Example Codes
//RANGE TYPE: x...y "Count from x to y"
for i in 1...5 { //count from 1 to 5
    print("Counting from 1 through 5: \(i)")
}
/*Final Print Results:
 Counting from 1 through 5: 1
 Counting from 1 through 5: 2
 Counting from 1 through 5: 3
 Counting from 1 through 5: 4
 Counting from 1 through 5: 5
*/


//RANGE TYPE: x..<y "Count x up to y"
for i in 1..<5 { //count 1 up to 5 (not including 5)
    print("Counting 1 up to 5: \(i)")
}
/*Final Print Results:
 Counting 1 up to 5: 1
 Counting 1 up to 5: 2
 Counting 1 up to 5: 3
 Counting 1 up to 5: 4
*/




// for Loop WITHOUT LOOP VARIABLE using the UNDERSCORE _
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric) //Result: "Haters gonna hate hate hate hate hate"




var chutSong = "I wanna"

for _ in 1...7 {
    chutSong += " poop"
}

print(chutSong) //Result: "I wanna poop poop poop poop poop poop poop"




//OPTIONAL MATERIALS - UNDERSCORE _
//Code with LOOP VARIABLE "name"
let names = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

for name in names {
    print("\(name) is a secret agent")
}
/*Final Print Resulta:
 Sterling is a secret agent
 Cyril is a secret agent
 Lana is a secret agent
 Ray is a secret agent
 Pam is a secret agent
*/

//Rewritten Code without LOOP VARIABLE "name", using UNDERSCORE _ instead
let agentNames = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

for _ in agentNames {
    print("[CENSORED] is a secret agent!")
}
/*Final Print Resulta:
 [CENSORED] is a secret agent!
 [CENSORED] is a secret agent!
 [CENSORED] is a secret agent!
 [CENSORED] is a secret agent!
 [CENSORED] is a secret agent!
*/




//OPTIONAL MATERIALS - RANGE OPERATORS (HALF-OPEN, CLOSED, ONE-SIDED)
let namesArray = ["Piper", "Alex", "Suzanne", "Gloria"]

//Print Array Value by one specific Index position
print(namesArray[0])
//Result: "Piper"

//Print Array Value by specific range of Index position using HALF-OPEN RANGE OPERATOR
print(namesArray[1..<3])
//Result: ["Alex", "Suzanne"]


//Print Array Value by specific range of Index position using CLOSED RANGE OPERATOR
print(namesArray[1...3])
//Result: ["Alex", "Suzanne", "Gloria"]

//Print Array Value by specific range of Index position using ONE-SIDED RANGE OPERATOR
print(namesArray[1...]) //From Index 1 to the end of the Array
//Result: ["Alex", "Suzanne", "Gloria"]
