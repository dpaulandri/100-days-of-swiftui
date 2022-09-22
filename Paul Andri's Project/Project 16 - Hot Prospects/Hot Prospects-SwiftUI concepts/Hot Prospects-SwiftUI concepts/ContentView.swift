//
//  ContentView.swift
//  Hot Prospects-SwiftUI concepts
//
//  Created by Paul Andri on 09/20/2022.
//

import SwiftUI

// DAY 79 MATERIALS
/*
// READ CUSTOM VALUES FROM '@EnvironmentObject' - '.environmentObject()'
/*
// 'User' CLASS W/ MAIN ACTOR ATTRIBUTE, CONFORMS TO 'ObservableObject' PROTOCOL
@MainActor class User: ObservableObject {
	// PUBLISHED PROPERTY
	@Published var name = "Taylor Swift"
}

// EDIT VIEW STRUCT
struct EditView: View {
	// A 'User' CLASS TYPE ENVIRONMENT OBJECT PROPERTY
	/*
	 '@EnvironmentObject' property wrapper will automatically look for a 'User' instance in the environment,
	 and place whatever it finds into the user property.
	 If it can’t find a 'User' in the environment THE code will just crash.
	 
	 THIS DOES NOT CREATE A NEW 'User' INSTANCE,
	 This meant we're telling Swift that there'll be a 'User' in the Environment,
	 access & read it from the Environment.
	 */
	@EnvironmentObject var user: User
	
	var body: some View {
		// NAME USER INPUT TEXT VIEW, BOUND TO ENVIRONMENT OBJECT'S 'user.name' PROPERTY
		TextField("Name", text: $user.name)
	}
}

// DISPLAY VIEW STRUCT
struct DisplayView: View {
	// A 'User' CLASS TYPE ENVIRONMENT OBJECT PROPERTY
	/*
	 '@EnvironmentObject' property wrapper will automatically look for a 'User' instance in the environment,
	 and place whatever it finds into the user property.
	 If it can’t find a 'User' in the environment THE code will just crash.
	 
	 THIS DOES NOT CREATE A NEW 'User' INSTANCE,
	 This meant we're telling Swift that there'll be a 'User' in the Environment,
	 access & read it from the Environment.
	 */
	@EnvironmentObject var user: User
	
	var body: some View {
		// TEXT VIEW DISPLAYING ENVIRONMENT OBJECT'S 'user.name' PROPERTY STRING VALUE
		Text(user.name)
	}
}

// CONTENT VIEW
struct ContentView: View {
	// CREATE AN 'User' CLASS OBJECT INSTANCE 'StateObject'
	/*
	 Given that we are explicitly sharing our 'User' instance with other Views,
	 I would personally be inclined to remove the 'private' access control because it’s not accurate.
	*/
	@StateObject private var user = User()
	
	
    var body: some View {
		// ENVIRONMENT OBJECT ATTACHED TO ITS VIEW
		/*
		VStack {
			// CALL EDIT VIEW, BOUND TO THE 'user' STATE OBJECT VALUE FROM 'User' ENVIRONMENT OBJECT
			// SHARES THE SAME 'User' ENVIRONMENT OBJECT AS 'DisplayView'
			EditView().environmentObject(user)
			// CALL DISPLAY VIEW, READING FROM THE 'user' STATE OBJECT VALUE FROM 'User' ENVIRONMENT OBJECT
			// SHARES THE SAME 'User' ENVIRONMENT OBJECT AS 'EditView'
			DisplayView().environmentObject(user)
		}
		*/
		
		// ENVIRONMENT OBJECT ATTACHED TO VSTACK PARENT VIEW
		VStack {
			// CALL EDIT VIEW, BOUND TO THE 'user' STATE OBJECT VALUE FROM 'User' ENVIRONMENT OBJECT
			// SHARES THE SAME 'User' ENVIRONMENT OBJECT AS 'DisplayView'
			EditView()
			// CALL DISPLAY VIEW, READING FROM THE 'user' STATE OBJECT VALUE FROM 'User' ENVIRONMENT OBJECT
			// SHARES THE SAME 'User' ENVIRONMENT OBJECT AS 'EditView'
			DisplayView()
		}
		.environmentObject(user)
    }
}
*/



