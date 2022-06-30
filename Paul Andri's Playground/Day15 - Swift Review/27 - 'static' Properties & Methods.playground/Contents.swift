// Created by Paul Andri on 30/06/2022

import UIKit


// Day 15 - SWIFT REVIEW

// STATIC PROPERTIES & METHODS - 'static'
// Add a Property or Method directly to the Struct itself w/o creating an Instance

//Ex: a Struct w/ static Properties
struct AppData {
    static let version = "1.3 beta 2"   // 'static' Property
    static let settings = "settings.json"   // 'static' Property
}
// CODE COMMENT: everywhere we need to check or display something like the app’s version number we can read 'AppData.version'
