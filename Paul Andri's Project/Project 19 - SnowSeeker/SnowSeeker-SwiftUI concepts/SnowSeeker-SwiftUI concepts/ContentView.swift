//
//  ContentView.swift
//  SnowSeeker-SwiftUI concepts
//
//  Created by Paul Andri on 10/25/2022.
//

import SwiftUI

// SIDE-BY-SIDE VIEW IN SWIFTUI
/*
struct ContentView: View {
	var body: some View {
		// 'NavigationView' Side-by-side-View (2 Views)
		/*
		NavigationView {
			/// This View will be the "main" View for all all iPhones (Portrait)
			Text("Hello, world!")
				.navigationTitle("Primary")
			
			/// This View will be the "main" View for all iPhones (Landscape), as well as all iPad (Portrait)
			/// The "Primary" View can be toggle by pressing its corresponding NavigationView button
			Text("Secondary")
		}
		*/
		
		// 'NavigationView' + 'NavigationLink' Side-by-side-View (2 Views)
		/*
		NavigationView {
			NavigationLink {
				/// This View will be the "main" View for all iPhones (Landscape), as well as all iPad (Portrait)
				Text("New Secondary")
			} label: {
				/// This 'NavigationLink 'label will be the "main" View for all iPhones (Portrait)
				Text("Hello, world!")
			}
				.navigationTitle("Primary")
			
			/// This View will NOT be shown, UNLESS the App is launched in Landscape orientation
			Text("Secondary")
		}
		*/
		
		// 'NavigationView' + 'NavigationLink' Side-by-side-View (3 Views / Folder-like Grouping)
		NavigationView {
			NavigationLink {
				/// This View will be the "main" View for all iPhones (Landscape), as well as all iPad (Portrait)
				Text("New Secondary")
			} label: {
				/// This 'NavigationLink 'label will be the "main" View for all iPhones (Portrait)
				Text("Hello, world!")
			}
				.navigationTitle("Primary")
			
			/// This View will NOT be shown, UNLESS the App is launched (Landscape)
			Text("Secondary")
			
			/// This View wil create a  Folder-like Grouping sidebar similar to those in Apple's iOS "Notes" app on iPad (Landscape)
			Text("Tertiary")
		}
	}
}
*/



// TRIGGER '.alert()' & '.sheet()' W/ OPTIONALS
/*
/// 'User' Object Struct, conforms to 'Identifiable' Protocol
struct User: Identifiable {
	var id = "Taylor Swift"
}

// SHEET VIEW W/ OPTIONALS
/*
struct ContentView: View {
	/// Property to track the state of selected user (Optional), default to 'nil'
	@State private var selectedUser: User? = nil
	
	var body: some View {
		Text("Hello, world!")
			.onTapGesture {
				selectedUser = User()
			}
			/// Sheet View is triggered when the 'selectedUser' Property has a value (not nil/Optional)
			.sheet(item: $selectedUser) { user in
				Text(user.id)
			}
	}
}
*/

// ALERT WINDOW W/ OPTIONALS
//
struct ContentView: View {
	/// Property to track the state of selected user (Optional), default to 'nil'
	@State private var selectedUser: User? = nil
	@State private var isShowingAlert = false
	
	var body: some View {
		Text("Hello, world!")
			.onTapGesture {
				selectedUser = User()
				isShowingAlert = true
			}
			/// Alert Window
			/// 'presenting: ' is the Optional value to check & present
			.alert("Welcome", isPresented: $isShowingAlert, presenting: selectedUser) { user in
				Button(user.id) { }
			}
	}
}
//
*/



// ALERT WINDOW & DISMISSAL BEHAVIOUR
/// All Button shown on an Alert window, regardless of their actions, dismisses the Alert window it belong when tapped.
/*
struct ContentView: View {
	@State private var isShowingAlert = false
	
	var body: some View {
		Text("Hello, world!")
			.onTapGesture {
				isShowingAlert = true
			}
			/// This Alert window will show an "OK" button to dismiss the Alert itself
			.alert("Welcome", isPresented: $isShowingAlert) { }
	}
}
*/



