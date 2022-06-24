import UIKit


//COPY CLASS INSTANCES
//A simple Class w/ one Property
class User {
    var username = "Anonymous"
    //This Property will get shared across all copies of the Class.
}

//Create an Instance of the 'User' Class
var user1 = User()


//COPY A CLASS INSTANCE
//Create a copy the Class Instance out of 'user1' Instance
var user2 = user1

//Change the 'username' Property Value of the 'user2' Instance Copy
user2.username = "Taylor"
//This will also CHANGE the 'username' Property Value of 'user1' Instance
//because DATA IS SHARED AMONG THE OG INSTANCE AND ITS COPIES


//Print out the Shared Properties from each Instance Copy
print(user1.username) //Result: "Taylor"
print(user2.username) //Result: "Taylor"
//INSTANCE COPIES SHARED THE SAME DATA W/ ITS OG CLASS INSTANCE





//DEEP COPY - a UNIQUE copy of a Class Instance
//a DEEP COPY Instance WON'T change the Property values of its OG Class Instance it copied from
//BECAUSE A DEEP COPY INSTANCE DO NOT SHARE DATA WITH THE OG INSTANCE
class UserDeepCopy {
    var username = "Anonymous"
    
    //Method to create a Deep Copy / Unique Copy of Class Instance
    func copy() -> UserDeepCopy {
        let user = UserDeepCopy()
        user.username = username
        return user
    }
}

//Create a Class Instance out of 'UserDeepCopy' Class
var user3 = UserDeepCopy()

//Create a DEEP COPY Class Instance out of 'user3' Instance using 'copy()' Method
var user4 = user3.copy()

//Change the 'username' Property Value of the DEEP COPY INSTANCE
user4.username = "Paul Andri"
//This change WON'T affect the OG 'username' Property Value of 'user3' Instance


print(user3.username) //Result: "Anonymous"
print(user4.username) //Result: "Paul Andri






//STRUCT VS CLASS DEEP COPY
//USING STRUCT COULD ACCOMPLISH WHAT DEEP COPY DOES IN CLASS
//BECAUSE A STRUCT INSTANCE DO NOT SHARE DATA
struct UserStruct { //A Struct instead of a Class
    var username = "Anonymous"
}

//Create a Struct Instance out of 'UserStruct'
var user5 = UserStruct()

//Copy a Struct Instance
var user6 = user5

//Change the 'username' Property Value of the Instance Copy
user6.username = "Paul Andri"
//ONLY 'username' PROPERTY IN 'user6' INSTANCE IS CHANGED!
//BECAUSE A STRUCT INSTANCE DO NOT SHARE DATA

print(user5.username) //Result: "Anonymous"
print(user6.username) //Result: "Paul Andri
