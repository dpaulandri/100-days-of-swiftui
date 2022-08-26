//
//  EditView.swift
//  BucketList
//
//  Created by Paul Andri on 08/24/2022.
//
// EDIT VIEW FOR EDITING LOCATION MARKER DATA
// SHOWN ON A SHEET VIEW
// PART OF DAY 73 - CHALLENGE #3 - CREATE VIEWMODEL FOR 'EditView'

import SwiftUI

struct EditView: View {
	/// ALL APP STATE PROPERTIES IS NOW PUBLISHED PROPERTIES IN 'EditView' EXTENSION'S 'ViewModel' CLASS
	// STATEOBJECT PROPERTY OF 'EditView's 'ViewModel' CLASS
	/// THIS STATEOBJECT PROPERTY IS USE IN PLACE OF ALL THE ORIGINAL APP STATE PROPERTIES
	@StateObject private var viewModel: ViewModel
	
	// FUNCTION PROPERTY
	/// ACCEPT  A 'Location' OBJECT DATA AND RETURNS NOTHING
	var onSave: (Location) -> Void
	
	// ENVIRONMENT PROPERTY FOR VIEW DISMISSAL
	@Environment(\.dismiss) var dismiss
	
	
    var body: some View {
		NavigationView {
			Form {
				// PLACE NAME & DESRICPTION TEXTFIELDS
				Section {
					TextField("Place Name", text: $viewModel.name)
					TextField("Description", text: $viewModel.description)
				}
				
				// "NEARBY" LIST
				Section("Nearby") {
					switch viewModel.loadingState {
					case .loading:
						Text("Loading data...")
						ProgressView()
					case .failed:
						Text("Unable to reach server. Please try again later.")
					default:
						/// IF NETWORK CALL TO WIKIPEDIA GET BACK RESULT;
						/// GENERATE DYNAMIC LIST FROM THE VIEW MODEL'S  'pages' PUBLISHEDPROPERTY
						ForEach(viewModel.pages, id: \.pageid) { page in
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
					/// 2CALL 'onSave()' FUNCTION W/ THE UPDATED LOCATION OBJECT  DATA
					/// GET UPDATED LOCATION OBJECT  DATA BBY CALLING THE VIEW MODEL'S 'updateLocation()' METHOD
					onSave(viewModel.updateLocation())
					
					/// DISMISS THE EDIT VIEW
					dismiss()
				}
			}
			// CALL 'async' METHOD USING '.task' MODIFIER
			.task {
				/// CALL THE VIEWMODEL'S ASYNC 'fetchNearby()' METHOD THAT MIGHT SLEEP ('await')
				await viewModel.fetchNearby(location: viewModel.location)
			}
		}
    }
	

	// CUSTOM INITIALIZER
	init(location: Location, onSave: @escaping (Location) -> Void) {
		// COPY THE PASSED-IN 'onSave' FUNCTION
		self.onSave = onSave
		
		// WRAP VIEW MODEL W/ PASSED LOCATION OBJECT DATA
		_viewModel = StateObject(wrappedValue: ViewModel(location: location))
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
