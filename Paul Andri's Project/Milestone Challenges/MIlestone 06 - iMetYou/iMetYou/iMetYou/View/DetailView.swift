//
//  DetailView.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
	// PERSON PROPERTY
	let person: Person
	
	// GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
	// ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
	@Environment(\.managedObjectContext) var moc
	
	// ENVIRONMENT PROPERTY TO DISMISS 'DetailView'
	@Environment(\.dismiss) var dismiss
	
	@State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

	// STATE PROPERTY SHOW BOOK PERSON DELETE CONFIRMATION ALERT WINDOW
	@State private var showDeleteAlert = false
	
	
	var body: some View {
		ScrollView {
			Spacer()
			
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
				Spacer()
				
				// MAP VIEW SECTION
				Section {
					ZStack {
						Map(coordinateRegion: $region, interactionModes: [])
						
						if region.center.longitude != 0.0 && region.center.latitude != 0.0 {
							Image(systemName: "mappin.and.ellipse")
								.foregroundColor(.red)
								.font(.system(size: 44))
						} else {
							Text("No Location Data")
								.fontWeight(.semibold)
							
						}
					}
					.frame(height: 200)
					
					Spacer()
				}
				.accessibilityElement()
				.accessibilityLabel("Apple Map View, showing the location where \(person.fullName) is added into the List.")
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
			// SET COORDINATE FOR MAP VIEW
			.onAppear(perform: setCoordinate)
			
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
	
	static let region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
	
    static var previews: some View {
        DetailView(person: person, region: region)
    }
}
