//
//  DataController.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import CoreData
import Foundation

// DATA CONTROLLER CLASS
// CONFORMS TO 'ObservableObject' PROTOCOL
class DataController: ObservableObject {
	// CREATE A SINGLE 'NSPersistentContainer' TYPE PROPERTY
	/* 'NSPersistentContainer':
	 'CoreData' Type responsible for loading a "Data Model" and giving us access to the Data inside.*/
	// TELL COREDATA TO USE 'iMetYou' DATA MODEL FILE
	// THIS 'NSPersistentContainer' PROPERTY IS WHERE THE ACTUAL APP DATA WILL BE READ & WRITE INTO
	let container = NSPersistentContainer(name: "iMetYou")
	
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
			
			// SPECIFY 'mergePolicy' TO HANDLE 'Wizard' OBJECTS THAT HAVE THE SAME 'name' ATTRIBUTE VALUE
			self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
			// CODE EXPLANATION:
			/*
			 Asks CoreData to MERGE duplicate Objects based on their Properties;
			 CoreData tries to intelligently Overwrite the Version in its Database using Properties from the New Version.*/
		}
	}
}
