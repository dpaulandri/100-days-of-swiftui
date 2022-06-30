// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// PROTOCOLS 'protocol'
// Protocols DEFINE Functionality we EXPECT a Data Type to support
// Ex: Define a 'Vehicle' Protocol:
protocol VehicleProtocol {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
// COMMENT: That lists the REQUIRED Methods for this Protocol to work, but DOESN’T contain any code

// Make a 'CarStruct' Struct that conforms to 'VehicleProtocol'
struct CarStruct: VehicleProtocol {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
}
// COMMENT: All the Methods listed in 'VehicleProtocol' MUST EXIST EXACTLY in 'CarStruct', with the SAME name, Parameters, and Return Types


// Write a 'func'' that accepts ANY kind of Type that conforms to 'VehicleProtocol'
func commute(distance: Int, using vehicle: VehicleProtocol) {   // 'using' Keyword
    if vehicle.estimateTime(for: distance) > 100 {
        print("Too slow!")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = CarStruct()   // Create a 'CarStruct' Struct Instance
commute(distance: 100, using: car)  // Call 'func' w/ Initializer values
// Prints: "I'm driving 100km."


// Protocols can also require Properties
protocol AnotherVehicle {
    var name: String { get }    // Required Property w/ 'get' READ PERMISSION
    var currentPassengers: Int { get set }
    // Required Property w/ 'get' READ & 'set' WRITEPERMISSION
    
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}


// We can CONFORM TO AS MANY PROTOCOL AS WE NEED
// Ex: 'struct ConformMany: VehicleProtocol, AnotherVehicle { }'
