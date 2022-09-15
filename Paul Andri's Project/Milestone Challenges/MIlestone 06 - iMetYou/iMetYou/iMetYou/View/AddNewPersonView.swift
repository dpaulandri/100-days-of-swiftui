//
//  AddNewPersonView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI

extension AddNewPersonView {
	// METHOD TO LOAD USER SELECTED IMAGE
	func loadImage() {
		// TRY TO GET THE INPUT IMAGE FROM 'inputImage' STATE PROPERTY, EXIT IF FAIL
		guard let inputImage = inputImage else { return }
		
		// CREATE AN 'Image' USING 'uiImage' VALUE AND SET THE VALUE TO 'image' STATE PROPERTY
		image = Image(uiImage: inputImage)
	}
	
	// METHOD TO SAVE USER SELECTED IMAGE TO DOCUMENTSDIRECTORY
	func saveImage(person: Person) {
		// TRY TO GET THE INPUT IMAGE FROM 'inputImage' STATE PROPERTY, EXIT IF FAIL
		guard let inputImage = inputImage else { return }
		
		// FILENAME CORRESPONDS TO THE PERSON UUID
		let url = FileManager.documentsDirectory.appendingPathComponent(person.wrappedID)
		
		if let jpegData = inputImage.jpegData(compressionQuality: 0.6)
		{
			try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
		}
	}
	
	// METHOD TO CHECK FOR PERSON DETAIL INPUT VALIDITY
	func inputDetailValid() -> Bool {
		if firstName.isEmpty || lastName.isEmpty || email.isEmpty || email.count < 5 || !email.contains("@") || !email.contains(".") || phoneNumber.isEmpty {
			return false
		} else { return true }
	}
}

struct AddNewPersonView: View {
	// GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
	// ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
	@Environment(\.managedObjectContext) var moc
	
	// ENVIRONMENT PROPERTY TO DISMISS 'AddReviewView' AFTER THE USER PRESSED THE 'Save' BUTTON
	@Environment(\.dismiss) var dismiss
	
	// IMAGE PROPERTIES:
	/// STATE PROPERTY FOR STORING OPTIONAL 'Image' DATA
	@State private var image: Image?
	/// STATE PROPERTY TO STORE USER SELECTED PICTURE AS FILTER INPUT IMAGE
	@State private var inputImage: UIImage?
	
	@State private var firstName = ""
	@State private var lastName = ""
	@State private var email = ""
	@State private var phoneNumber = ""
	@State private var gender = "Male"
	@State private var date = Date.now
	
	let availableGender = ["Male", "Female", "Others"]
	
	// FOCUS STATE TO DISMISS 'phoneNumber' TEXTFIELD PHONE PAD INPUT
	@FocusState private var textFieldIsFocused: Bool
	
	// STATE PROPERTY TO TRACK WHETHER 'PHPickerView' IS CURRENTLY SHOWN
	@State private var showingImagePicker = false
	