// USING 'Group' AS "TRANSPARENT" LAYOUT CONTAINER
/// 'Group' doesn’t affect our Layout, but gives us the ability to add SwiftUI Modifiers as needed, or send back multiple Views without using '@ViewBuilder'
/*
// 'UserView' Struct
struct UserView: View {
	var body: some View {
		// 'Group' functioning as a single transparent Layout container (DOESN'T affect the Layout)
		Group {
			Text("Name: Paul")
			Text("Country: Unknown")
			Text("Pets: Myself?")
		}
		/// This one-line syntax apply Font modifier to all the 'Group's Child View
		.font(.title)
	}
}

// MAIN 'ContentView'
struct ContentView: View {
	@State private var layoutVertically = false
	
	var body: some View {
		// 'Group' functioning as a single transparent Layout container (DOESN'T affect the Layout)
		Group {
			if layoutVertically {
				VStack {
					/// 'UserView' presented in a VStack
					UserView()
				}
			} else {
				HStack {
					/// 'UserView' presented in a HStack
					UserView()
				}
			}
		}
		.onTapGesture {
			layoutVertically.toggle()
		}
	}
}
*/



// VIEW LAYOUT W/ 'SizeClass' ENVIRONMENT VALUE
/// "SizeClass' - a thoroughly vague way of telling us how much space we have for our Views.
///Available size classes: '.compact' & '.regular'
/*
// 'UserView' Struct
struct UserView: View {
	var body: some View {
		// 'Group' functioning as a single transparent Layout container (DOESN'T affect the Layout)
		Group {
			Text("Name: Paul")
			Text("Country: Unknown")
			Text("Pets: Myself?")
		}
		/// This one-line syntax apply Font modifier to all the 'Group's Child View
		.font(.title)
	}
}

// MAIN 'ContentView'
struct ContentView: View {
	@Environment(\.horizontalSizeClass) var sizeClass
	
	var body: some View {
		// OG Codes
		/*
		if sizeClass == .compact {
			VStack {
				UserView()
			}
		} else {
			HStack {
				UserView()
			}
		}
		*/
		
		// Refactored Codes
		if sizeClass == .compact {
			VStack(content: UserView.init)
		} else {
			HStack(content: UserView.init)
		}
	}
}
*/



// MAKE A SwiftUI VIEW SEARCHABLE W/ '.searchable()'
/// Binds a User-input 'String' property into '.searchable()' to filter app Data
//
// BASIC SEARCHABLE CONCEPT
/*
struct ContentView: View {
	/// State property to hold the user input "Search" String value
	@State private var searchText = ""
	
	var body: some View {
		// IMPORTANT: '.searchable()' VIEW NEED TO BE INSIDE A 'NavigationView' TO ALLOW ITS SEARCH BAR PLACEMENT
		NavigationView {
			Text("Searching for \(searchText)")
				.searchable(text: $searchText, prompt: "Search for ...")
				.navigationTitle("Searching")
		}
	}
}
*/

// SEARCHABLE LIST
struct ContentView: View {
	/// State property to hold the user input "Search" String value
	@State private var searchText = ""
	
	/// Data to be filtered
	let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
	
	var body: some View {
		// IMPORTANT: '.searchable()' VIEW NEED TO BE INSIDE A 'NavigationView' TO ALLOW ITS SEARCH BAR PLACEMENT
		NavigationView {
			/// List View using the computed [String] value of 'filteredNames'
			List(filteredNames, id: \.self) { name in
				Text(name)
			}
			.searchable(text: $searchText, prompt: "Look for")
			.navigationTitle("Search")
		}
	}
	
	// Computed Property - Filtering the 'allNames' property w/ 'searchText' value
	var filteredNames: [String] {
		if searchText.isEmpty {
			return allNames
		} else {
			// CASE SENSITIVE SEARCH
			///return allNames.filter { $0.contains(searchText) }
			
			// CASE INSENSITIVE SEARCH
			return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
		}
	}
}
//
//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
