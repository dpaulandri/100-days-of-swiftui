//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Paul Andri on 09/23/2022.
//

import SwiftUI

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
	
	// PROPERTY TO STORE USERDEFAULTS DATA KEY
	/// GREAT FOR APP MAINTAINABILITY
	let dataKey = "savedProspects"
	
	// CUSTOM INITIALIZER
	init() {
		// TRY TO LOAD DATA FROM USERDEFAULTS W/ 'dataKey' PROPERTY VALUE AS ITS DATA KEY
		if let data = UserDefaults.standard.data(forKey: dataKey) {
			if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
				people = decoded
				return
			}
		}
		
		// IF LOADING DATA FROM USERDEFAULTS FAILED;
		// INITIALISE 'people' PUBLISHED PROPERTY AS AN EMPTY ARRAY
		people = []
	}
	
	// PRIVATE METHOD TO SAVE PROSPECT OBJECT ARRAY DATA INTO USERDEFAULTS
	/// THIS PRIVATE METHOD CAN ONLY BE CALLED from within the current Class
	private func save() {
		// TRY TO ENCODE PUBLISHED PROPERTY 'people' INTO JSON DATA FORMAT
		if let encoded = try? JSONEncoder().encode(people) {
			// SAVE THE JSON ENCODED DATA TO USERDEFAULTS W/ 'dataKey' PROPERTY VALUE AS ITS DATA KEY
			UserDefaults.standard.set(encoded, forKey: dataKey)
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
