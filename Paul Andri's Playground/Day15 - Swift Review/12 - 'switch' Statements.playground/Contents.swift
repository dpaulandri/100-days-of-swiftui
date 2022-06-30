// Created by Paul Andri on 29/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// SWITCH STATEMENTS 'switch' 'case'
// Check a value against multiple Conditions ('case')
enum Weather {  //  'Weather' Enum & its cases
    case sun, rain, wind
}

// Make an Instance out of 'Weather' w/ initial case value 'sun'
let forecast = Weather.sun

// Check 'forecast' value by using 'switch' & ref. its 'case's from 'Weather'
switch forecast {
    case .sun:  // IF 'forecast' value is 'Weather.sun'
    print("A nice day.")
    case .rain:  // IF 'forecast' value is 'Weather.rain'
    print("Pack an umbrella.")
    default: // ELSE ('switch' Statements MUST be EXHAUSTIVE)
    print("Should be okay.")
}
