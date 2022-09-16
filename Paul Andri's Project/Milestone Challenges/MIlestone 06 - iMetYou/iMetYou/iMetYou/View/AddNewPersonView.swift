//
//  AddNewPersonView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct AddNewPersonView: View {
	// GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
	// ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
	@Environment(\.managedObjectContext) var moc
	
	// ENVIRONMENT PROPERTY TO DISMISS 'AddReviewView' AFTER THE USER PRESSED THE 'Save' BUTTON
	@Environment(\.dismiss) var dismiss
	
	// IMAGE PROPERTIES:
	/// STATE PROPERTY FOR STORING OPTIONAL 'Image' DATA
	@State var image: Image?
	/// STATE PROPERTY TO STORE USER SELECTED PICTURE AS FILTER INPUT IMAGE
	@State var inputImage: UIImage?
	
	@State var firstName = ""
	@State var lastName = ""
	@State var email = ""
	@State var phoneNumber = ""
	@State var gender = "Male"
	@State var date = Date.now
	@State private var location: CLLocationCoordinate2D?
	
	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
	
	// USER LOCATION FETCHER CLASS INSTANCE
	let locationFetcher = LocationFetcher()
	
	let availableGender = ["Male", "Female", "Others"]
	
	// FOCUS STATE TO DISMISS 'phoneNumber' TEXTFIELD PHONE PAD INPUT
	@FocusState private var textFieldIsFocused: Bool
	
	// STATE PROPERTY TO TRACK WHETHER 'Confirmation Dialog' IS CURRENTLY SHOWN
	@State private var showingConfirmationDialog = false
	
	// STATE PROPERTY TO TRACK WHETHER 'PHPickerView' IS CURRENTLY SHOWN
	@State private var showingImagePicker = false
	
	// STATE PROPERTY TO TRACK WHETHER 'AccessCamera' VIEW IS CURRENTLY SHOWN
	@State private var showingCameraView = false
	
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
					// TRIGGERS CONFIRMATION DIALOG
					showingConfirmationDialog = true
				}
				// ONCHANGE MODIFIER;
				/// WATCH FOR ANY VALUE CHANGES IN 'inputImage' STATE PROPERTY
				/// CALL 'loadImage()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
				/// '_ in' - IGNORE THE INPUT
				.onChange(of: inputImage) { _ in loadImage() }
				.confirmationDialog("Add Profile Picture", isPresented: $showingConfirmationDialog) {
					// TRIGGERS IMAGE PICKER
					Button("Choose Photo") { showingImagePicker = true }
					// TRIGGERS iDEVICE CAMERA
					Button("Take Picture") { showingCameraView = true }
					// CLEAR EXISTING PICTURE
					Button("Clear", role: .destructive) {
						image = nil
					}
					// CANCEL
					Button("Cancel", role: .cancel) { }
				}
				.sheet(isPresented: $showingImagePicker) {
					// CREATE AN 'ImagePicker' STRUCT INSTANCE FOR 'PHPickerViewController'
					ImagePicker(image: $inputImage)
				}
				.sheet(isPresented: $showingCameraView) {
					// CREATE AN 'ImagePicker' STRUCT INSTANCE FOR 'PHPickerViewController'
					AccessCamera(image: $inputImage)
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
						
						Button {
							// TRY R/WT LAST KNOWN LOCATION COORDINATE AS THE 'location' PROPERTY VALUE
							if let location = self.locationFetcher.lastKnownLocation {
								self.location = location
							}
						} label: {
							HStack {
								Spacer()
								Label("Add Current Location", systemImage: "location.viewfinder")
								Spacer()
							}
						}
						.accessibilityHint("Current location's coordinate will be added to the entry")
						
						Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
							.frame(height: 200)
							.onAppear {
								// START FETCHING USER LOCATION
								self.locationFetcher.start()
							}
							.accessibilityElement()
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
						newPerson.longitude = location?.longitude ?? 0.0
						newPerson.latitude = location?.latitude ?? 0.0
						
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
