//
//  ContentView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI

struct ContentView: View {
	// GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
	// ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
	@Environment(\.managedObjectContext) var moc
	
	// STATE PROPERTY TO STORE WHETHER THE BIOMETRIC AUTHENTICATION IS SUCCESSFUL
	@State var isAuthenticated = false
	@State var failedAuth = false
	
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
