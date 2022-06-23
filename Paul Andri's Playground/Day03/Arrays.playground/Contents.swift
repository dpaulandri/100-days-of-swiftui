import UIKit


//Examples of Array being used to store multiple Data (same Data Type)
var beatles = ["John", "Paul", "George", "Ringo"] //Array of Strings
let numbers = [4, 8, 15, 16, 23, 42] //Array of Intergers
var temperatures = [25.3, 28.2, 26.4] //Array of Doubles

//Array Index starts counting from 0 as its 1st index position
print(beatles[0]) //0 = The 1st position data in "beatles" = "John"
print(numbers[1]) //1 = The 2nd position data in "numbers" = 8
print(temperatures[2]) //2 = The 3rd position data in "temperatures" = 26.4

//Make sure the Array indeed have a value at an Index position that we recall,
//Else it would return an error message, and our App would crash and exit to Home screen
//Below is an example that would trigger an error warning from Xcode
//print(numbers[10]) <-Example code


//We could add more Data into an Variable type Array after its initial created value with ".append"
//The new Data added will be saved at the end/last position of the Array
//This could be done for as many times as needed (Variables)
beatles.append("Adrian")
beatles.append("Allen")
beatles.append("Adrian")
beatles.append("Novall")
beatles.append("Vivian")
print(beatles)
//Array values = ["John", "Paul", "George", "Ringo", "Adrian", "Allen", "Adrian", "Novall", "Vivian"]


//Swift will make sure that an Array only hold a single kind of Data Type value
//Example: We can't .append a String-type data into a Double Array.
//temperatures.append("Chris") <-This line of code will triggers an error warning!


//Because Swift knows & remembers each Array's Data Type, it won't allow to mix 2 or more different Data Type together
//Example codes below:
let firstBeatle = beatles[0] //"beatles" is a String Array, "firstBeatle" would be a String Constant
let firstNumber = numbers[0] //"numbers" is an Int Array, "firstNumber" would be a Int Constant
//let notAllowed = firstBeatle + firstNumber <- This line of code triggers an error warning!
//NOTE: Swift/Xcode "Type Safety" prevents accidental mixing of 2 or more different Data Types


//We can create an empty specialised Array and .append the values later on
var scores = Array<Int>() //Creating an Int-type Array with no initial value
scores.append(100)
scores.append(80)
scores.append(85)
print(scores) //Array values = [100, 80, 85]
print(scores[1]) //1 = The 2nd position data in "scores" = 80

//String Array Examples
var albums = Array<String>() //Creating an String-type Array with no initial value
albums.append("Back to Black")
albums.append("Appetite for Destruction")
albums.append("A Night at the Opera")
print(albums) //Array value = ["Back to Black", "Appetite for Destruction", "A Night at the Opera"]

//Creating empty specialised Array with LESS CODE
var easyArray = [String]() //Creating an empty String-type Array with LESS CODE
easyArray.append("Easier")
easyArray.append("Less")
easyArray.append("Code")
print(easyArray) //Array value = ["Easier", "Less", "Code"]


//Creating specialised Array with initial Value meant the Data type is fixed upon creation
var albumsFix = ["Folklore"] //"Folklore" is auto-detected as a String Data type
albumsFix.append("Fearless")
albumsFix.append("Red")
print(albumsFix) //Array value = ["Folklore", "Fearless", "Red"]


//Useful Array Functionality: .count
print(albumsFix.count) //Count how many items are stored within the "albumFix" Array
//.count retusn "3", meaning 3 items are stored within the "albumFix" Array


//Useful Array Functionality: .remove AND .removeAll
var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count) //Initial characters.count returns 4 items

characters.remove(at: 2) //2 = .remove the 3rd item in "characters" Array = "Ray"
print(characters.count) //characters.count returns 3 items
print(characters) //Array value = ["Lana", "Pam", "Sterling"]

characters.removeAll() //.removeAll items in "characters" Array
print(characters.count) //characters.count returns 0
print(characters) //Array value = []


//Useful Array Functionality: .contains
let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
//The line of code below checks if the Array contains an entry "Frozen" (Case-sensitive)
print(bondMovies.contains("Frozen")) //returns Boolean = "false"


//Useful Array Functionality: .sorted()
//Strings: Alpahbetically (A-Z)
let cities = ["London", "Tokyo", "Rome", "Budapest"] //String Array
print(cities.sorted()) //.sorted Sorts the Array's entries Alphabetically
//returned value = ["Budapest", "London", "Rome", "Tokyo"] (Sorted Alphabetically)

let swiftLetters = ["s", "w", "i", "f", "t"]
print(swiftLetters.sorted()) //.sorted Sorts the Array's entries Alphabetically
//returned value = ["f", "i", "s", "t", "w"]

//Ints: Smallest to Biggest
let numberSort = [7, 3, 9, 6, 1]
print(numberSort.sorted())

//Doubles: Smallest to Biggest
let deciSort = [2.5, 1.5, 1.2, 7.9, 1.0]
print(deciSort.sorted())

//Bool: can't be sorted, returns error


//Useful Array Functionality: .reversed()
let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)
//This creates a new "ReversedCollection<Array<String>>" as below:
//ReversedCollection<Array<String>>(_base: ["Bush", "Obama", "Trump", "Biden"])
//.reversed() DOES NOT create a literal new Array of reversed item order of the original Array
//The new "ReversedCollection" is stored as is, but Swift will remember it in reverse order when trigger/recall later on
