//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by Paul Andri on 09/23/2022.
//

// IMPORT 'CodeScanner' DEPENDENCY MODULE
import CodeScanner
import SwiftUI

struct ProspectsView: View {
	// ENUM CASES FOR LIST FILTER TYPES
	enum FilterType {
		case none, contacted, uncontacted
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
	
	// PROPERTY TO STORE CURRENTLY SELECTED LIST FILTER TYPE
	let filter: FilterType
	
	
    var body: some View {
		NavigationView {
			List {
				// 'ForEach' DON'T NEED 'id:':
				/// 'Prospect' HAS ALREADY CONFORMED TO 'Identifiable' PROTOCOL
				ForEach(filteredProspects) { prospect in
					VStack(alignment: .leading) {
						Text(prospect.name)
							.font(.headline)
						Text(prospect.emailAddress)
							.foregroundColor(.secondary)
					}
					// TOGGLE PROSPECT'S 'isContacted' BOOL STATE W/ SWIPE ACTIONS
					.swipeActions {
						if prospect.isContacted {
							Button {
								// CALL 'toggleContacted' METHOD IN THE ENVIRONMENT
								/// TOGGLE THE STATE OF 'isContacted', WILL ENSURE VIEW IS UPDATED CORRECTLY
								prospects.toggleContacted(prospect)
							} label: {
								Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
							}
							.tint(.blue)
						} else {
							Button {
								// CALL 'toggleContacted' METHOD IN THE ENVIRONMENT
								/// TOGGLE THE STATE OF 'isContacted', WILL ENSURE VIEW IS UPDATED CORRECTLY
								prospects.toggleContacted(prospect)
							} label: {
								Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
							}
							.tint(.green)
						}
					}
				}
			}
			// USE 'title' COMPUTED VALUE AS THE CORRECT NAV VIEW TITLE
			.navigationTitle(title)
			.toolbar {
				// SCAN QR BUTTON (ADD NEW PROSPECTS)
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
	
	// COMPUTED '[Prospect]' PROPERTY FOR DYNAMIC LIST FILTERING
	var filteredProspects: [Prospect] {
		// RETURNED '[Prospect]' DEPEND ON THE SELECTED FILTER CASE
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
			
			// APPEND THE CREATED 'Prospect' OBJECT INSTANCE INTO 'prospects' ENVIRONMENTOBJECT'S ARRAY
			prospects.people.append(person)
			
		case .failure(let error):
			print("Scanning failed: \(error.localizedDescription)")
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
