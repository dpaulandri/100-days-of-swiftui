import UIKit


//COMPUTE PROPERTY VALUE DYNAMICALLT

//Simplified Version of previous 'Employee' Struct
struct Employee {
    //Do not have stored default Value for each Property
    let name: String
    var vacationRemaining: Int
}

var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.vacationRemaining -= 5 //14 - 5
print(archer.vacationRemaining) //Result: 9
archer.vacationRemaining -= 3 //9 - 3
print(archer.vacationRemaining) //Result: 6


//Struct adjusted to use Computed Property
struct EmployeeComPro {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    //'vacationAllocated' & 'vacationTaken' Properties have store default values

    var vacationRemaining: Int {
        vacationAllocated - vacationTaken //Computed Property
    }
}

//Creating 'archerCP' Instance with Initializer values
var archerCP = EmployeeComPro(name: "Sterling Archer", vacationAllocated: 14)
//we’re reading what looks like a Property, but behind the scenes Swift is running some code to calculate its value every time.
archerCP.vacationTaken += 4 //read like a Property, but calculation are executed in Method
print(archerCP.vacationRemaining) //Result: 14 - 4 = 10
archerCP.vacationTaken += 4 //read like a Property, but calculation are executed in Method
print(archerCP.vacationRemaining) //Result: 10 - 4 = 6
//We CAN’T write to it, though, because we haven’t told Swift how that should be handled


//The above Struct using Computed Property + 'get' & 'set'
struct EmployeeSetGet {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    //'vacationAllocated' & 'vacationTaken' Properties have store default values
    
    var vacationRemaining: Int {
        //Providing Swift with a 'get' = "codes that reads" and 'set' = "code that writes
        get { //'get' mark the piece of code to run when reading
            vacationAllocated - vacationTaken //Computed Property
        }
        set { //'set' mark the piece of code to run when writing
            vacationAllocated = vacationTaken + newValue //Computed Property
            //'newValue' automatically provided to us by Swift, and stores whatever value the user was trying to assign to the Property
        }
    }
}
/*'get' & 'set' CODE INTENTION:
 If we set 'vacationRemaining' for an employee, we want their 'vacationAllocated' value to be increased or decreased.
*/

//Create 'archerSG' Intance with Intislizer values
var archerSG = EmployeeSetGet(name: "Sterling Archer", vacationAllocated: 14)

//Override 'vacationTaken' default value by adding 4
archerSG.vacationTaken += 4 //Result: 0 (Default) + 4 = 4

//call 'cavationRemaining' Method with 5 as its argument value
//'vacationRemaining' set { vacationAllocated = vacationTaken (4) + newValue (5) }
archerSG.vacationRemaining = 5 //vacationAllocated = 4 + 5 (newValue) = 9

//print 'vacationAllocated' Property value
print(archerSG.vacationAllocated) //Result: 9
