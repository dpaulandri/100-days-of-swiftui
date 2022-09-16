//
//  AddNewPersonView-Ext.swift
//  iMetYou
//
//  Created by Paul Andri on 09/16/2022.
//

import Foundation
import SwiftUI

extension AddNewPersonView {
	// METHOD TO LOAD USER SELECTED IMAGE
	func loadImage() {
		// TRY TO GET THE INPUT IMAGE FROM 'inputImage' STATE PROPERTY, EXIT IF FAIL
		guard let inputImage = inputImage else { return }
		
		// CREATE AN 'Image' USING 'uiImage' VALUE AND SET THE VALUE TO 'image' STATE PROPERTY
		image = Image(uiImage: inputImage)
	}
	
	// METHOD TO SAVE USER SELECTED IMAGE TO DOCUMENTSDIRECTORY
	func saveImage(person: Person) {
		// TRY TO GET THE INPUT IMAGE FROM 'inputImage' STATE PROPERTY, EXIT IF FAIL
		guard let inputImage = inputImage else { return }
		
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
		
		if let jpegData = inputImage.jpegData(compressionQuality: 0.6)
		{
			try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
		}
	}
	
	// METHOD TO CHECK FOR PERSON DETAIL INPUT VALIDITY
	func inputDetailValid() -> Bool {
		if firstName.isEmpty || lastName.isEmpty || email.isEmpty || email.count < 5 || !email.contains("@") || !email.contains(".") || phoneNumber.isEmpty {
			return false
		} else { return true }
	}
}
