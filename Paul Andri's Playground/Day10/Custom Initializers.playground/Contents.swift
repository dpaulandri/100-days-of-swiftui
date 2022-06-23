import UIKit


//CREATE CUSTOM INITIALIZERS

//INSTANCE W/ MEMBERWISE INITIALIZER
struct Player {
    let name: String
    let number: Int
}

//New 'player' Instance with MEMBERWISE INITIALIZER
//An Initializer that accepts each Property in the order it was defined.
let player = Player(name: "Megan R", number: 15)
print(player.name) //Result: "Megan R"
print(player.number) //Result: 15



//INSTANCE W/ CUSTOM INITIALIZER
struct PlayerInit {
    let name: String
    let number: Int

    //loc for CUSTOM INITIALIZER
    init(name: String, number: Int) { //Initializers must provide both 'name' & 'number' values
        self.name = name
        //Assign 'name' Parameter name to my 'name' Property (self.name)
        self.number = number
        //Assign 'number' Parameter name to my 'number' Property (self.number)
    }
}

let playerCstInit = PlayerInit(name: "Nana R", number: 13)
print(playerCstInit.name) //Result: "Nana R"
print(playerCstInit.number) //Result: 13



struct BearFam {
    let bearName: String
    let bearAge: Int

    //loc for CUSTOM INITIALIZER
    init(name: String, age: Int) { //Initializers must provide both 'name' & 'age' values
        self.bearName = name
        //Assign 'name' Parameter name to my 'bearName' Property (self.bearName)
        self.bearAge = age
        //Assign 'age' Parameter name to my 'bearAge' Property (self.bearAge)
    }
}

let bearFamData = BearFam(name: "Paul Andri", age: 33)
print(bearFamData.bearName) //Result: "Paul Andri"
print(bearFamData.bearAge) //Result: 33




//CUSTOM INITIALIZER that only require certain Property value to be provided
struct PlayerCustInit2 {
    let name: String
    let number: Int

    init(name: String) { //Initializers must provide both 'name' value
        self.name = name //Assign 'name' Parameter name to my 'name' Property (self.name)
        number = Int.random(in: 1...99)
        //Assign random Int range 1...99 result to 'number' Property
    }
}

let playerCst = PlayerCustInit2(name: "Megan R")
print(playerCst.name) //Result: "Megan R"
print(playerCst.number) //Result: varies random Int on each run



struct BearAge {
    let bearName: String
    let bearAge: Int

    //loc for CUSTOM INITIALIZER
    init(name: String) { //Initializers must provide both 'name' value
        self.bearName = name
        //Assign 'name' Parameter name to my 'bearName' Property (self.bearName)
        bearAge = Int.random(in: 1...99)
        //Assign random Int range 1...99 result to 'bearAge' Property
    }
}

let howOldIsBear = BearAge(name: "Paul Andri")
print(howOldIsBear.bearName) //Result: "Paul Andri"
print(howOldIsBear.bearAge) //Result: varies random Int on each run






//OPTIONAL MATERIALS

//MEMBERWISE INITIALIZERS
//Ex: STRUCTS w/ DEFAULT VALUES
struct Employee {
    var name: String
    var yearsActive = 0 //This Property have a Default Value
}

//'yearActive' Property was not given a value in this Instance
//Swift will use the default value 0 for 'yearsActive' Property
let roslin = Employee(name: "Laura Roslin")
print(roslin.name) //Result: "Laura Roslin"
print(roslin.yearsActive) //Result: 0

//Both Struct Propertis were given a value in this Instance
let adama = Employee(name: "William Adama", yearsActive: 45)
print(adama.name) //Results: "William Adama"
print(adama.yearsActive) //Results: 45




//MAKING MEMBERWISE INITIALIZER ACTIVE WHILE HAVING CUSTOM INITIALIZER
struct EmployeeMemberCustom {
    var name: String
    var yearsActive = 0 //'yearsActive' have Default Value of 0
}

extension EmployeeMemberCustom { //Moved Custom Initializer as an 'extension' of out Struct
    init() { //Init DOESN'T require any value to be provided for the Struct's Properties
        self.name = "Anonymous"
        //Assign "Anonymous" as a Default Value for 'name' Property if no value is provided in Initializer
        print("Creating an anonymous employee…")
        // Print this when no value is provided in Initializer
    }
}

// creating a named employee now works
let roslinMemCst = EmployeeMemberCustom(name: "Laura Roslin")
print(roslinMemCst.name) //Results: "Laura Roslin"
print(roslinMemCst.yearsActive) //Result: 0 (Default Value)

// as does creating an anonymous employee
let anon = EmployeeMemberCustom() //No value is provided in the Initializer
print(anon.name)
/*Print Resukts:
 Creating an anonymous employee…
 Anonymous
*/
print(anon.yearsActive) //Result: 0 (Default Value)




//USING 'self' IN A METHOD
//Struct using Ext/Int Property Names - CLUMSY
struct StudentExtInt {
    var name: String
    var bestFriend: String

    init(name studentName: String, bestFriend studentBestFriend: String) {
        print("Enrolling \(studentName) in class…")
        name = studentName
        bestFriend = studentBestFriend
    }
}

//Struct using 'self' - SIMPLE & CLEAR
struct StudentSelf {
    var name: String
    var bestFriend: String

    init(name: String, bestFriend: String) {
        print("Enrolling \(name) in class…")
        self.name = name
        self.bestFriend = bestFriend
    }
}




