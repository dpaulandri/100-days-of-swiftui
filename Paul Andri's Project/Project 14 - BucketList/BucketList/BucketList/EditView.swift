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
	
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Place Name", text: $name)
					TextField("Description", text: $description)
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
}



// PREVIEW
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
		// PASS-IN THE 'Location' DATA OBJECT COMPUTED PROPERTY EXAMPLE DATA
		// '{ _ in }' - IGNORE THE 'onSave' FUNCTION VALUE
		EditView(location: Location.example) { _ in }
    }
}
