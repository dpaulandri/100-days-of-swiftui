//
//  ListView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI

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
