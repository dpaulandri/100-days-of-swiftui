//
//  ListView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI

extension ListView {
	// METHOD TO DELETE PERSON DATA FROM COREDATA 'FetchRequest'
	func deletePerson(at offsets: IndexSet) {
		
		// STEP 1: FIND THE PERSON DATA INDEX & DELETE THE "LIVE" DATA FROM 'managedObjectContext' ON iDevice MEMORY
		// FOR LOOP TO LOOP OVER EVERY DATA INDEX FROM THE PASSED-IN 'offsets' COLLECTION
		for offset in offsets {
			
			// STEP 1A:
			// FIND THE PERSON DATA INDEX USING THE 'offset' INDEXSET ON 'persons' 'FetchRequest' PROPERTY DATA
			// DEFINE IT AS THE 'person' OBJECT
			let person = persons[offset]
			
			// STEP 1B: DELETE ASSOCIATED PROFILE PICTURE
			// FILENAME CORRESPONDS TO THE PERSON UUID
			let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
			try? FileManager.default.removeItem(at: url)
			
			// STEP 1C:
			// DELETE THAT PERSON DATA ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
			moc.delete(person)
		}
		
		// STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
		try? moc.save()
	}
	
	// METHOD TO LOAD PROFILE PICTURE FROM DOCUMENTS DIRECTORY
	func profilePicture(person: Person) -> Image {
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)

		if let profilePicture = UIImage(contentsOfFile: url.path) {
			return Image(uiImage: profilePicture)
		} else {
			return Image(systemName: "person.crop.circle.fill") }
	}
}

struct ListView: View {
	// ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
	@Environment(\.managedObjectContext) var moc
	
	// READ ANY EXISTING PERSON DATA ENTRY INSIDE THE 'Person' DATA MODEL
	// FETCH REQUEST PROPERTY THAT HAVE A 'Person' DATA MODEL RESULT 'FetchedResults' DATA TYPE
	@FetchRequest(sortDescriptors:[
		// SORT THE 'FetchedResults' DATA USING ITS 'firstName' ATTRIBUTE
		SortDescriptor(\.firstName)
	]) var persons: FetchedResults<Person>
	
	
	var body: some View {
		if persons.count == 0 {
			Text("No Data")
		} else {
			List {
				ForEach(persons) { person in
					// NAVIGATION LINK TO THE CORRESPONDING 'UserDetailsView'
					NavigationLink {
						DetailView(person: person)
					} label: {
						LazyHStack {
							profilePicture(person: person)
								.resizable()
								.scaledToFill()
								.frame(width: 65, height: 65)
								.clipShape(Circle())
							
							LazyVStack {
								Text(person.fullName)
									.font(.title3)
									.fontWeight(.medium)
								Text(person.wrappedEmail)
									.lineLimit(1)
									.truncationMode(.tail)
									.font(.subheadline)
							}
							.padding()
						}
						.accessibilityElement()
						.accessibilityLabel("\(person.fullName)")
						.accessibilityAddTraits(.isButton)
					}
				}
				.onDelete(perform: deletePerson)
			}
			.toolbar {
				// QUICK EDIT/DELETE BUTTON
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
			}
		}
	}
}



// APP PREVIEW
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
