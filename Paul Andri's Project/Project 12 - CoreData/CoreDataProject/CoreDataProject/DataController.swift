//
//  DataController.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/13/2022.
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
    // TELL COREDATA TO USE 'CoreDataProject' DATA MODEL FILE
    // THIS 'NSPersistentContainer' PROPERTY IS WHERE THE ACTUAL APP DATA WILL BE READ & WRITE INTO
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    // INITIALIZER TO LOAD THE 'container' PROPERTY'S 'NSPersistentContainer' TYPE DATA AS ITS "PERSISTENT STORES"
    init() {
        // LOAD COREDATA "PERSISTENT STORES" FROM 'container' 'NSPersistentContainer' TYPE PROPERTY
        container.loadPersistentStores { description, error in // PASS-IN 'description' AND 'error' VALUES
            // IF CORE DATA "PERSISTENT STORES" LOAD FAILED
            if let error = error {
                // PRINT ERROR MESSAGE W/ LOCALIZED ERROR DESCRIPTION
                print("Failed to load Core Data: \(error.localizedDescription)")
                // EXIT THE CONDITION
                return
            }
            
            
            // PART OF DAY 57 MATERIALS: ENSURE COREDATA OBJECT UNIQUENESS BY USING "CONSTRAINTS"
            // WE'VE PLACED CONSTAINT ON 'Wizard' OBJECT'S 'name' ATTRIBUTE (HAS TO BE UNIQUE/NO DUPLICATES)
            // IF WE WANT TO STILL ALLOW DATA SAVING FOR 'Wizard' OBJECTS THAT HAVE THE SAME 'name' ATTRIBUTE VALUE:
            // SPECIFY 'mergePolicy' TO HANDLE 'Wizard' OBJECTS THAT HAVE THE SAME 'name' ATTRIBUTE VALUE
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            // CODE EXPLANATION:
            /*
             Asks CoreData to MERGE duplicate Objects based on their Properties;
             CoreData tries to intelligently Overwrite the Version in its Database using Properties from the New Version.
            */
            // RESULT:
            // ALL 'Wizard' OBJECTS W/ THE SAME 'name' ATTRIBUTE VALUE WILL BE MERGE INTO SINGLE 'Wizard' OBJECT
            // NO MULTIPLE OBJECTS W/ THE SAME 'name' ATTRIBUTE VALUE IS SAVED INSIDE COREDATA'S DATABASE
            // ENSURING UNIQUENESS
        }
    }
}
