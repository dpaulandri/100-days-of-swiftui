// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// COMPUTED PROPERTIES & READ 'get' WRITE 'set' PERMISSION
// Calculates its Property value every time it’s accessed/ran

// Ex: a Struct w/ Stored Property & Computed Property
struct Employee {
    let name: String  // Stored Property (no Default value)
    var vacationAllocated = 14  // Stored Property
    var vacationTaken = 0  // Stored Property

    var vacationRemaining: Int { // Computed Property value
        vacationAllocated - vacationTaken   // Computation
    }
    
    // To be able to WRITE to to a Computed Property we NEED to provide both a 'get' and a 'set' permission
    var vacationRemainingGS: Int {  // Computed Property value
        get {   // 'get' permission to READ Property value
            vacationAllocated - vacationTaken
        }

        set {   // 'set' permisison to WRITE new value to Property
            vacationAllocated = vacationTaken + newValue
        }
        // 'newValue' provided by Swift, stores whatever value the user was assigning to the Property. Available ONLY for 'set'
    }
}

var timeOff = Employee(name: "Baba", vacationTaken: 5)
timeOff.vacationRemaining   // Returns: 9 (Computed Property)

// Write value to a Read ('get') & Write ('set') Computed Property
timeOff.vacationRemainingGS = 5
timeOff.vacationRemainingGS // Returns: 5 (NOT Computed!)
