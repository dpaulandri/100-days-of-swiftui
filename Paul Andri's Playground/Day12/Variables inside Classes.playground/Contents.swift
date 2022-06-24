import UIKit


//VARIABLES INSIDE CLASSES

//A 'let' CLASS INSTANCE w/ 'var' PROPERTY
//A  Class with one Variable Property
class User1 {
    var name = "Paul"
}

//Create a Constant Class Instance
let user = User1()
//Changing the 'var' Property is allowed
user.name = "Taylor"
print(user.name) //Prints: "Taylor"






//A 'var' CLASS INSTANCE w/ 'var' PROPERTY
//A  Class with one Variable Property
class User2 {
    var name = "Paul"
}

//Create a Varaible Class Instance out of 'UserVar' Class
var userVar1 = User2()

//Changing the 'var' Property is allowed
userVar1.name = "Taylor"

//Overwrite the 'userVar' Instance with the OG Property values from 'UserVar'
userVar1 = User2() //'userVar.name' value will reverb back to its OG value

print(userVar1.name) //Prints: "Paul" <- the Default Value of 'name'






//A 'var' CLASS INSTANCE w/ 'let' PROPERTY
//A  Class with one Constant Property
class User3 {
    let name = "Hoan"
}

//Create a Varaible Class Instance
var userVar = User3()
print(userVar.name) //Prints: "Hoan"




//A 'let' CLASS INSTANCE w/ 'let' PROPERTY
//A  Class with one Constant Property
class User4 {
    let name = "Baba"
}

//Create a Constant Class Instance
let userLet = User4()
print(userLet.name) //Prints: "Baba"
