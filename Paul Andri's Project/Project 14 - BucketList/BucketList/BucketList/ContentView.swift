//
//  ContentView.swift
//  BucketList
//
//  Created by Paul Andri on 08/24/2022.
//
// IMPLEMENTED "MVVM" DESIGN PATTERN

// IMPORT MAPKIT FRAMEWORK MODULE
import MapKit
import SwiftUI

struct ContentView: View {
	// PART OF DAY 72 - IMPLEMENTING "MVVM" DESIGN PATTERN
	/// ALL APP STATE PROPERTIES IS NOW PUBLISHED PROPERTIES IN 'ContentView' EXTENSION'S 'ViewModel' CLASS
	// STATEOBJECT PROPERTY - CREATE AN INSTANCE OF 'ContentView's 'ViewModel' CLASS
	/// THIS STATEOBJECT PROPERTY IS USE IN PLACE OF ALL THE ORIGINAL APP STATE PROPERTIES
	@StateObject private var viewModel = ViewModel()
	
	
    var body: some View {
		// CONDITIONAL VIEW SHOWING: BASED ON THE VIEW MODEL'S 'appUnlocked' PUBLISHED PROPERTY STATE
		if viewModel.appUnlocked {
			ZStack {
				// MAP VIEW, BOUND TO THE VIEW MODEL'S 'mapRegion' PUBLISHED PROPERTY VALUE
				/// GET MAP ANNOTATION ITEMS FROM THE VIEW MODEL'S 'locations' PUBLISHED PROPERTY
				Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
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
							/// SET 'location' OBJECT DATA AS THE 'Location' OBJECT DATA FOR:
							///  THE VIEW MODEL'S 'selectedLocation' PUBLISHED PROEPRTY
							viewModel.selectedLocation = location
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
							// CALL THE 'addLocation()' METHOD FROM THE VIEW MODEL
							viewModel.addLocation()
						} label: {
							Image(systemName: "plus")
								.padding()
								.background(.black.opacity(0.5))
								.foregroundColor(.white)
								.font(.title)
								.clipShape(Circle())
							///	MOVE THE ENTIRE BUTTON VIEW AWAY FROM THE TRAILING EDGE
								.padding(.trailing)
								.shadow(radius: 5, x: 0, y: 5)
						}
					}
				}
			}
			// SHEET VIEW MODIFIER FOR EDITING LOCATION MARKER DATA
			/// SWIFT AUTO-UNWRAPS THE 'Location' DATA OBJECT OF THE VIEW MODEL'S 'selectedLocation' PUBLISHED PROPERTY
			/// SHEET IS SHOWN WHEN 'selectedMarker' VALUE IS NOT 'nil'
			.sheet(item: $viewModel.selectedLocation) { location in
				// CALL 'EditView' W/ PASSED IN 'location' DATA
				EditView(location: location) { newLocation in
					// CALL THE 'updateLocation()' METHOD FROM THE VIEW MODEL
					viewModel.updateLocation(location: newLocation)
				}
			}
		
		} else {
			// IF THE VIEW MODEL'S 'appUnlocked' PUBLISHED PROPERTY STATE IS 'false':
			ZStack {
				Map(coordinateRegion: $viewModel.mapRegion)
					.ignoresSafeArea()
				
				VStack {
					Spacer()
					// BUTTON VIEW TO START APP UNLOCK USING BIOMERTIC AUTHENTICATION
					Button {
						// CALL THE VIEW MODEL'S 'authenticate' METHOD
						viewModel.authenticate()
					} label: {
						Label("Unlock App", systemImage: "touchid")
							.labelStyle(.titleAndIcon)
							.padding()
							.background(.ultraThickMaterial)
							.foregroundColor(.primary)
							.clipShape(Capsule())
							.shadow(radius: 5, x: 0, y: 5)
					}
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
