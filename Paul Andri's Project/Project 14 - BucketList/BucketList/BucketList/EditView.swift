//
//  EditView.swift
//  BucketList
//
//  Created by Paul Andri on 08/24/2022.
//
// EDIT VIEW FOR EDITING LOCATION MARKER DATA
// SHOWN ON A SHEET VIEW

import SwiftUI

struct EditView: View {
	// ENUM FOR TRACKING APP NETWORK DATA FETCHING/LOADING STATES
	enum LoadingState {
		case loading, loaded, failed
	}
	
	// ENVIRONMENT PROPERTY FOR VIEW DISMISSAL
	@Environment(\.dismiss) var dismiss
	
	// PROPERTY FOR 'Location' OBJECT DATA
	var location: Location
	
	// FUNCTION PROPERTY
	/// ACCEPT  A 'Location' OBJECT DATA AND RETURNS NOTHING
	var onSave: (Location) -> Void
	
	// STATE PROPERTY TO STORE NEW USER INPUT VALUES
	@State private var name: String
	@State private var description: String
	
	// STATE PROPERTY TO STORE CURRENT APP NETWORK DATA FETCHING/LOADING STATE
	/// CURRENTLY LOADING
	@State private var loadingState = LoadingState.loading
	
	// STATE PROPERTY TO STORE AN ARRAY OF FETCHED 'Page' OBJECT DATA FROM WIKIPEDIA API
	@State private var pages = [Page]()
	
	
    var body: some View {
		NavigationView {
			Form {
				// PLACE NAME & DESRICPTION TEXTFIELDS
				Section {
					TextField("Place Name", text: $name)
					TextField("Description", text: $description)
				}
				
				// "NEARBY" LIST
				Section("Nearby") {
					switch loadingState {
					case .loading:
						Text("Loading data...")
					case .failed:
						Text("""
						Unable to reach server.
						Please try again later.
						""")
					default:
						/// IF NETWORK CALL TO WIKIPEDIA GET BACK RESULT;
						/// GENERATE DYNAMIC LIST FROM 'pages' STATE PROPERTY
						ForEach(pages, id: \.pageid) { page in
							LazyVStack(alignment: .leading) {
								Text(page.title)
									.font(.headline)
									.lineLimit(1)
									.truncationMode(.tail)
								Text(page.description)
									.italic()
									.lineLimit(1)
									.truncationMode(.tail)
							}
						}
					}
				}
			}
			.navigationTitle("Place Details")
			.toolbar {
				Button("Save") {
					// CODES TO SAVE NEW 'Location' OBJECT DATA:
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
					
					/// 4. CALL 'onSave()' FUNCTION W/ THE 'newLocation' DATA VALUE
					onSave(newLocation)
					
					/// DISMISS THE EDIT VIEW
					dismiss()
				}
			}
			// CALL 'async' METHOD USING '.task' MODIFIER
			.task {
				/// CALL ASYNC 'fetchNearby()' METHOD THAT MIGHT SLEEP ('await')
				await fetchNearby()
			}
		}
    }
	
	// CUSTOM INITIALIZER THAT ACCEPT 'Location' OBJECT DATA & 'onSave' FUNCTION
	/// '@escaping' MEANT TO SAVE IT AND TO BE USED LATER
	init(location: Location, onSave: @escaping (Location) -> Void) {
		// COPY THE PASSED-IN 'location' DATA OBJECT & 'onSave' FUNCTION
		self.location = location
		self.onSave = onSave
		
		// CREATE NEW STATE STRUCTS USING THE 'name' & 'description' PROPERTIES
		// '_' PASSES THE STATE INITIAL VALUE DIRECTLY THE STATE PROPERTY TO USE
		/// ALLOWS CREATING INSTANCES OF THE 'State' PROPERTY WRAPPER, NOT THE DATA INSIDE THE WRAPPER
		_name = State(initialValue: location.name)
		_description = State(initialValue: location.description)
	}
	
	// 'async' METHOD TO FETCH NEARBY PLACES BY MAKING NETWORK CALL TO WIKIPEDIA API
	func fetchNearby() async {
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
	
}



// PREVIEW
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
		// PASS-IN THE 'Location' DATA OBJECT COMPUTED PROPERTY EXAMPLE DATA
		// '{ _ in }' - IGNORE THE 'onSave' FUNCTION VALUE
		EditView(location: Location.example) { _ in }
    }
}
