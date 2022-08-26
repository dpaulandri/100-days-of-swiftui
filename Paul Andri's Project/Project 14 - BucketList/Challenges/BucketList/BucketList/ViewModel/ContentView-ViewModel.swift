//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Paul Andri on 08/26/2022.
//
// PART OF DAY 72 - IMPLEMENTING "MVVM" DESIGN PATTERN

import Foundation
import LocalAuthentication // BIOMETRIC AUTHENTICATION
import MapKit // MAPKIT FRAMEWORK
import SwiftUI

// VIEWMODEL AS 'ContentView' STRUCT EXTENSION
extension ContentView {
	// 'ViewModel' CLASS TO MANAGE & MANIPULATE DATA ON BEHALF OF 'ContentView' STRUCT
	/// CONFORMS TO 'ObservableObject' PROTOCOL - BROADCAST CHANGE ANNOUCEMENTS TO OBJECTS OBSERVING THIS CLASS
	/// '@MainActor' PROPERTY ATTRIBUTE EXPLANATION:
	/*
	 The '@MainActor' is responsible for running all User Interface updates,
	 and adding that Attribute to the Class means we want all its code;
	 any time it runs anything, unless we specifically ask otherwise – to run on that '@MainActor'.
	 This is important because it’s responsible for making UI updates, and those must happen on the '@MainActor'.
	 
	 By adding the '@MainActor' Attribute here:
	 We’re telling Swift every part of this Class should run on the '@MainActor',
	 so it’s safe to update the UI, no matter where it is used.
	 
	 Generally we should add the '@MainActor' Attribute to a Class that conforms to 'ObservableObject' Protocol.
	*/
	@MainActor class ViewModel: ObservableObject {
		// PUBLISHED PROPERTY TO STORE MAP'S INITIAL COORDINATE STATE
		/// COORIDNATE SHOWS MOST OF WESTERN EUROPE & NORTH AFRICA
		@Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
		
		// PUBLISHED PROPERTY TO STORE AN ARRAY OF 'Location' OBJECT TYPE DATA (NOT INITIALISED)
		/// VALUE WILL BE LOADED FROM THE CUSTOM 'init' INITIALIZER ON APP LOAD
		/// 'private(set)' ENSURE THAT ONLY THIS CLASS CAN SET (WRITE) VALUE TO THIS PROPERTY
		@Published private(set) var locations: [Location]
		
		 // PUBLISHED PROPERTY TO TRACK WHICH LOCATION MARKER IS SELECTED (OPTIONAL 'Location' OBJECT)
		@Published var selectedLocation: Location?
		
		// PUBLISHED PROPERTY TO TRACK WHETHER THE APP IS UNLOCKED (BIOMETRIC AUTHENTICATION)
		@Published var appUnlocked = false
		
		// PART OF DAY 73 - CHALLENGE #2 - SHOW ALERT WINDOW ON BIOMETRIC AUTHENTICATION FAIL
		// PUBLISHED PROPERTY TO TRACK WHETHER THE BIOMETRIC AUTHENTICATION FAILED
		@Published var authenticationFailed = false
		
		
		// CONSTANT PROPERTY STORING THE DOCUMENTS DIRECTORY URL PATH TO SAVE APP DATA TO
		/// USED THE 'documentsDirectory' FUNCTION FROM 'FileManager' EXTENSION
		let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedLocations")
		
		
		// CUSTOM INITIALIZER TO LOAD SAVED APP DATA FROM DOCUMENTS DIRECTORY
		init() {
			do {
				// TRY TO GET SAVED DATA FROM DOCUMENTS DIRECTORY URL OF 'savePath'
				let data = try Data(contentsOf: savePath)
				
				// TRY TO DECODE 'data' AS AN ARRAY OF 'Location' OBJECTS
				locations = try JSONDecoder().decode([Location].self, from: data)
			} catch {
				/// IF FAILED:
				// SET PUBLISHED PROPERTY 'locations' VALUE AS AN EMPTY ARRAY
				locations = []
				print("No saved locations found.")
			}
		}
		
		
		// METHOD TO SAVE 'locations' PUBLISHED PROPERTY LOCATION DATA SECURELY
		func save() {
			do {
				// TRY TO ENCODE 'locations' PUBLISHED PROPERTY LOCATION DATA
				let data = try JSONEncoder().encode(locations)
				
				// TRY TO ".atomicWrite" THE ENCODED 'data' TO THE SAVE PATH SECURELY W/ 'completeFileProtection''
				/// '.completeFileProtection' :
				/// - Add strong encryption to save Data
				/// - Saved Data is accessible only while the device/view/app is unlock
				try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
			} catch {
				print("Failed to save Data!")
			}
		}
		
