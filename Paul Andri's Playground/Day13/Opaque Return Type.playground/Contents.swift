import UIKit


// 'OPAQUE' RETURN TYPE
//Let us hide information in our code, but NOT from the Swift compiler


//Two Functions that returns Opaque Return Type
func getRandomNumber() -> some Equatable { //returns an 'Opaque' Equatable Protocol (Int)
    // Returning a Protocol from a Function is USEFUL because it lets us HIDE information
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable { //returns an 'Opaque' Equatable Protocol (Bool)
    Bool.random()
    //'Bool.random()' have NO customization options
    //We do not need to specify any Parameters
}


//SWIFT's EQUATABLE PROTOCOL = “can be compared for equality.”
//SWIFT's EQUATABLE PROTOCOL is why we're allowed the usage of "=="
//Int & Bool type conforms to Swift's EQUATABLE Protocol
//Calling 'getRandomNumber() twice, then comparing thenm should have a 50:50 chance of 'true' or 'false'
print(getRandomNumber() == getRandomNumber()) //Prints: 'false'
