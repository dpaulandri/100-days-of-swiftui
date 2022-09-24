//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Paul Andri on 09/23/2022.
//

// IMPORT 'CodeScanner' DEPENDENCY MODULE
import CodeScanner
// IMPORT 'UserNotifications' FRAMEWORK TO SCHEDULE LOCAL USER NOTIFICATIONS
import UserNotifications
import SwiftUI

struct ProspectsView: View {
	// ENUM CASES FOR LIST FILTER TYPES
	enum FilterType {
		case none, contacted, uncontacted
	}
	
	// PART OF DAY 85 - CHALLENGE #3
	/// Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent
	// ENUM CASES FOR LIST SORTING
	enum SortType {
		case name, newest, oldest
	}
	
	// ENVIRONMENTOBJECT PROPERTY OF 'Prospects' CLASS OBJECT TYPE
	/*
	 @EnvironmentObject Property Wrapper that does all the work of:
	 - Finding the Object,
	 - Attaching it to a Property, and
	 - Keeping it up to date over time
	*/
	@EnvironmentObject var prospects: Prospects
	
	// STATE PROPERTY TO TRACK QR CODE SCANNER VIEW SHOWING
	@State private var showingQRScanner = false
	
	// PART OF DAY 85 - CHALLENGE #3
	/// Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent
	@State private var showConfirmationDialog = false
	@State private var sort = SortType.name
	