//  CREATING TABS W/ 'TabView' AND 'tabItem()'
/*
struct ContentView: View {
	// STATE PROPERTY TO TRACK THE CURRENTLY SELECTED/SHOWING TAB
	@State private var selectedTab = "One"
	
	var body: some View {
		// TIP:
		/*
		 It’s common to want to use 'NavigationView' and 'TabView' at the same time,
		 but you should be careful: 'TabView' should be the "Parent View",
		 with the "tabs" inside it having a 'NavigationView' as necessary,
		 rather than the other way around.
		 */
		
		// TAB VIEW, BOUND THE TAPVIEW SELECTION TO 'selectedTab' STATE PROPERTY VALUE
		TabView(selection: $selectedTab) {
			// TEXT VIEW FOR TAB VIEW #1
			Text("Tab 1")
				.onTapGesture {
					// CHANGE 'selectedTab' STATE PROPERTY VALUE ON TAP
					selectedTab = "Two"
				}
				.tabItem {
					Label("One", systemImage: "star")
				}
				// 'tag' MODIFIER; ATTACH AN UNIQUE IDENTIFIER TO A VIEW
				/// TO BE USE W/ TABVIEW SELECTION
				.tag("One")
			
			// TEXT VIEW FOR TAB VIEW #2
			Text("Tab 2")
				.tabItem {
					Label("Two", systemImage: "circle")
				}
				// 'tag' MODIFIER; ATTACH AN UNIQUE IDENTIFIER TO A VIEW
				/// TO BE USE W/ TABVIEW SELECTION
				.tag("Two")
		}
	}
}
*/

*/



// DAY 80 MATERIALS
/*
// MANUALLY PUBLISHING 'ObservableObject' CHANGES - 'objectWillChange' PROPERTY
/*
// MAINACTOR CLASS, CONFORMS TO 'ObservableObject' PROTOCOL
@MainActor class DelayedUpdater: ObservableObject {
	// PUBLISHED PROPERTY
	// PUBLISH 'ObservableObject' CHANGES AUTOMATICALLY
	// @Published var value = 0
	
	// PROPERTY W/ 'willSet' & ''objectWillChange' PUBLISHER
	// PUBLISH 'ObservableObject' CHANGES MANUALLY
	var value = 0 {
		// 'willSet' - Triggered BEFORE changes are made
		/// POSSIBLE TO ADD MORE CUSTOMISATION AT THE SAME TIME AS THE CHANGES ARE PUBLISHED
		willSet {
			// SEND/PUBLISH CHANGES NOTIFICATION
			objectWillChange.send()
		}
	}
	
	// CUSTOM INITIALIZER
	init() {
		// FOR LOOP W/ CLOSED RANGE INT VALUE
		for i in 1...10 {
			// 'DispatchQueue.main.asyncAfter()' - Run an attached Closure after a delay of our choosing
			DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
				self.value += 1
			}
		}
		// CODE BLOCK LOGIC:
		/// RUN FOR LOOP FOR 10 ITERATIONS (10 SECONDS)
		/// INCREASE 'value' PUBLISHED PROPERTY VALUE BY '1' FOR EACH LOOP ITERATION (EACH SECOND)
		/// FINAL VALUE FOR PUBLISHED PROPERTY 'value' WOULD BE '10'
	}
}


struct ContentView: View {
	// CREATE A 'StateObject' OF 'DelayedUpdater' CLASS INSTANCE
	@StateObject private var updater = DelayedUpdater()
	
	var body: some View {
		// TEXT VIEW W/ STRING INTERPOLATION OF THE STATE OBJECT'S 'value'
		Text("Value is \(updater.value)")
	}
}
*/



