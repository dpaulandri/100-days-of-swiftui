import UIKit


//CHECKPOINT 6
/*
 1. Create a Struct to store information about a car that includes:
    - Its model,
    - Number of seats, and
    - Current gear
 
 2. Add a Method to change gears up or down.
    Have a think about Variables and Access Control:
    - What Data should be a Variable rather than a Constant, and
    - What Data should be exposed publicly?
    - Should the gear-changing Method validate its input somehow?
*/


//Paul Andri's Solution
struct Car {
    static let carModel = "Tesla"
    static let carSeats = 5
    private(set) static var currentGear = 1
    
    static func gearChange(gear: Int) {
        if gear > Car.currentGear && gear <= 10 && gear >= 1 {
            Car.currentGear = gear
            print("Shifted \(carModel) Up to Gear #\(Car.currentGear)")
        } else if gear < Car.currentGear && gear <= 10 && gear >= 1 {
            Car.currentGear = gear
            print("Shifted \(carModel) Down to Gear #\(Car.currentGear)")
        } else if gear == Car.currentGear {
            print("\(carModel) is already in Gear #\(Car.currentGear)")
        } else {
            print("Oops! Gear must be between 1 - 10")
        }
    }
}

print("You're car model is \(Car.carModel)")
print("Your \(Car.carModel) has a capacity of \(Car.carSeats)seats")
print("Your \(Car.carModel) is currently on Gear #\(Car.currentGear)")

Car.gearChange(gear: 0) //Result: Oops! Gear must be between 1 - 10
Car.gearChange(gear: 5) //Result: Shifted Tesla Up to Gear #5
Car.gearChange(gear: 11) //Result: Oops! Gear must be between 1 - 10
Car.gearChange(gear: 1) //Result: Shifted Tesla Down to Gear #1
Car.gearChange(gear: 5) //Result: Shifted Tesla Up to Gear #5

print("Your \(Car.carModel) is currently on Gear #\(Car.currentGear)")
