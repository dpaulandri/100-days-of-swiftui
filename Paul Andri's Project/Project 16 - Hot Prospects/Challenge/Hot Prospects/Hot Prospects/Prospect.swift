//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Paul Andri on 09/23/2022.
//

import SwiftUI

// PART OF DAY 85 - CHALLENGE #3
// CLASS OBJECT TO STORE A PROSPECT'S INFO, COMFORMS TO 'Identifiable' & 'Codable' PROTOCOLS
/// The choice of using 'class' is intentional; it allows us to change instances of the Class directly and have it be updated in all other Views at the same time
class Prospect: Identifiable, Codable {
	var id = UUID()
	var name = "Anonymous"
	var emailAddress = ""
	
	// 'fileprivate(set)' - ACCESS CONTROL
	/// This Property can be READ from anywhere, but CAN ONLY BE WRITTEN from within the current file (Prospect.swift)”
	fileprivate(set) var isContacted = false
}


// CLASS COMFORMING TO 'ObservableObject' PROTOCOL
/// FOR SHARING DATA ACROSS SWIFTUI'S ENVIRONMENT
/// GENERALLY WE SHOULD MARK EVERYTHING THAT CONFORMS TO 'ObservableObject' PROTOCOL W/ '@MainActor'
@MainActor class Prospects: ObservableObject {
	// PUBLISHED PROPERTY W/ 'Prospect' OBJECT ARRAY TYPE
	/// WILL ANNOUNCE ANY CHANGES TO THIS PROPERTY TO ALL ITS CHILD VIEWS
	/// 'fileprivate(set)' - This Property can be READ from anywhere, but CAN ONLY BE WRITTEN from within the current Class
	@Published private(set) var people: [Prospect]
	
	// PART OF DAY 85 - CHALLENGE #2
	/// Use JSON and the documents directory for saving and loading our user data
	// CONSTANT PROPERTY STORING THE DOCUMENTS DIRECTORY URL PATH TO SAVE APP DATA TO
	/// USED THE 'documentsDirectory' FUNCTION FROM 'FileManager' EXTENSION
	let savePath = FileManager.documentsDirectory.appendingPathComponent("savedProspects")
	
	// PART OF DAY 85 - CHALLENGE #2
	/// Use JSON and the documents directory for saving and loading our user data
	// CUSTOM INITIALIZER
	init() {
		do {
			// TRY TO GET SAVED DATA FROM DOCUMENTS DIRECTORY URL OF 'savePath'
			let data = try Data(contentsOf: savePath)
			
			// TRY TO DECODE 'data' AS AN ARRAY OF 'Prospect' OBJECTS
			people = try JSONDecoder().decode([Prospect].self, from: data)
		} catch {
			/// IF LOADING DATA FROM USERDEFAULTS FAILED;
			// INITIALISE 'people' PUBLISHED PROPERTY AS AN EMPTY ARRAY
			people = []
			print("No saved locations found.")
		}
	}
	
	// PART OF DAY 85 - CHALLENGE #2
	/// Use JSON and the documents directory for saving and loading our user data
	// PRIVATE METHOD TO CONVERT PROSPECT OBJECT ARRAY DATA INTO JSON DATA & SAVE IT TO DOCUMENTSDIRECTORY
	/// THIS PRIVATE METHOD CAN ONLY BE CALLED from within the current Class
	private func save() {
		do {
			// TRY TO ENCODE PUBLISHED PROPERTY 'people' INTO JSON DATA FORMAT
			let data = try JSONEncoder().encode(people)
			
			// TRY TO ".atomicWrite" THE ENCODED 'data' TO THE SAVE PATH SECURELY W/ 'completeFileProtection''
			/// '.completeFileProtection' :
			/// - Add strong encryption to save Data
			/// - Saved Data is accessible only while the device/view/app is unlock
			try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
		} catch {
			print("Failed to save new Prospect Data!")
		}
	}
	
	// METHOD TO ADD & SAVE PROSPECT OBJECT INTO USERDEFAULTS
	func addProspect(_ prospect: Prospect) {
		// APPEND THE PASSED-IN 'Prospect' OBJECT INTO THE CLASS' 'people' PROSPECT OBJECT DATA ARRAY
		people.append(prospect)
		// CALL 'save()' PRIVATE METHOD TO SAVE CHANGE(S) INTO THE USERDEFAULTS
		save()
	}
	
	// METHOD TO TOGGLE PROSPECT'S 'isContacted' BOOL STATE
	/// WILL BROADCAST VALUE/STATE CHANGE NOTIFICATION JUST BEFORE IT HAPPEN
	func toggleContacted(_ prospect: Prospect) {
		// SEND/BROADCAST VALUE/STATE CHANGE NOTIFICATION JUST BEFORE IT HAPPEN
		objectWillChange.send()
		// TOGGLE PROSPECT'S 'isContacted' BOOL STATE
		prospect.isContacted.toggle()
		// CALL 'save()' PRIVATE METHOD TO SAVE CHANGE(S) INTO USERDEFAULTS
		save()
	}
}
