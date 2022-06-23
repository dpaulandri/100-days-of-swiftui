import UIKit


//STATIC PROPERTIES & METHODS

//Create Static Properties & Methods
struct School {
    //'static' Property, belongs to the Struct itself
    //Can be accessed using the Struct itself w/o an Instance
    static var studentCount = 0
    
    
    //'static' Method, belongs to the Struct itself
    //Can be accessed using the Struct itself w/o an Instance
    //'static' Method DO NOT NEED 'mutating' keyword to allow modification of a Property because we don't need to create an Instance to access it
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

//Use the Struct's 'static' Method directly without creating an Instance
School.add(student: "Taylor Swift") //Result: "Taylor Swift joined the school."

//'print()' by accessing the Struct's 'static' Property directly without creating an Instance
print(School.studentCount) //Result: 1




//TWO MAIN WAYS TO USE STATIC DATA
//1. To STORE lots of SHARED VALUES I use in many places
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

//Accessing the Static Properties value
AppData.version //Result: "1.3 beta 2"
AppData.homeURL //Result: "https://www.hackingwithswift.com"




//2. Create an example/sample Data
struct Employee {
    let username: String
    let password: String
    
    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

//Accessing the sample Data from Static Property
Employee.example
/* Results:
 username "cfederighi"
 password "hairforceone"
*/



struct Unwrap {
    static let appURL = "https://itunes.apple.com/app/id1440611372"
}

Unwrap.appURL //Result: "https://itunes.apple.com/app/id1440611372"