// SWIFT'S 'Result' TYPE - Result<String, Error>
/// A Swift's special Type that encapsulates either a "successful" 'String' value OR some kind of 'Error' Type in a single piece of Data
/*
struct ContentView: View {
	@State private var output = ""
	
	var body: some View {
		Text(output)
			.task {
				await fetchReadings()
			}
	}
	
	// METHOD TO FETCH REMOTE READINGS DATA
	func fetchReadings() async {
		// 'do' & 'catch' BLOCK METHOD
		/*
		do {
			let url = URL(string: "https://hws.dev/readings.json")!
			let (data, _) = try await URLSession.shared.data(from: url)
			let readings = try JSONDecoder().decode([Double].self, from: data)
			output = "Found \(readings.count) readings."
		} catch {
			print("Download error!")
		}
		*/
		
		// 'Task' & 'Result' METHOD
		// CREATE A NEW TASK OBJECT THAT ACCEPTS NO VALUE, RETURNS A 'String' VALUE
		// 'fetchTask' CAN BE PASS AROUND WHILE ITS RUNNING
		let fetchTask = Task { () -> String in
			let url = URL(string: "https://hws.dev/readings.json")!
			let (data, _) = try await URLSession.shared.data(from: url)
			let readings = try JSONDecoder().decode([Double].self, from: data)
			
			// RETURNS A 'String' VALUE
			// THE VALUE IS STASHED AWAY, ABLE TO BE REUSE AGAIN AT SOME POINT
			return "Found \(readings.count) readings."
		}
		
		// READ THE RESULT FROM 'fetchTask' TASK
		/// 'await' IS NEEDED IN ORDER TO WAIT FOR THE TASK TO FINISH RUNNING
		/// 'result' HOLDS EITHER A TASK SUCCESS 'String' VALUE OR AN 'Error' TYPE VALUE
		/// THE 'result' VALUE IS STASHED AWAY, ABLE TO BE REUSE AGAIN AT SOME POINT
		let result = await fetchTask.result
		
		
		// SET 'output' STATE PROPERTY VALUE
		// METHOD 1:  'do' & 'catch' BLOCK
		/*
		do {
			// TRY TO GET THE SUCCESS 'String' VALUE FROM 'result'
			output = try result.get()
		} catch {
			// PRINT THIS IF FAILED
			// print("Download Error")
			
			// SET A STRING VALUE W/ LOCALISED ERROR DESCRIPTION TO 'output' STATE PROPERTY
			output = "Error: \(error.localizedDescription)"
		}
		*/
		
		// METHOD 2: SWITCH STATEMENT
		switch result {
		case.success(let str):
			output = str
		case.failure(let error):
			output = "Error: \(error.localizedDescription)"
		}
	}
}
*/

 
 
// IMAGE INTERPOLATION IN SWIFTUI - '.interpolation()' MODIFIER
/// The 'interpolation()' modifier that lets us control how pixel blending is applied
/*
struct ContentView: View {
	var body: some View {
		Image("example")
			.interpolation(.none) // TURN OFF IMAGE INTERPOLATION
			.resizable()
			.scaledToFit()
			.frame(maxHeight: .infinity)
			.background(.blue)
			.ignoresSafeArea()
	}
}
*/

*/



// DAY 81 MATERIALS
//
// CONTEXT MENUS
/*
struct ContentView: View {
	@State private var backgroundColor = Color.red
	
	var body: some View {
		VStack {
			Text("Hello, World!")
				.padding()
				.background(backgroundColor)
			
			Text("Change Color")
				.padding()
				.contextMenu {
					Button(role: .destructive) {
						backgroundColor = .red
					} label: {
						Label("Red", systemImage: "checkmark.circle.fill")
					}
					
					Button("Yellow") {
						backgroundColor = .yellow
					}
					
					Button("Green") {
						backgroundColor = .green
					}
				}
		}
	}
}
*/