	// PROPERTY TO STORE CURRENTLY SELECTED LIST FILTER TYPE
	let filter: FilterType
	
	
    var body: some View {
		NavigationView {
			List {
				// 'ForEach' DON'T NEED 'id:':
				/// 'Prospect' HAS ALREADY CONFORMED TO 'Identifiable' PROTOCOL
				ForEach(filteredProspects) { prospect in
					// DAY 85 - CHALLENGE #1
					/// Add an icon to the “Everyone” screen showing whether a prospect was contacted or not
					HStack {
						Image(systemName: prospect.isContacted ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.badge.xmark")
							.font(.system(size: 44))
							.foregroundColor(prospect.isContacted ? .green : .blue)
						
						VStack(alignment: .leading) {
							Text(prospect.name)
								.font(.headline)
							Text(prospect.emailAddress)
								.foregroundColor(.secondary)
						}
					}
					// SWIPE ACTIONS
					.swipeActions {
						// CHECK FOR PROSPECT'S 'isContacted' STATE
						if prospect.isContacted {
							// TOGGLE PROSPECT'S 'isContacted' STATE TO 'false'
							Button {
								// CALL 'toggleContacted' METHOD IN THE ENVIRONMENT
								/// TOGGLE THE STATE OF 'isContacted', WILL ENSURE VIEW IS UPDATED CORRECTLY
								prospects.toggleContacted(prospect)
							} label: {
								Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
							}
							.tint(.blue)
						} else {
							// TOGGLE PROSPECT'S 'isContacted' STATE TO 'true'
							Button {
								// CALL 'toggleContacted' METHOD IN THE ENVIRONMENT
								/// TOGGLE THE STATE OF 'isContacted', WILL ENSURE VIEW IS UPDATED CORRECTLY
								prospects.toggleContacted(prospect)
							} label: {
								Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
							}
							.tint(.green)
							
							// BUTTON TO ADD LOCAL USERNOTIFICATION
							Button {
								addNotification(for: prospect)
							} label: {
								Label("Remind Me", systemImage: "bell")
							}
							.tint(.orange)
						}
					}
					.swipeActions(edge: .leading) {
						/// "DESTRUCTIVE" BUTTON  (COLOURED RED)
						Button(role: .destructive) {
							// CODE TO DELETE PROSPECT
						} label: {
							Label("Delete", systemImage: "trash")
						}
					}
					// PART OF DAY 85 - CHALLENGE #3
					/// Use a confirmation dialog to customize the way users are sorted in each tab
					.confirmationDialog("Prospect List Sorting", isPresented: $showConfirmationDialog) {
						Button(sort == .name ? "Name (Current)" : "Name") { sort = .name }
						Button(sort == .newest ? "Newest to Oldest (Current)" : "Newest to Oldest") { sort = .newest }
						Button(sort == .oldest ? "Oldest to Newest (Current)" : "Oldest to Newest") { sort = .oldest }
					} message: {
						Text("Sorting Method")
					}
				}
			}
			// USE 'title' COMPUTED VALUE AS THE CORRECT NAV VIEW TITLE
			.navigationTitle(title)
			.toolbar {
				// SCAN QR BUTTON (ADD NEW PROSPECTS)
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						// DUMMY DATA FOR TESTING
						/*
						 // CODE TO CREATE DUMMY DATA
						 let prospect = Prospect()
						 prospect.name = "Paul Andri"
						 prospect.emailAddress = "paul@paulandri.com"
						 // APPEND DUMMY 'Prospect' OBJECT TO THE 'prospects' ENVIRONMENTOBJECT'S ARRAY
						 prospects.people.append(prospect)
						 */
						
						// CHANGE 'showingQRScanner' STATE TO 'true'; SHOW SCANNER VIEW
						showingQRScanner = true
						
					} label: {
						Label("Scan", systemImage: "qrcode.viewfinder")
					}
				}
				
				// PART OF DAY 85 - CHALLENGE #3
				// PROSPECT LIST SORTING BUTTON
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						showConfirmationDialog = true
					} label: {
						Label("List Sorting", systemImage: "arrow.up.arrow.down")
					}
				}
			}
			// SHEET VIEW FOR QR CODE SCANNER VIEW
			.sheet(isPresented: $showingQRScanner) {
				CodeScannerView(codeTypes: [.qr], simulatedData: "James Bond\nbond@mi6.gov.uk", shouldVibrateOnSuccess: true, completion: handleQRScan)
			}
		}
    }
	
	
	// COMPUTED STRING PROPERTY FOR NAVIGATION VIEW TITLE
	var title: String {
		// RETURNED STRING TITLE DEPEND ON THE SELECTED FILTER CASE
		switch filter {
		case .none:
			return "Everyone"
		case.contacted:
			return "Contacted"
		case .uncontacted:
			return "Uncontacted"
		}
	}
	
	// PART OF DAY 85 - CHALLENGE #3
	/// Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent
	// COMPUTED '[Prospect]' PROPERTY FOR DYNAMIC LIST FILTERING
	var filteredProspects: [Prospect] {
		// CLOSURE TO GET A FILTERED '[Prospect]' DEPENDING ON THE SELECTED FILTER CASE
		var filteredList: [Prospect] {
			switch filter {
			case .none:
				return prospects.people
			case.contacted:
				// FILTER & RETURN ONLY THOSE 'Prospect' OBJECT WHICH 'isContacted' IS 'true'
				return prospects.people.filter { $0.isContacted }
			case .uncontacted:
				// FILTER & RETURN ONLY THOSE 'Prospect' OBJECT WHICH 'isContacted' IS NOT 'true'
				return prospects.people.filter { !$0.isContacted }
			}
		}
		
		// RETURN '[Prospect]' TO METHOD FROM 'filteredList' DEPENDING ON THE SELECTED SORT CASE
		switch sort {
		case .name:
			return filteredList.sorted {
				$0.name < $1.name
			}
		case .newest:
			return filteredList.reversed()
		case .oldest:
			return filteredList
		}
	}
	
	// METHOD TO HANDLE THE RESULT OF QR CODE SCANNING
	/// 'ScanResult' & 'ScanError' TYPES ARE FROM 'CodeScanner' Package Dependency
	func handleQRScan(result: Result<ScanResult, ScanError>) {
		// CHANGE 'showingQRScanner' STATE TO 'false'; DISMISS SCANNER VIEW
		showingQRScanner = false
		
		// PROCESS THE QR CODE SCANNER RESULT W/ SWITCH STATEMENTS
		switch result {
		case .success(let result):
			// SEPERATE THE RESULT STRING VALUE INTO AN ARRAY BY LINE BREAK '\n'
			let details = result.string.components(separatedBy: "\n")
			// ENSURE THE RESULTING ARRAY HAS A COUNT OF 2 ITEMS, ELSE EXIT
			guard details.count == 2 else { return }
			
			// CREATE A NEW 'Prospect' OBJECT INSTANCE W/ THE CORRESPONDING VALUES FROM 'details' ARRAY
			let person = Prospect()
			person.name = details[0]
			person.emailAddress = details[1]
			
			// CALL 'addProspect' METHOD TO ADD & SAVE PROSPECT OBJECT INTO USERDEFAULTS
			prospects.addProspect(person)
			
		case .failure(let error):
			print("Scanning failed: \(error.localizedDescription)")
		}
	}
	
	// METHOD TO ADD LOCAL USER NOTIFICATION
	func addNotification(for prospect: Prospect) {
		// CREATE AN INSTANCE OF USER NOTIFICATION CENTER
		let center = UNUserNotificationCenter.current()
		
		// CLOSURE TO ADD USER NOTIFICATION REQUEST
		let addRequest = {
			// CREATE NEW MUTABLE NOTIFICATION CONTENTS W/ ITS VALUES
			let content = UNMutableNotificationContent()
			content.title = "Contact \(prospect.name)"
			content.subtitle = prospect.emailAddress
			content.sound = UNNotificationSound.default
			
			// CREATE NEW HOUR DATE COMPONENT
			var dateComponents = DateComponents()
			/// DEFINE HOUR COMPONENT TO "9 AM"
			dateComponents.hour = 9
			
			// CREATE NOTIFICATION TRIGGERER
			// let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
			
			// TRIGGERER FOR TESTING PURPOSE (TRIGGER AFTER 5SECS)
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
			
			// CREATE NOTIFICATION REQUEST
			/// USE RANDOM 'UUID().uuidString' AS IDENTIFIER IF WE DON'T NEED TO UPDATE THE NOTIFICATION ITEM
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			
			// ADD NOTIFICATION REQUEST TO USER NOTIFICATION CENTER
			center.add(request)
		}
		
		// READ USER'S NOTIFICATION SETTING FOR THIS APP & ACT ACCORDINGLY
		center.getNotificationSettings { settings in
			// IF USER HAS AUTHROISED USERNOTIFICATION PERMISSION FOR THIS APP
			if settings.authorizationStatus == .authorized {
				// CALL 'addRequest' CLOSURE
				addRequest()
			} else { // ELSE
				// REQUEST USER'S AUTHORISATION FOR THIS APP'S USERNOTIFICATION SETTING
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						// IF USER GRANT AUTHORISATION; CALL 'addRequest' CLOSURE
						addRequest()
					} else {
						// ELSE PRINT THIS:
						print("User do not authorise Notification")
					}
				}
			}
		}
	}
}



struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
		// PASS IN DUMMY FILTER VALUE TO MAKE PREVIEW WORK
		ProspectsView(filter: .none)
			// PASS IN EMPTY 'Prospects()' CLASS OBJECT INTO THE ENVIRONMENT
			.environmentObject(Prospects())
    }
}
