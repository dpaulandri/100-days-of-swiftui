//
//  ContentView.swift
//  BucketList-SwiftUI concepts
//
//  Created by Paul Andri on 08/21/2022.
//

import SwiftUI


// DAY 68 MATERIALS

// CONFORMING "CUSTOM TYPES" TO 'Comparable' PROTOCOL
//
// 'User' CUSTOM DATA MODEL TYPE STRUCT, CONFORMS W/ 'Identifiable' & 'Comparable' PROTOCOLS
/*
struct User: Identifiable, Comparable {
	let id = UUID()
	let firstName: String
	let lastName: String
	
	// STATIC METHOD TO COMPARE TWO DIFFERENT 'User' DATA MODEL OBJECT, RETURNS 'Bool' VALUE
	// '<' - THE "LESS THAN" OPERATOR
	/// REQUIRED FOR 'Comparable' PROTOCOLS CONFORMANCE
	static func <(lhs: User,rhs: User) -> Bool {
		/// ASCENDING SORT BY 'lastName' PROPERTY VALUE
		lhs.lastName < rhs.lastName
	}
}

// CONTENT VIEW STRUCT
struct ContentView: View {
	// PROPERTY STORING AN ARRAY OF 'User' CUSTOM DATA TYPE
	let users = [
		User(firstName: "Arnold", lastName: "Rimmer"),
		User(firstName: "Kristine", lastName: "Kochanski"),
		User(firstName: "David", lastName: "Lister"),
	].sorted()
	/// DEFAULT SORTING WORKS BECAUSE 'User' CONFORMS TO 'Comparable' PROTOCOLS
	
    var body: some View {
		List(users) { user in
			Text("\(user.firstName) \(user.lastName)")
		}
    }
}
*/



// READ/WRITE DATA TO "DOCUMENTS DIRECTORY"
/// NO LIMIT TO THE AMOUNT OF DATA STORED IN APP'S "DOCUMENTS DIRECTORY"
/// DATA IN "DOCUMENTS DIRECTORY" AUTOMATICALLY GET SYNCED TO USER'S 'iCloud' STORAGE
/*
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
			.onTapGesture {
				// SET A STRING VALUE TO SAVE
				let str = "Test Message to write to App's \"Documents Directory\""
				
				// GET THE APP'S "DOCUMENTS DIRECTORY" PATH
				/// CALLS 'getDocumentsDirectory' METHOD
				/// '.appendingPathComponent("t")' - DEFINE URL DATA COMPONENT & ITS FILENAME
				let url = getDocumentsDirectory().appendingPathComponent("message.txt")
				
				do {
					// TRY TO WRITE 'str' DATA TO THE APP'S "DOCUMENTS DIRECTORY" PATH (FROM 'url')
					/*
					 'atomically';
					 Write all Data at once.
					 The system writes the full file to a temporary file,
					 then rename it to our target filename;
					 either the whole file is there or nothing.*/
					try str.write(to: url, atomically: true, encoding: .utf8)
					/*
					 'encoding' - CHARACTER ENCODING
					 'Objectice-C' uses 'UTF-16'
					 'Swift' uses 'UTF-8'
					*/
					
					
					// TRY TO READ THE SAVED 'String' DATA FROM THE SAME APP'S "DOCUMENTS DIRECTORY" PATH ('url')
					let input = try String(contentsOf: url)
					// PRINT OUT THE READ DATA
					print(input)
				} catch {
					// PRINT LOCALIZED ERROR MESSAGE IF ANYTHING GOES WRONG IN THE 'do' BLOCK
					print(error.localizedDescription)
				}
			}
	}
	
	
	// METHOD TO GET USER'S "DOCUMENTS DIRECTORY" PATH FOR OUR APP, RETURNS AN 'URL' VALUE
	func getDocumentsDirectory() -> URL {
		/// FIND ALL POSSIBLE "DOCUMENTS DIRECTORY" PATH FOR THE USER (SHOULD ONLY BE ONE)
		/// 'FileManager' is a Class
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		
		/// SEND BACK THE FIRST "DOCUMENTS DIRECTORY" PATH FOUND
		return paths[0]
	}
}
*/
 


// SWITCHING VIEW STATES W/ ENUMS
//
// ENUMS FOR APP LOADING STATES
enum LoadingState {
	case loading, success, failed
}

// APP LOADING VIEW STRUCT
struct LoadingView: View {
	var body: some View {
		Text("Loading...")
	}
}

// APP LOAD SUCCESS VIEW STRUCT
struct SuccessView: View {
	var body: some View {
		Text("Success!")
	}
}

// APP LOAD FAILED VIEW STRUCT
struct FailedView: View {
	var body: some View {
		Text("Failed!")
	}
}

// MAIN CONTENT VIEW STRUCT
/// ACTS AS SIMPLE VIEW LAYOUT & WRAPPER
struct ContentView: View {
	// PROPERTY STORING APP LOADING STATE FROM 'LoadingState' ENUM CASES
	var loadingState = LoadingState.loading
	
	var body: some View {
		// VIEW STATE SWITCHING BASED ON 'loadingState' PROPERTY'S 'LoadingState' ENUM CASE VALUE
		
		// IF-ELSE STATEMENT METHOD:
		/*
		if loadingState == .loading {
			LoadingView()
		} else if loadingState == .failed {
			FailedView()
		} else {
			SuccessView()
		}
		*/
		
		// CASE SWITCHING METHOD:
		switch loadingState {
		case .loading:
			LoadingView()
		case .failed:
			FailedView()
		default:
			SuccessView()
		}
	}
}
//

//




/*
//
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
	}
}
//

//
//
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
	}
}
//
*/



// PREVIEWS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
