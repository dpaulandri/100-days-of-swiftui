//
//  ContentView.swift
//  BucketList-SwiftUI concepts
//
//  Created by Paul Andri on 08/21/2022.
//

import SwiftUI


// DAY 68 MATERIALS
/*
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
/*
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
*/
*/



// DAY 69 MATERIALS
//
// INTEGRATING 'MapKit' W/ SWIFTUI
/*
// IMPORT 'MapKit' FRAMEWORK MODULE
import MapKit

// 'Location' DATA TYPE STRUCT
/// NEED TO CONFORMS TO 'Identifiable' PROTOCOL TO BE USED AS MAP MARKER
struct Location: Identifiable {
	let id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
	// STATE PROPERTY TO STORE 'MKCoordinateRegion' DATA;
	/// SAMPLE 'MKCoordinateRegion' VALUE POINTS TO THE CITY OF LONDON, UK
	/// 'MKCoordinateRegion' Type - a dedicated 'MapKit' data type that stores the map’s current centre Coordinate and zoom level
	/// 'center' - Map's centre point  (pinpoint)   |   'span' - Map's zoom level
	/// 'CLLocationCoordinate2D' - data type that stores Latitude & Longitude (map coordinate) values
	/// 'MKCoordinateSpan' - data type that stores the Width & Height of a map region
	@State private var mapRegion = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
		span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
	)
	
	// PROPERTY STORING AN ARRAY OF 'Location' DATA OBJECT
	let locations = [
		Location(
			name: "Buckingham Palace",
			coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
		Location(
			name: "Tower of London",
			coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
	]
	
	
	var body: some View {
		// SIMPLE MAP VIEW W/ ANNOTATION FUNCTIONS
		/*
		// MAP VIEW BOUNDED TO 'mapRegion' STATE PROPERTY VALUE,
		/// ALLOWING 'MKCoordinateRegion' VALUE UPDATE AS THE USER INTERACTS W/ THE MAP VIEW
		/// 'annotationItems' VALUE IS USED FOR ADDING VISIBILE ANNOTATION ON THE MAP VIEW
		Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
			// 'MapMarker' - "BALLOON" MAP VIEW ANNOTATION FUNCTION
			///MapMarker(coordinate: location.coordinate)
			
			// 'MapAnnotation' - CUSTOMISABLE MAP VIEW ANNOTATION FUNCTION
			/// ACCEPTS ANY KIND OF SWIFTUI VIEW
			MapAnnotation(coordinate: location.coordinate) {
				/// CUSTOM VIEW AS MAP ANNOTATION - EX1
				/*
				Circle()
					.stroke(.red, lineWidth: 3)
					.frame(width: 44, height: 44)
				*/
				
				/// CUSTOM VIEW AS MAP ANNOTATION - EX2
				Circle()
					.stroke(.red, lineWidth: 3)
					.frame(width: 44, height: 44)
					.onTapGesture {
						print("\"\(location.name)\" was tapped")
					}
				
				/// CUSTOM VIEW AS MAP ANNOTATION - EX3
				/*
				VStack {
					Circle()
						.stroke(.red, lineWidth: 3)
						.frame(width: 44, height: 44)
					
					Text(location.name)
				}
				*/
			}
		}
		*/
		
		// MAP VIEW W/ CUSTOM NAVIGATABLE ANNOTATION FUNCTION
		NavigationView {
			// MAP VIEW BOUNDED TO 'mapRegion' STATE PROPERTY VALUE,
			/// ALLOWING 'MKCoordinateRegion' VALUE UPDATE AS THE USER INTERACTS W/ THE MAP VIEW
			/// 'annotationItems' VALUE IS USED FOR ADDING VISIBILE ANNOTATION ON THE MAP VIEW
			Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
				// 'MapAnnotation' - CUSTOMISABLE MAP VIEW ANNOTATION FUNCTION
				/// ACCEPTS ANY KIND OF SWIFTUI VIEW
				MapAnnotation(coordinate: location.coordinate) {
					/// CUSTOM VIEW AS MAP ANNOTATION
					NavigationLink {
						/// NAVIGATE TO:
						Text(location.name)
					} label: {
						Circle()
							.stroke(.red, lineWidth: 3)
							.frame(width: 44, height: 44)
					}
				}
			}
			.navigationTitle("Visit UK")
		}
	}
	
}
*/



// 'LocalAuthentication' FRAMEWORK - An Objective-C API for biometric authentication
// 'Touch ID' & 'Face ID' IN SWIFTUI
//
// IMPORT 'LocalAuthentication' FRAMEWORK MODULE
import LocalAuthentication

struct ContentView: View {
	// STATE PROPERTY TO STORE WHETHER THE BIOMETRIC AUTHENTICATION IS SUCCESSFUL
	@State private var isAuthenticated = false
	
	
	var body: some View {
		VStack {
			// CONDITIONAL VIEW STATE DEPENDING ON 'isAuthenticated' PROPERTY STATE
			if isAuthenticated {
				NavigationView{
					ScrollView {
						VStack {
							Image("JamesBond")
								.frame(width: 400, height: 400)
							
							Spacer()
							
							VStack {
								HStack {
									Text("Status")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("⚫️ Inactive")
										.font(.title3)
										.fontWeight(.bold)
								}
								HStack {
									Text("Agent ID")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("007")
										.font(.title3)
								}
								HStack {
									Text("Agent Name")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("James Bond")
										.font(.title3)
								}
								HStack {
									Text("D.O.B.")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("11 November 1921")
										.font(.title3)
								}
								HStack {
									Text("Sex")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("Male")
										.font(.title3)
								}
								HStack {
									Text("Nationality")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("British")
										.font(.title3)
								}
								HStack {
									Text("Title")
										.font(.title3)
										.fontWeight(.bold)
									Spacer()
									Text("Commander (RNR)")
										.font(.title3)
								}
							}
							.padding()
							
							Spacer()
						}
					}
					.padding()
					.navigationTitle("Agent Data")
				}
			} else {
				Text("🔒 Content is locked 🔒")
			}
		}
		// ONAPPER MODIFIER TO CALL 'authenticate()' METHOD
		/// STARTS THE AUTHENTICATION PROCESS AS SOON AS THE VIEW APPEAR ON SCREEN
		.onAppear(perform: authenticate)
	}
	
	
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
//
//



// PREVIEWS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
