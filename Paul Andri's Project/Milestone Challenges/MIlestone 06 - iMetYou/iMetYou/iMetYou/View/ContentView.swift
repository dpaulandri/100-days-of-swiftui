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
	
	@State private var showAddView = false
	
    var body: some View {
		NavigationView {
			ListView()
			.navigationTitle("iMetYou")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						showAddView = true
					} label: {
						Image(systemName: "person.crop.circle.badge.plus")
							.frame(width: 44, height: 44)
							.accessibilityElement()
							.accessibilityLabel("Add New Person")
							.accessibilityAddTraits(.isButton)
					}
				}
			}
			.sheet(isPresented: $showAddView) {
				AddNewPersonView()
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
