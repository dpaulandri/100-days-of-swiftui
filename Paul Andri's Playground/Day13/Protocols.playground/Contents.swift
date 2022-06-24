import UIKit


//PROTOCOLS - a Type

//Define a Protocol w/ list of MINIMUM REQUIRED METHODS
protocol Vehicle { //Protocol is a Type, its name start with UPPERCASE letter
    //listing the required Methods for the Protocol, no 'func' body code is provided
    func estimateTime(for distance: Int) -> Int //Required Method 1
    func travel(distance: Int) //Required Method 2
}


//Creating a 'Car' Struct that Conforms to the 'Vehicle' Protocol
// ':' is used to mark that 'Car' Struct conforms to 'Vehicle' Protocol
struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int { //Required Method 1
        distance / 50
    }
    
    func travel(distance: Int) { //Required Method 2
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}


//Creating a 'Bicycle' Struct that Conforms to the 'Vehicle' Protocol
struct Bicycle: Vehicle {
    func estimateTime(for distance: Int) -> Int { //Required Method 1
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km.") //Required Method 2
    }
}


//'func' making use of the 'Vehicle' Protocol's list of Methods
func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

//Create a 'var' out of 'Car' Struct
let car = Car()
//Calling the  'commute' Method with Initializer values
commute(distance: 100, using: car) //Print: "I'm driving 100km."

//Create a 'var' out of 'Bicycle' Struct
let bike = Bicycle()
//Calling the  'commute' Method with Initializer values
commute(distance: 50, using: bike) //Print: "I'm cycling 50km."





//Define a Protocol w/ list of MINIMUM REQUIRED PROPERTIES & METHODS
protocol VehicleProp {
    //Syntax: 'var, then a Property name, then list whether it should be Readable 'get' and/or Writeable 'set'
    var name: String { get } //Required Property 1 - 'get' READABLE
    var currentPassengers: Int { get set } //Required Property 2 - 'get set' R/W
    func estimateTime(for distance: Int) -> Int //Required Method 1
    func travel(distance: Int) //Required Method 2
}


//Creating a 'CarProp' Struct that Conforms to the 'VehicleProp' Protocol
// ':' is used to mark that 'CarProp' Struct conforms to 'VehicleProp' Protocol
struct CarProp: VehicleProp {
    let name = "Car" //Required Property 1 - 'get' READABLE
    var currentPassengers = 1 //Required Property 2 - 'get set' R/W
    
    func estimateTime(for distance: Int) -> Int { //Required Method 1
        distance / 50
    }
    
    func travel(distance: Int) { //Required Method 2
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}


//Creating a 'BicycleProp' Struct that Conforms to the 'VehicleProp' Protocol
struct BicycleProp: VehicleProp {
    let name = "Bicycle" //Required Property 1 - 'get' READABLE
    var currentPassengers = 1 //Required Property 2 - 'get set' R/W
    
    func estimateTime(for distance: Int) -> Int { //Required Method 1
        distance / 10
    }
    
    func travel(distance: Int) { //Required Method 2
        print("I'm cycling \(distance)km.")
    }
}


//'func' making use of the 'VehicleProp' Protocol's list of Methods
func commute(distance: Int, using vehicle: VehicleProp) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}


//Create a 'var' out of 'CarProp' Struct
let carProp = CarProp()
//Calling the  'commute' Method with Initializer values
commute(distance: 100, using: car) //Print: "I'm driving 100km."

//Create a 'var' out of 'BicycleProp' Struct
let bikeProp = BicycleProp()
//Calling the  'commute' Method with Initializer values
commute(distance: 50, using: bike) //Print: "I'm cycling 50km."


//a Method that accepts an Array of Vehicles and uses it to calculate estimates across a range of options
func getTravelEstimates(using vehicles: [VehicleProp], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [bikeProp, carProp], distance: 150)
/*Print Results:
 Bicycle: 15 hours to travel 150km
 Car: 3 hours to travel 150km
*/




//WE CAN CONFORM WITH AS MANY PROTOCOLS ARE WE WANT:
protocol Protocol1 {
    //Code
}
protocol Protocol2 {
    //Code
}
protocol Protocol3 {
    //Code
}

//Separating each Protocol Names with a COME ' , '
struct ConformBonanza: Protocol1, Protocol2, Protocol3 {
    //Code
}




//IF WE NEED TO SUBCLASS A CLASS & CONFORM TO PROTOCOLS:
class ClassParent {
    //Code
}

// List the "parent" Class first, followed by the Protocol Names
class ClassChild: ClassParent, Protocol1, Protocol2 {
    //Code
}
