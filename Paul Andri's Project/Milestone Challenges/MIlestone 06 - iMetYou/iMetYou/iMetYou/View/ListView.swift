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
			
			// STEP 1B:
			// DELETE THAT PERSON DATA ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
			moc.delete(person)
		}
		
		// STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
		//try? moc.save()
		
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
		List {
			ForEach(persons) { person in
				// NAVIGATION LINK TO THE CORRESPONDING 'UserDetailsView'
				NavigationLink {
					DetailView(person: person)
				} label: {
					HStack {
						Image(systemName: "person.crop.circle.fill")
							.font(.system(size: 44))
							.clipShape(Circle())
						Text(person.fullName)
							.lineLimit(1)
							.truncationMode(.tail)
					}
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



// APP PREVIEW
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
