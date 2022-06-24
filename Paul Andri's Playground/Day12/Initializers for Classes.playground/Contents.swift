import UIKit


//INITIALIZERS FOR CLASS

//Define a new Class named 'Vehicle'
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
        // 'self' assign the 'init' Parameter name to the Class' Property name
    }
}

//Ex 1: Making a 'Car' subClass (w/ Custom 'init()')
//Inherting from 'Vehicle' superClass + its Custom 'init()'
class Car: Vehicle {
    let isConvertible: Bool

    //IF a “child” Class has any Custom 'init()', it MUST always call the ”parent’s” 'init()' AFTER it has finished setting up its own Properties, if it has any.
    init(isElectric: Bool, isConvertible: Bool) { //'isConvertible: Bool' superClass' custom 'init()'
        self.isConvertible = isConvertible //subClass' Initializer
        super.init(isElectric: isElectric) //Call superClass' Initializer with 'super.init()'
        //'super' allows us to call up to any Methods that belong to our “parent” Class
    }
}

//Create an Instance of 'Car' Class
let teslaX = Car(isElectric: true, isConvertible: false)
teslaX.isConvertible
teslaX.isElectric



//Ex 2: Making a 'CarNoInheritance' subClass (w/o Custom 'init()'
//Inherting from 'Vehicle' superClass + its Custom 'init()'
class CarNoInheritance: Vehicle {
    let isConvertible = false //Propety is provided a Default Value
    //No custom 'init()
}

//Create an Instance of 'CarNoInheritance' Class
let teslaZ = CarNoInheritance(isElectric: true) //Inherit 'Vehicle' superClass' custom 'init()'
teslaZ.isConvertible
teslaZ.isElectric