    var body: some View {
		NavigationView {
			VStack {
				// VSTACK VIEW FOR PROFILE PICTURE
				VStack {
					ZStack {
						// RECTANGLE AS BACKGROUND CANVA
						Image(systemName: "person.crop.circle.fill.badge.plus")
							.foregroundColor(.secondary)
							.scaledToFill()
							.font(.system(size: 150))
						
						// DRAW 'image' IF IT HAS AN 'Image' VALUE
						image?
							.resizable()
							.scaledToFill()
							.frame(width: 250, height: 250)
							.clipShape(Circle())
					}
					if image == nil { Text("Add Profile Picture") }
				}
				.accessibilityElement()
				.accessibilityLabel("Profile Picture")
				.accessibilityHint((image == nil ? "No Image selected, Tap to select" : "Image selected, Tap to replace"))
				.accessibilityAddTraits(image == nil ? .isButton : [.isImage, .isButton])
				// ZSTACK MODIFIER
				// ONTAPGESTURE TO TRIGGER IMAGE PICKER
				.onTapGesture {
					// SET 'showingImagePicker' PROPERTY STATE TO 'true' ON TAP
					/// TRIGGERS IMAGE PICKER
					showingImagePicker = true
				}
				// ONCHANGE MODIFIER;
				/// WATCH FOR ANY VALUE CHANGES IN 'inputImage' STATE PROPERTY
				/// CALL 'loadImage()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
				/// '_ in' - IGNORE THE INPUT
				.onChange(of: inputImage) { _ in loadImage() }
				// SHEET VIEW BINDED TO 'showingImagePicker' PROPERTY STATE
				.sheet(isPresented: $showingImagePicker) {
					// CREATE AN 'ImagePicker' STRUCT INSTANCE FOR 'PHPickerViewController'
					ImagePicker(image: $inputImage)
				}
				
				Spacer()
				Spacer()
				
				// USER INPUT FORM VIEW
				Form {
					Section("Details") {
						TextField("First Name", text: $firstName)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.words)
							.focused($textFieldIsFocused)
							.accessibilityHint("TextField Input (Data Required)")
						TextField("Last Name", text: $lastName)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.words)
							.focused($textFieldIsFocused)
							.accessibilityHint("TextField Input (Data Required)")
						TextField("Email Address", text: $email)
							.keyboardType(.emailAddress)
							.autocorrectionDisabled()
							.textInputAutocapitalization(.never)
							.focused($textFieldIsFocused)
							.accessibilityHint("TextField Input (Data Required)")
						TextField("Phone Number", text: $phoneNumber)
							.keyboardType(.phonePad)
							.focused($textFieldIsFocused)
							.accessibilityElement()
							.accessibilityHint("Phone Number Input (Data Required)")
						Picker("Gender", selection: $gender) {
							ForEach(availableGender, id: \.self) {
								Text($0)
							}
						}
						.accessibilityElement()
						.accessibilityLabel("Gender Picker Input")
						.accessibilityHint("\(gender) is currently selected")
						DatePicker("First Met", selection: $date, displayedComponents: .date)
							.accessibilityElement()
							.accessibilityLabel("Date Picker Input")
							.accessibilityHint("Currently set to \(date.formatted(date: .complete, time: .omitted))")
							
					}
				}
				
			}
			.toolbar {
				// SAVE NEW PERSON DATA BUTTON
				ToolbarItem(placement: .primaryAction) {
					// BUTTON TO SAVE NEW PERSON
					Button {
						// ADD METHOD
						// CREATE A NEW 'Person' DATA MODEL INSTANCE TO STORE NEW PERSON DATA
						// ASSIGN SWIFTUI ENVIRONMENT'S MOC "LIVE" DATA AS THE CONTEXT FOR THE DATA MODEL
						let newPerson = Person(context: moc)
						
						// ASSIGN DATA VALUES TO 'newPerson' FROM THE CROSSEPONDING STATE PROPERTIES
						newPerson.id = UUID()
						newPerson.firstName = firstName
						newPerson.lastName = lastName
						newPerson.email = email
						newPerson.phoneNumber = phoneNumber
						newPerson.gender = gender
						newPerson.date = date
						
						// CALL SAVEIMAGE METHOD
						saveImage(person: newPerson)
						
						// TRY TO SAVE THE "LIVE" DATA STORED FROM SWIFTUI ENVIRONMENT'S MOC INTO COREDATA'S PERSISTENT STORAGE
						try? moc.save()
						
						// CALL ENVIRONMENT 'dismiss' PROPERTY
						dismiss()
					} label: {
						Image(systemName: "plus")
					}
					.disabled(!inputDetailValid())
				}
				
				// DISMISS SHEET VIEW BUTTON
				ToolbarItem(placement: .cancellationAction) {
					// BUTTON TO DISMISS 'AddReviewView'
					Button {
						// CALL ENVIRONMENT 'dismiss' PROPERTY
						dismiss()
					} label: {
						Image(systemName: "arrow.down.forward.and.arrow.up.backward")
					}
					.accessibilityElement()
					.accessibilityLabel("Dismiss Add New Person View")
					.accessibilityAddTraits(.isButton)
				}
				
				// DISMISS KEYBOARD INPUT FOCUS
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					
					Button("Done") {
						textFieldIsFocused = false
					}
				}
					
			}
		}
    }
}



// APP PREVIEW
struct AddNewPersonView_Previews: PreviewProvider {
    static var previews: some View {
		AddNewPersonView()
    }
}
