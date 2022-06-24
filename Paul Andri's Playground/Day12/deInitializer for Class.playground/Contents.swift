import UIKit


//DEINITIALIZER FOR CLASS

//a Class that prints a message when it's CREATED & DESTROYED
//using an Initializer & deInitializer
class User {
    let id: Int
    
    init(id: Int) { // Custome Initializer
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit { // deInitializer
        print("User \(id): I'm dead!")
    }
}

//Ex: CREATE and DESTROY Instances of that quickly using a Loop
//if we create a User Instance inside the Loop, it will be destroyed when the Loop Iteration finishes
for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
}
/* Print Results:
 User 1: I'm alive!
 User 1: I'm in control!
 User 1: I'm dead!
 User 2: I'm alive!
 User 2: I'm in control!
 User 2: I'm dead!
 User 3: I'm alive!
 User 3: I'm in control!
 User 3: I'm dead!
 
 */





//Example: 'deinit' will only be called after EVERY DATA IS DESTROYED
//an empty 'var' Array that be appended with each Loop Iterations
var users = [User]()

for i in 1...3 { //'for' Loop with 3 Loop Iterations (1, 2, 3)
    //CREATES a new Class Instance out of 'User' Class in every Loop Iteration
    let user = User(id: i)
    //Prints w/ each new Class Instance creation in each Loop Iteration
    print("User \(user.id): I'm in control!")
    
    //Append/Copy 'user' Value into 'users' Array in each Loop Iteration
    users.append(user) //Causes DATA NOT TO BE DESTROYED
    //CAUSES 'deinit' TO NOT RUN IMMEDIATE AFTER EACH LOOP ITERATIONS
}


//If we were ADDING our User instances AS they were created, they would only be destroyed WHEN the Array is CLEARED

//This prints after ALL the Loop Iterations finishes
print("Loop is finished!")

//DESTROY/Remove All Copies/Items in 'users' Variable Array
users.removeAll() // This TRIGGER 'deinit' to be CALLED IMMEDIATELY AFTER

//This prints AFTER 'deinit' is done
print("Array is clear!")

/*Print Results:
 User 1: I'm alive!
 User 1: I'm in control!
 User 2: I'm alive!
 User 2: I'm in control!
 User 3: I'm alive!
 User 3: I'm in control!
 Loop is finished!
 User 1: I'm dead!
 User 2: I'm dead!
 User 3: I'm dead!
 Array is clear!
*/
