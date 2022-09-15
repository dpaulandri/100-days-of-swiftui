//
//  DetailView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI

extension DetailView {
	// METHOD TO DELETE PERSON DATA FROM COREDATA PERSISTENT STORAGE & DISMISS 'DetailView' BACK TO ITS PREVIOUS VIEW
	func deletePerson() {
		// STEP 1: DELETE THE CURRENT PERSON DATA SHOWN ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
		moc.delete(person)
		
		// STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
		//try? moc.save()
		
		// STEP 3: CALL DISMISS TO DISMISS THE CURRENT 'DetailView'
		dismiss()
	}
}

struct DetailView: View {
	// PERSON PROPERTY
	let person: Person
	
	// GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
	// ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
	@Environment(\.managedObjectContext) var moc
	
	// ENVIRONMENT PROPERTY TO DISMISS 'DetailView'
	@Environment(\.dismiss) var dismiss
	
	// STATE PROPERTY SHOW BOOK PERSON DELETE CONFIRMATION ALERT WINDOW
	@State private var showDeleteAlert = false
	
	var body: some View {
		VStack {
			Image(systemName: "person.crop.circle.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 200, height: 200)
				.clipShape(Circle())
				.padding(.bottom)
			
			// DETAIL SECTION
			Section {
				HStack {
					Text("Full Name")
						.fontWeight(.bold)
					Spacer()
					Text(person.fullName)
						.fontWeight(.semibold)
				}
				
				HStack {
					Text("Gender")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedGender)
						.fontWeight(.semibold)
				}
				
				HStack {
					Text("Email")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedEmail)
						.fontWeight(.semibold)
				}
				
				HStack {
					Text("Phone #")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedPhoneNumber)
						.fontWeight(.semibold)
				}
				
				HStack {
					Text("First Met")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedDate)
						.fontWeight(.semibold)
				}
			}
			
			Spacer()
		}
		.padding(.horizontal, 20)
		.navigationTitle(person.fullName)
		// PERSON DELETE CONFIRMATION ALERT
		.alert("Delete Person", isPresented: $showDeleteAlert) {
			// BUTTON TO CONFIRM BOOK REVIEW DELETION, CALL 'deleteReview' METHOD
			Button("Delete", role: .destructive, action: deletePerson)
			// BUTTON TO CANCEL BOOK REVIEW DELETION & DISMISS THE ALERT WINDOW
			Button("Cancel", role: .cancel) { }
		} message: {
			Text("Are you sure?")
		}
		
		// TOOLBAR
		.toolbar {
			// BUTTON TO START THE PERSON DELETION PROCESS
			Button {
				// ASSIGN 'true' TO 'showDeleteAlert' BOOL STATE
				showDeleteAlert = true
			} label: {
				Label("Delete this person", systemImage: "trash")
			}
		}
	}
}



// APP PREVIEW
struct DetailView_Previews: PreviewProvider {
	// PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
	static let person = Person()
	
    static var previews: some View {
        DetailView(person: person)
    }
}
