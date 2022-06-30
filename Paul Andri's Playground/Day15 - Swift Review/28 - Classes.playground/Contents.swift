// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// CLASSES 'class'
// Create custom Data Types, different from Structs in five ways:

// 1. CLASS INHERITANCE - create Classes by inheriting Functionality from other Classes
class EmployeeClass {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

//Class 'Developer' inherit 'EmployeeClass' Poperty, Method & custom Initializer
class Developer: EmployeeClass {
    func work() {
        print("I'm coding for \(hours) hours.")
    }
    
    // Use 'override' to allow change/modification of an Inherited Method
    override func printSummary() {
        print("I spend \(hours) hours a day searching Stack Overflow.")
    }
}

let novall = Developer(hours: 8)    // Create a 'Developer' Class Instance
// Call Class Instance's Methods
novall.work()
// Prints: "I'm coding for 8 hours."
novall.printSummary()
// Prints: "I spend 8 hours a day searching Stack Overflow."


// 2. INITIALIZERS:
/*
 1. Swift WON'T generate a Memberwise Initializer for Classes.
 2. If a child Class has Custom Initializers, it MUST always call the parent’s Initializer AFTER it has finished setting up its own Properties.
 3. If a subClass DOESN’T have any Initializers, it automatically INHERITS the Initializers of its parent Class.
 */
class Vehicle { // Parent Class
    let isElectric: Bool    // Parent Class' Property

    init(isElectric: Bool) {    // Parent Class' Custom Initializers
        self.isElectric = isElectric
    }
}

class Car: Vehicle {    // Child Class
    let isConvertible: Bool    // Child Class' Property

    // Child Class' Custom Initializers
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        // Use 'super.init' to call parent Class' Initializer
        super.init(isElectric: isElectric)
    }
}


// 3. ALL COPIES OF A CLASS INSTANCE SHARES THE SAME DATA - Struct copies DON'T
// Changes made to one Class Instance copy will automatically change other copies
class Singer {
    var name = "Adele"
}

var singer1 = Singer()  // Create a 'Singer' Class Instance
var singer2 = singer1   // Create a Class Instance copy from 'singer1'
singer2.name = "Justin" // Changes' 'singer2' Instance copy's Property value
print(singer1.name) // Prints: "Justin"
print(singer2.name) // Prints: "Justin"


// 4. CLASSES CAN HAVE A 'DEINITIALIZER"
// Gets called WHEN the last reference to an object is DESTROYED
// EX: a Class that prints a message WHEN it’s CREATED and DESTROYED
class User {
    let id: Int
    
    init(id: Int) { // Custom Initializer
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {    // DeInitializer will run AFTER each Loop Iteration
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {    // 'for' Loop that will run for 3 Iterations
    let user = User(id: i)  //  Create a Class Instance w/ a Initializer value
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


// 5. CHANGING A 'var' PROPERTIES VALUE INSIDE A 'let' INSTANCE IS ALLOWED
// As a result, Classes DON'T need to add 'mutating' with Methods that can change Data
class UserClass {
    var name = "Paul"
}

let userClass = UserClass() // Create a 'let' Class Instance
userClass.name = "Taylor"   // Change the Poperty value of the 'let' Class Instance
print(userClass.name)   // Prints: "Taylor"
