import UIKit


//FUNCTIONS - RETURNING MULTIPLE VALUES

//Function that returns Single Value
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}


//Solution 1: Using Array in Function to return 2 or more Values
func getUserArray() -> [String] {
    ["Taylor", "Swift"]
}

let userA = getUserArray()
print("Name: \(userA[0]) \(userA[1])") //Accessing Array values
//Result: "Name: Taylor Swift"



//Solution 2: Using Dictionary in Function to return 2 or more Values
func getUserDict() -> [String: String] {
    [
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let userD = getUserDict()
print("Name: \(userD["firstName",default: "Anonymous"]) \(userD["lastName",default: "Anonymous"])") //Accessing Dictionary values
//Result: "Name: Taylor Swift"



//Solution 3: Using Tuples in Function to return 2 or more Values
//TUPLES have a FIXED SIZE and can have a variety of DATA TYPES
func getUserTuple() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift") //TUPLE
    // (key-name: value, key-name: value)
}

let userT = getUserTuple()
print("Name: \(userT.firstName) \(userT.lastName)") //Accessing Tuple values
//Result: "Name: Taylor Swift"



//Tuples - Swift knew the given Tuples names
func getUser() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift") //Don't need to retype Tuples NAMES
}


//Tuples - No given Tuple Names
func getUserC() -> (String, String) { //No Tuples Name
    ("Taylor", "Swift")
}

let user = getUserC()
print("Name: \(user.0) \(user.1)") //Access Tuple vales with Indices
//Result: "Name: Taylor Swift"



//Tuples - Breakdown into individual Values (DE-STRUCTURING)
func getUserG() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let userGG = getUserG()
let firstNameGG = userGG.firstName //Breakd Down "firstName" Tuple value
let lastNameGG = userGG.lastName //Breakd Down "lastName" Tuple value

print("Name: \(firstNameGG) \(lastNameGG)")
//Result: "Name: Taylor Swift"


//Simpler Code
let (firstNameGGG, lastNameGGG) = getUser()
print("Name: \(firstNameGGG) \(lastNameGGG)")
//Result: "Name: Taylor Swift"


//Using  _ if we DON'T need the all the values from the Tuples
let (firstName,_) = getUser() //Omit Tuple lastName with _
print("Name: \(firstName)")
//Result: "Name: Taylor"
