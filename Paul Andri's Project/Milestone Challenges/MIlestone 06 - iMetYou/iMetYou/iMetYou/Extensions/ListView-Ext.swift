//
//  ListView-Ext.swift
//  iMetYou
//
//  Created by Paul Andri on 09/16/2022.
//

import Foundation
import SwiftUI

extension ListView {
	// METHOD TO DELETE PERSON DATA FROM COREDATA 'FetchRequest'
	func deletePerson(at offsets: IndexSet) {
		
		// STEP 1: FIND THE PERSON DATA INDEX & DELETE THE "LIVE" DATA FROM 'managedObjectContext' ON iDevice MEMORY
		// FOR LOOP TO LOOP OVER EVERY DATA INDEX FROM THE PASSED-IN 'offsets' COLLECTION
		for offset in offsets {
			
			// STEP 1A:
			// FIND THE PERSON DATA INDEX USING THE 'offset' INDEXSET ON 'persons' 'FetchRequest' PROPERTY DATA
			// DEFINE IT AS THE 'person' OBJECT
			let person = persons[offset]
			
			// STEP 1B: DELETE ASSOCIATED PROFILE PICTURE
			// FILENAME CORRESPONDS TO THE PERSON UUID
			let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
			try? FileManager.default.removeItem(at: url)
			
			// STEP 1C:
			// DELETE THAT PERSON DATA ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
			moc.delete(person)
		}
		
		// STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
		try? moc.save()
	}
	
	// METHOD TO LOAD PROFILE PICTURE FROM DOCUMENTS DIRECTORY
	func profilePicture(person: Person) -> Image {
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)

		if let profilePicture = UIImage(contentsOfFile: url.path) {
			return Image(uiImage: profilePicture)
		} else {
			return Image(systemName: "person.crop.circle.fill") }
	}
}
