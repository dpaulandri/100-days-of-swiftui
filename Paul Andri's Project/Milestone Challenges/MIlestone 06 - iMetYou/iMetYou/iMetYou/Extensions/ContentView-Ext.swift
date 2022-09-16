//
//  ContentView-Ext.swift
//  iMetYou
//
//  Created by Paul Andri on 09/16/2022.
//

import Foundation
import LocalAuthentication

extension ContentView {
	// METHOD TO HANDLE & PERFORM BIOMETRIC AUTHENTICATIONS
	func authenticate() {
		// CREATE A NEW 'LAContext' NSOBJECT CLASS INSTANCE
		/// 'LAContext' NSObject Class - A mechanism for evaluating authentication policies and access controls
		let context = LAContext()
		
		// A PROPERTY TO STORE OPTIONAL OBJ-C 'NSError' CLASS OBJECT
		var error: NSError?
		
		
		// CHECK WHETHER BIOMETRIC AUTHENTICATION IS AVAILABLE ON THE DEVICE
		/// 'LAPolicy' ENUM - the set of available "Local Authentication" policies
		/// '.deviceOwnerAuthenticationWithBiometrics' IS A CASE OF 'LAPolicy' ENUM
		/// '&' PASS THE 'NSError' CLASS OBJECT DIRECTLY INTO THE FUNCTION & ALLOWS IT TO CHANGE INSIDE THE FUNCTION
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			// IF BIOMETRIC AUTHENTICATION IS AVAILABLE ON THE DEVICE:
			
			/// SET 'localizedReason' STRING VALUE
			let reason = "Unlock user Data"
			
			// START BIOMETRIC AUTHENTICATION REQUEST PROCESS
			///  'localizedReason' STRING VALUE IS SHOWN TO THE USER AS THE REASON TO AUTHENTICATE
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				
				// COMPLETION CLOSURE
				/// CALLED WHENEVER AN AUTHENTICATION PROCESS IS DONE (SUCCESS/FAIL)
				if success {
					/// IF BIOMETRIC AUTHENTICATION IS SUCCESSFUL
					isAuthenticated = true
				} else {
					/// IF BIOMETRIC AUTHENTICATION FAILS
					isAuthenticated = false
					failedAuth = true
				}
			}
			
		} else {
			// BIOMETRIC AUTHENTICATION NOT POSSIBLE ON DEVICE
			/// POSSIBLE REASONS;
			/// - DEVICE HAVE NO 'Face ID' OR 'Touch ID' CAPABILITIES,
			/// - USER HAS NOT ENROLL THEIR BIOMETRIC DATA
		}
	}
}
