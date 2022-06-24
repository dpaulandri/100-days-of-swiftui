import UIKit


//CLASS INHERITANCE

//Ex: A Class with one Property and a Custom Initializer
class Employee {
    let hours: Int //Property
    
    init(hours: Int) { //Custom Initializer
        self.hours = hours
    }
    
    func printSummary() { //Method
        print("I work \(hours) hours a day.")
    }
}

//Create two "subClasses" out of 'Employee' Class above & 'override' Inherited Method
class Developer: Employee { // childClassName: parentClassName
    func work() { //Method
        print("I'm writing code for \(hours) hours.") //Inherit 'hours' Property from 'Employee'
    }
    
    //'override': use to change a Method inherited from a "parentClass"
    override func printSummary() { //override inhereted Method 'printSummary' from 'Employee'
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

class Manager: Employee { // childClassName: parentClassName
    func work() {  //Method
        print("I'm going to meetings for \(hours) hours.") //Inherit 'hours' Property from 'Employee'
    }
}



//Making Instance that refers to its Inherited Property
let robert = Developer(hours: 8) //Instance refers its Inherited Property 'hours' from 'Employee'
let joseph = Manager(hours: 10) //Instance refers its Inherited Property 'hours' from 'Employee'
robert.work() //Result: "I'm writing code for 8 hours."
joseph.work() //Result: "I'm going to meetings for 10 hours."




//Making Instance that refers to its Inherited Property & Inherited Method
let novall = Developer(hours: 8)//Instance that refers Inherited Property 'hours'
//calling Inherited Method 'printSummary()' from 'childClass' 'Developer
//'printSummary()' has been 'override' at 'Developer' from its original Inherited Method
novall.printSummary()
//Result: "I'm a developer who will sometimes work 8 hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces."



//USE 'final' for CLASS THAT SHOULD NOT SUPPORT INHERITANCE
final class Boss {
    //Codes
}
//This 'final' Class CAN inherit from others, but NO OTHER CLASSES COULD INHERIT FROM IT