		// METHOD TO ADD NEW 'Location' Object Data TO THE CLASS'S 'locations' PUBLISHED PROPERTY:
		func addLocation() {
			/// 1. CREATE NEW 'Location' OBJECT DATA
			let newLocation = Location(
				id: UUID(),
				name: "New Location",
				description: "",
				latitude: mapRegion.center.latitude,
				longitude: mapRegion.center.longitude
			)
			
			/// 2. APPEND 'newLocation' OBJECT DATA TO THE ARRAY IN 'locations' STATE PROPERTY
			locations.append(newLocation)
			
			/// 3. CALL 'save() METHOD TO SAVE THE NEW LOCATION INTO THE APP'S DOCUMENTS DIRECTORY FILE
			save()
		}
		
		// METHOD TO EDIT/UPDATE & OVERWRITE THE EXISTING 'Location' OBJECT DATA
		/// ACCEPTS A 'Location' OBJECT
		func updateLocation(location: Location) {
			// TRY TO UNWRAP USER SELECTED LOCATION, EXIT METHOD IF FAIL
			guard let selectedLocation = selectedLocation else { return }
			
			// TRY TO FIND THE ARRAY INDEX OF PASSED-IN 'selectedLocation' FROM THE ARRAY IN THE CLASS' 'locations' PUBLISHED PROPERTY
			if let index = locations.firstIndex(of: selectedLocation) {
				/// IF THE ARRAY INDEX IS FOUND;
				// OVERWRITE ORIGINAL 'Location' OBJECT AT THE ARRAY INDEX W/ NEW 'Location' OBJECT DATA
				locations[index] = location
				
				// CALL 'save() METHOD TO SAVE THE UPDATED LOCATION DATA INTO THE APP'S DOCUMENTS DIRECTORY FILE
				save()
			}
		}
		
		// CONTAIN CODE FOR PART OF DAY 73 - CHALLENGE #2 - SHOW ALERT WINDOW ON BIOMETRIC AUTHENTICATION FAIL
		// METHOD TO HANDLE BIOMETRIC AUTHENTICATION ('FACE ID' & 'TOUCH ID')
		func authenticate() {
			// STEP 1A: CREATE A NEW 'LAContext' NSOBJECT CLASS INSTANCE
			/// 'LAContext' NSObject Class - A mechanism for evaluating authentication policies and access controls
			let context = LAContext()
			// STEP 1B: A PROPERTY TO STORE OPTIONAL OBJ-C 'NSError' CLASS OBJECT
			var error: NSError?
			
			// STEP 2: CHECK WHETHER BIOMETRIC AUTHENTICATION IS AVAILABLE ON THE DEVICE
			/// 'LAPolicy' ENUM - the set of available "Local Authentication" policies
			/// '.deviceOwnerAuthenticationWithBiometrics' IS A CASE OF 'LAPolicy' ENUM
			/// '&' PASS THE 'NSError' CLASS OBJECT DIRECTLY INTO THE FUNCTION & ALLOWS IT TO CHANGE INSIDE THE FUNCTION
			if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
				// STEP 3: SET 'localizedReason' STRING VALUE
				let reason = "Please authenticate to unlock app."
				
				// STEP 4: START BIOMETRIC AUTHENTICATION REQUEST PROCESS
				///  'localizedReason' STRING VALUE IS SHOWN TO THE USER AS THE REASON TO AUTHENTICATE
				context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
					// COMPLETION CLOSURE (A BACKGROUND TASK, NOT ON '@MainActor')
					/// CALLED WHENEVER AN AUTHENTICATION PROCESS IS DONE (SUCCESS/FAIL)
					if success {
						// START A BACKGROUND TASK ON MAIN ACTOR
						/// '@MainActor in' ENSURE THE WHOLE TASKS IN THE CLOSURE WILL RUN ON MAINACTOR
						Task { @MainActor in
							// FUNCTION/CODE TO BE ON MAINACTOR
							self.appUnlocked = true
						}
					} else {
						/// IF AUTHENTICATION ERROR:
						// START A BACKGROUND TASK ON MAIN ACTOR
						/// '@MainActor in' ENSURE THE WHOLE TASKS IN THE CLOSURE WILL RUN ON MAINACTOR
						Task { @MainActor in
							self.appUnlocked = false
							// PART OF DAY 73 - CHALLENGE #2 - SHOW ALERT WINDOW ON BIOMETRIC AUTHENTICATION FAIL
							self.authenticationFailed = true
						}
					}
				}
			} else {
				// DEVICE HAVE NO BIOMETRIC AUTHENTICATION CAPABILITY
				/// POSSIBLE REASONS;
				/// - DEVICE HAVE NO 'Face ID' OR 'Touch ID' CAPABILITIES,
				/// - USER HAS NOT ENROLL THEIR BIOMETRIC DATA

				// USE OTHER AUTHENTICATION METHOD HERE (IE. PIN/PASSCODE)
			}
		}
	}
}