// ADD CUSTOM "ROW SWIPE ACTIONS" TO A LIST
/*
struct ContentView: View {
	var body: some View {
		List {
			Text("James Bond")
				// NORMAL SWIPE ACTION
				.swipeActions {
					Button {
						print("Hi")
					} label: {
						Label("Send message", systemImage: "message")
					}
				}
				// "DESTRUCTIVE" SWIPE ACTION BUTTON
				.swipeActions {
					/// "DESTRUCTIVE" BUTTON  (COLOURED RED)
					Button(role: .destructive) {
						print("Deleting")
					} label: {
						Label("Delete", systemImage: "minus.circle")
					}
				}
				// "LEADING" SWIPE ACTION BUTTON
				/// '(edge: .leading)' - PLACE THE SWIPE ACTION BUTTON ON THE LEADING EDGE OF THE ROW
				.swipeActions(edge: .leading) {
					Button {
						print("Pinning")
					} label: {
						Label("Pin", systemImage: "pin")
					}
					/// BUTTON'S COLOUR TINT MODIFIER
					.tint(.orange)
				}
		}
	}
}
*/



// SCHEDULING LOCAL NOTIFICATIONS
/// ???DOES NOT TRIGGER ON Xcode Simulator iOS 16???
/*
import UserNotifications

struct ContentView: View {
	var body: some View {
		VStack {
			Button("Request Permission") {
				// REQUEST USER NOTIFICATION PERMISSIONS FOR ALERT, BADGE(NUMBER OVER APP ICON) & SOUND
				UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						print("All Set!")
					} else if let error = error {
						print(error.localizedDescription)
					}
				}
			}
			
			Button("Schedule Notification") {
				// CREATE A NEW MUTABLE USER NOTIFICATION CONTENT
				let content = UNMutableNotificationContent()
				content.title = "Feed the cat"
				content.subtitle = "It looks hungry"
				content.sound = UNNotificationSound.default
				
				// CREATE A NEW USER NOTIFICATION TRIGGERER
				// TRIGGERER: SHOW NOTIFICATION 5SECS FROM NOW
				let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
				
				// CREATE A NEW USER NOTIFICATION PERMISSION REQUEST
				// ASSIGN A RANDOM STRING UUID FOR THE NOTIFICATION
				/// USE 'UUID().uuidString' If we don’t want to edit or remove stuff
				let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
				
				// ADD OUR NEW REQUEST TO THE CURRENT USER NOTIFICATION PERMISSION REQUEST
				UNUserNotificationCenter.current().add(request)
			}
		}
	}
}
*/



// SWIFT PACKAGE DEPENDENCIES & XCODE'S SWIFT PACKAGE MANAGER (SPM)
//
// IMPORT THE DEPENDENCY PACKAGE MODULE
import SamplePackage

struct ContentView: View {
	let possibleNumbers = Array(1...60)
	
	var body: some View {
		Text(results)
	}
	
	// COMPUTED PROPERTY OF A STRING TYPE
	var results: String {
		// SELECT 7 RANDOM INT NUMBERS FROM 'possibleNumbers' ARRAY INTO A SORTED INT ARRAY
		// THE 'random()' FUNCTION IS FROM THE IMPORTED 'SamplePackage' DEPENDENCY PACKAGE
		/// REF. THE DEPENENCY PACKAGE SWIFT FILE " SamplePackage.swift"
		let selected = possibleNumbers.random(7).sorted()

		// CONVERT THE SORTED INT ARRAY INTO AN ARRAY OF STRING VALUES
		/// 'Sequence' Type have a 'map()' method :
		/// Convert an Array of one Type into an Array of another Type by applying a function to each element
		let strings = selected.map(String.init)
		
		// RETURN A STRING VALUE BY JOINING THE ARRAY OF STRING VALUES TOGETHER W/ ", "
		return strings.joined(separator: ", ")
	}
}
//

//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
