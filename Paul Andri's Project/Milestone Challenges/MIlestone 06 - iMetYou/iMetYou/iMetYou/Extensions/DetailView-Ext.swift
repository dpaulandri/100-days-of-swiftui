//
//  DetailView-Ext.swift
//  iMetYou
//
//  Created by Paul Andri on 09/16/2022.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

extension DetailView {
	// METHOD TO DELETE PERSON DATA FROM COREDATA PERSISTENT STORAGE & DISMISS 'DetailView' BACK TO ITS PREVIOUS VIEW
	func deletePerson() {
		// STEP 1: DELETE THE CURRENT PERSON DATA SHOWN ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
		moc.delete(person)
		
		// STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
		try? moc.save()
		
		// STEP 3: DELETE ASSOCIATED PROFILE PICTURE
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
		try? FileManager.default.removeItem(at: url)
		
		// STEP 4: CALL DISMISS TO DISMISS THE CURRENT 'DetailView'
		dismiss()
	}
	
	func profilePicture(person: Person) -> Image {
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
		
		if let profilePicture = UIImage(contentsOfFile: url.path) {
			return Image(uiImage: profilePicture)
		} else { return Image(systemName: "person.crop.circle.fill") }
	}
	
	func setCoordinate() {
		region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
	}
}
