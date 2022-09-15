//
//  ContentView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI
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

struct ContentView: View {
	// GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
	// ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
	@Environment(\.managedObjectContext) var moc
	
	// STATE PROPERTY TO STORE WHETHER THE BIOMETRIC AUTHENTICATION IS SUCCESSFUL
	@State private var isAuthenticated = false
	@State private var failedAuth = false
	
	@State private var showAddView = false
	
	var body: some View {
		VStack {
			if isAuthenticated {
				NavigationView {
					ListView()
						.navigationTitle("iMetYou")
						.navigationBarTitleDisplayMode(.inline)
						.toolbar {
							// ADD PERSON BUTTON
							ToolbarItem(placement: .primaryAction) {
								Button {
									showAddView = true
								} label: {
									Image(systemName: "person.crop.circle.badge.plus")
										.frame(width: 44, height: 44)
								}
								.accessibilityElement()
								.accessibilityLabel("Add New Person")
								.accessibilityAddTraits(.isButton)
							}
						}
						.sheet(isPresented: $showAddView) {
							AddNewPersonView()
						}
				}
			} else {
				NavigationView {
					VStack {
						Spacer()
						Text("Data locked")
						Spacer()
						// BUTTON VIEW TO START APP UNLOCK USING BIOMERTIC AUTHENTICATION
						Button {
							// CALL THE VIEW MODEL'S 'authenticate' METHOD
							authenticate()
						} label: {
							Label("Unlock App", systemImage: "faceid")
								.labelStyle(.titleAndIcon)
								.padding()
								.background(.ultraThickMaterial)
								.foregroundColor(.primary)
								.clipShape(Capsule())
								.shadow(radius: 5, x: 0, y: 5)
						}
					}
					.navigationTitle("iMetYou")
					.navigationBarTitleDisplayMode(.inline)
					.alert("Oops", isPresented: $failedAuth) {
						Button("Try Again") { authenticate() }
						Button("Dismiss", role: .cancel) { }
					} message: {
						Text("Authentication Failed!")
					}
				}
			}
		}
	}
}



// APP PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
