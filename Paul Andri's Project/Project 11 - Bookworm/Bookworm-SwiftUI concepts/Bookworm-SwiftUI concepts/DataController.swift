//
//  DataController.swift
//  Bookworm-SwiftUI concepts
//
//  Created by Paul Andri on 08/11/2022.
//
// DATA CONTROLLER FOR COREDATA MODEL

// IMPORT COREDATA FRAMEWORK
import CoreData
import Foundation


// DATA CONTROLLER CLASS
// CONFORMS TO 'ObservableObject' PROTOCOL
class DataController: ObservableObject {
    // CREATE A SINGLE 'NSPersistentContainer' TYPE PROPERTY
    /* 'NSPersistentContainer':
     'CoreData' Type responsible for loading a "Data Model" and giving us access to the Data inside.*/
    // TELL COREDATA TO USE 'ExampleDataModel' DATA MODEL FILE
    // THIS 'NSPersistentContainer' PROPERTY IS WHERE THE ACTUAL APP DATA WILL BE READ & WRITE INTO
    let container = NSPersistentContainer(name: "ExampleDataModel")
    
    // INITIALIZER TO LOAD THE 'container' PROPERTY'S 'NSPersistentContainer' TYPE DATA AS ITS "PERSISTENT STORES"
    init() {
        // LOAD COREDATA "PERSISTENT STORES" FROM 'container' 'NSPersistentContainer' TYPE PROPERTY
        container.loadPersistentStores { description, error in // PASS-IN 'description' AND 'error' VALUES
            // IF CORE DATA "PERSISTENT STORES" LOAD FAILED
            if let error = error {
                // PRINT ERROR MESSAGE W/ LOCALIZED ERROR DESCRIPTION
                print("Failed to load Core Data: \(error.localizedDescription)")
            }
        }
    }
}
