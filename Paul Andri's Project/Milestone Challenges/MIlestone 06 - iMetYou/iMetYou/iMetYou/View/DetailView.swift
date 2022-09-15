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
		try? moc.save()
		
		// STEP 3: DELETE ASSOCIATED PROFILE PICTURE
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
		try? FileManager.default.removeItem(at: url)
		
		// STEP 4: CALL DISMISS TO DISMISS THE CURRENT 'DetailView'
		dismiss()
	}
	
	func profilePicture(person: Person) -> Image {
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
		
		if let profilePicture = UIImage(contentsOfFile: url.path) {
			return Image(uiImage: profilePicture)
		} else { return Image(systemName: "person.crop.circle.fill") }
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
			profilePicture(person: person)
				.resizable()
				.scaledToFill()
				.clipShape(Circle())
				.frame(width: 250, height: 250)
				.padding(.bottom)
				.accessibilityElement()
				.accessibilityLabel("Profile Picture of \(person.fullName)")
				.accessibilityAddTraits(.isImage)
			
			// DETAIL SECTION
			Section {
				HStack {
					Text("Full Name")
						.fontWeight(.bold)
					Spacer()
					Text(person.fullName)
						.fontWeight(.semibold)
				}
				.accessibilityElement()
				.accessibilityLabel("Full name, \(person.fullName)")
				
				HStack {
					Text("Gender")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedGender)
						.fontWeight(.semibold)
				}
				.accessibilityElement()
				.accessibilityLabel("Gender, \(person.wrappedGender)")
				
				HStack {
					Text("Email")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedEmail)
						.fontWeight(.semibold)
				}
				.accessibilityElement()
				.accessibilityLabel("Email Address, \(person.wrappedEmail)")
				
				HStack {
					Text("Phone #")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedPhoneNumber)
						.fontWeight(.semibold)
				}
				.accessibilityElement()
				.accessibilityLabel("Phone number, \(person.wrappedPhoneNumber)")
				
				HStack {
					Text("First Met")
						.fontWeight(.bold)
					Spacer()
					Text(person.wrappedDate)
						.fontWeight(.semibold)
				}
				.accessibilityElement()
				.accessibilityLabel("First Met on \(person.wrappedDate)")
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
