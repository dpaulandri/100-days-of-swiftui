//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Paul Andri on 09/23/2022.
//

import SwiftUI

struct ContentView: View {
	// CREATE AN INSTANCE OF 'Prospects' CLASS AS A '@StateObject'
	@StateObject var prospects = Prospects()
	
	
    var body: some View {
		TabView {
			ProspectsView(filter: .none)
				.tabItem {
					Label("Everyone", systemImage: "person.crop.rectangle.stack.fill")
				}
			
			ProspectsView(filter: .contacted)
				.tabItem {
					Label("Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
				}
			
			ProspectsView(filter: .uncontacted)
				.tabItem {
					Label("Uncontacted", systemImage: "person.crop.circle.badge.questionmark.fill")
				}
			
			MeView()
				.tabItem {
					Label("Me", systemImage: "person.fill")
				}
		}
		// INJECT THE 'prospects' STATE OBJECT PROPERTY INTO TABVIEW'S ENVIRONMENT
		/// AVAILABLE TO ALL TABVIEW'S CHILD VIEWS
		.environmentObject(prospects)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
