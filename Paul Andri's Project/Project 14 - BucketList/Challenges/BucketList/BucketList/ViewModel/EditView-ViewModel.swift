//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Paul Andri on 08/26/2022.
//
// PART OF DAY 73 - CHALLENGE #3 - CREATE VIEWMODEL FOR 'EditView'

import Foundation

extension EditView {
	// 'ViewModel' CLASS TO MANAGE & MANIPULATE DATA ON BEHALF OF 'EditView' STRUCT
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
		// ENUM FOR TRACKING APP NETWORK DATA FETCHING/LOADING STATES
		enum LoadingState {
			case loading, loaded, failed
		}
		
		// PROPERTY FOR 'Location' OBJECT DATA
		var location: Location
		
		// PUBLISHED PROPERTY TO STORE NEW USER INPUT VALUES
		@Published var name: String
		@Published var description: String
		
		// PUBLISHED PROPERTY TO STORE CURRENT APP NETWORK DATA FETCHING/LOADING STATE
		/// CURRENTLY LOADING
		@Published var loadingState = LoadingState.loading
		
		// PUBLISHED PROPERTY TO STORE AN ARRAY OF FETCHED 'Page' OBJECT DATA FROM WIKIPEDIA API
		/// VALUE WILL BE LOADED FROM THE CUSTOM 'init' INITIALIZER ON APP LOAD
		/// 'private(set)' ENSURE THAT ONLY THIS CLASS CAN SET (WRITE) VALUE TO THIS PROPERTY
		@Published private(set) var pages = [Page]()
		
		
		// CUSTOM INITIALIZER THAT ACCEPT 'Location' OBJECT DATA
		init(location: Location) {
			// COPY THE PASSED-IN 'location' DATA OBJECT
			self.location = location
			
			// CREATE NEW PUBLISHED STRUCTS USING THE 'name' & 'description' PROPERTIES
			// '_' PASSES THE STATE INITIAL VALUE DIRECTLY THE STATE PROPERTY TO USE
			/// ALLOWS CREATING INSTANCES OF THE 'State' PROPERTY WRAPPER, NOT THE DATA INSIDE THE WRAPPER
			_name = Published(initialValue: location.name)
			_description = Published(initialValue: location.description)
		}
		
		
		// 'async' METHOD TO FETCH NEARBY PLACES BY MAKING NETWORK CALL TO WIKIPEDIA API
		func fetchNearby(location: Location) async {
			// SET URL STRING FOR WIKIPEDIA API NETWORK CALL
			/// CREDIT TO PAUL HUDSON - 'bit.ly/swiftwiki'
			let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
			
			// TRY TO UNWRAP NETWORK CALL URL
			guard let url = URL(string: urlString) else {
				/// PRINT MESSAGE & EXIT METHOD IF FAIL
				print("Bad URL: \(urlString)")
				return
			}
			
			// DO BLOCK TO PERFORM NETWORK CALL & DATA PROCESSING
			do {
				/// TRY TO GET DATA USING 'URLSession' FROM 'url'
				let (data, _) = try await URLSession.shared.data(from: url)
				
				/// TRY TO DECODE THE RECEIVED JSON 'data' AS 'Result' OBJECT TYPE
				let items = try JSONDecoder().decode(Result.self, from: data)
				
				/// SAVE THE DECODED 'Result' OBJECT DATA INTO 'pages' STATE PROPERTY
				/// ASCENDING SORTED BY PAGE'S 'title' VALUE (REF. 'Page' DATA OBJECT STRUCT)
				pages = items.query.pages.values.sorted()
				
				/// SET APP 'loadingState' TO 'loaded' STATE
				loadingState = .loaded
			} catch {
				/// IF ANY 'try' FUNCTION FAILED INSIDE THE DO BLOCK;
				/// SET APP 'loadingState' TO 'failed' STATE
				loadingState = .failed
			}
			
		}
		
		
		// METHOD TO UPDATE EXISTING 'Location' OBJECT DATA
		func updateLocation() -> Location {
			/// 1. MAKE A NEW COPY OF 'Location' DATA OBJECT FROM THE ORIGINAL 'location' PROPERTY DATA
			/// By taking a variable copy of the original location, we get access to its existing data – it’s identifier, latitude, and longitude.
			var newLocation = location
			
			/// 2. ASSIGN A NEW 'UUID' IDENTIFIER FOR THE NEW 'Location' DATA OBJECT
			///  THIS WILL FORCE SWIFTUI TO REDRAW THE VIEW ON EACH SAVE BUTTON PRESSED,
			///  BECAUSE THE OBJECT IS NOW TREATED AS A NEW 'Location' OBJECT BECAUSE OF A NEW UUID
			newLocation.id = UUID()
			
			/// 3. ASSIGN NEW USER INPUT VALUES STORED IN THE STATE PROPERTIES AS ITS NEW PROPERTY VALUES
			newLocation.name = name
			newLocation.description = description
			
			/// 4. RETURN THE NEW LOCATION OBJECT DATA
			return newLocation
		}
	}
}
