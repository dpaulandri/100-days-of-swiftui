//
//  ContentView.swift
//  BucketList
//
//  Created by Paul Andri on 08/24/2022.
//

// IMPORT MAPKIT FRAMEWORK MODULE
import MapKit
import SwiftUI

struct ContentView: View {
	// STATE PROPERTY TO STORE MAP'S CURRENT STATE
	/// COORIDNATE SHOWS MOST OF WESTERN EUROPE & NORTH AFRICA
	@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
	
	// STATE PROPERTY TO STORE AN ARRAY OF 'Location' OBJECT TYPE DATA
	@State private var locations = [Location]()
	
	 // STATE PROPERTY TO TRACK WHICH LOCATION MARKER IS SELECTED (OPTIONAL 'Location' OBJECT)
	@State private var selectedLocation: Location?
	
	
    var body: some View {
		ZStack {
			// MAP VIEW, BOUND TO 'mapRegion' STATE PROPERTY VALUE
			/// GET MAP ANNOTATION ITEMS FROM 'locations' STATE PROPERTY
			Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
				/// 'MapMarker' - STANDARD MAP ANNOTATION MARKER
				/*
				/// GET ITS LATITIUDE & LOGITUDE VALUES FROM 'location' OBJECT ITEM
				MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
				*/
				
				/// 'MapAnnotation' - CUSTOM MAP ANNOTATION MARKER (ACCEPT ANY KIND OF VIEW)
				/// GET ITS LATITIUDE & LOGITUDE VALUES FROM 'location' OBJECT ITEM'S COMPUTED PROPERTY
				MapAnnotation(coordinate: location.coordinate) {
					/// VSTACK VIEW AS CUSTOM MAP ANNOTATION MARKER
					VStack {
						Image(systemName: "airplane.circle.fill")
							.resizable()
							.foregroundColor(.red)
							.frame(width: 44, height: 44)
							.background(.white)
							.clipShape(Circle())

						Text(location.name)
							//	FIXES THE VIEW AT ITS IDEAL SIZE
							/// FULL TEXT VIEW WILL BE SHOWN W/O TRUNCATION
							.fixedSize()
					}
					.onTapGesture {
						/// SET 'location' OBJECT DATA AS THE 'Location' OBJECT DATA FOR 'selectedMarker' STATE PROEPRTY
						selectedLocation = location
						/// TRIGGER THE SHEET VIEW FOR EDITING LOCATION MARKER DATA
					}
				}
			}
			.ignoresSafeArea()
			
			// CIRCLE SHAPE VIEW
			/// SERVES AS THE MAP VIEW'S CENTER POINT MARKER
			Circle()
				.fill(.blue)
				.opacity(0.5)
				.frame(width: 20, height: 20)
			
			// VSTACK VIEW FOR "ADD LOCATION" BUTTON
			VStack {
				/// SPACER PUSHES THE HSTACK VIEW BELOW TO THE BOTTOM
				Spacer()
				
				HStack {
					Spacer()
					Button {
						// CODES TO ADD NEW 'Location' Object Data TO 'locations' STATE PROPERTY:
						/// 1. CREATE NEW 'Location' OBJECT DATA
						let newLocation = Location(
							id: UUID(),
							name: "New Location",
							description: "",
							latitude: mapRegion.center.latitude,
							longitude: mapRegion.center.longitude
						)
						
						/// 2. APPEND 'newLocation' OBJECT DATA TO THE ARRAY IN 'locations' STATE PROPERTY
						locations.append(newLocation)
						
					} label: {
						Image(systemName: "plus")
							.padding()
							.background(.black.opacity(0.5))
							.foregroundColor(.white)
							.font(.title)
							.clipShape(Circle())
							///	MOVE THE ENTIRE BUTTON VIEW AWAY FROM THE TRAILING EDGE
							.padding(.trailing)
					}
				}
			}
		}
		// SHEET VIEW MODIFIER FOR EDITING LOCATION MARKER DATA
		/// SWIFT AUTO-UNWRAPS THE 'Location' DATA OBJECT OF 'selectedMarker' STATE PROPERTY
		/// SHEET IS SHOWN WHEN 'selectedMarker' VALUE IS NOT 'nil'
		.sheet(item: $selectedLocation) { location in
			// CALL 'EditView' W/ PASSED IN 'location' DATA
			EditView(location: location) { newLocation in
				// TRY TO FIND THE ARRAY INDEX OF PASSED-IN 'marker' FROM THE ARRAY IN 'locations' STATE PROPERTY
				if let index = locations.firstIndex(of: location) {
					/// IF THE ARRAY INDEX IS FOUND;
					// OVERWRITE ORIGINAL 'Location' OBJECT AT THE ARRAY INDEX W/ NEW 'Location' OBJECT DATA
					locations[index] = newLocation
				}
			}
		}
		
    }
}



// PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
