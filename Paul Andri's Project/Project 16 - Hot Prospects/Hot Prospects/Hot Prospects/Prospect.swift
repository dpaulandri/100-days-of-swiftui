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
	/// This Property can be READ from anywhere, but CAN ONLY BE WRITTENfrom the current file (Prospect.swift)”
	fileprivate(set) var isContacted = false
}


// CLASS COMFORMING TO 'ObservableObject' PROTOCOL
/// FOR SHARING DATA ACROSS SWIFTUI'S ENVIRONMENT
/// GENERALLY WE SHOULD MARK EVERYTHING THAT CONFORMS TO 'ObservableObject' PROTOCOL W/ '@MainActor'
@MainActor class Prospects: ObservableObject {
	// PUBLISHED PROPERTY W/ 'Prospect' OBJECT ARRAY TYPE
	/// WILL ANNOUNCE ANY CHANGES TO THIS PROPERTY TO ALL ITS CHILD VIEWS
	@Published var people: [Prospect]
	
	// CUSTOM INITIALIZER
	init() {
		// INITIALISE 'people' PUBLISHED PROPERTY AS AN EMPTY ARRAY
		self.people = []
	}
	
	// METHOD TO TOGGLE PROSPECT'S 'isContacted' BOOL STATE
	/// WILL BROADCAST VALUE/STATE CHANGE NOTIFICATION JUST BEFORE IT HAPPEN
	func toggleContacted(_ prospect: Prospect) {
		// SEND/BROADCAST VALUE/STATE CHANGE NOTIFICATION JUST BEFORE IT HAPPEN
		objectWillChange.send()
		// TOGGLE PROSPECT'S 'isContacted' BOOL STATE
		prospect.isContacted.toggle()
	}
}
