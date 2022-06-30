// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// OPTIONALS 'Type?'
// Represent THE ABSENCE OF DATA
// Any kind of Data can be Optional, including 'Int', 'Double', and 'Bool', as well as Instances of Enums, Structs, and Classes

//Ex: Constant that returns an Optional value from a Dictionary
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"]

let peachOpposite = opposites["Peach"]
// Returns String? special value: 'nil' (NO VALUE)
// COMMENT: attempts to read the value attached to the key “Peach”, which DOESN’T EXIST, this returns an Optional 'String?' special value 'nil'
