//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//

import SwiftUI

struct ResortView: View {
	/// Environment Property to read Display's Horizontal 'SizeClass'
	@Environment(\.horizontalSizeClass) var sizeClass
	/// Environment Property to read iDevice's 'Dynamic Type' Larger Text Accessibility setting
	@Environment(\.dynamicTypeSize) var typeSize
	
	/// Load the Environment Object of 'favoritedResorts' from ContentView's 'NavigationView' Environment
	@EnvironmentObject var favoritedResorts: Favorites
	
	// Facility Alert related State Properties
	@State private var selectedFacility: Facility? /// Optional 'String'
	@State private var showingFacilityAlert = false
	
	/// View will receive a 'Resort' object in its initializer
	let resort: Resort
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				Image(decorative: resort.id)
					.resizable()
					.scaledToFit()
				
				HStack {
					/// Reponsive Layout based upon the iDevice's Enviornment values
					if sizeClass == .compact  && typeSize > .large {
						VStack(spacing: 10) { ResortDetailsView(resort: resort) }
						VStack(spacing: 10) { SkiDetailsView(resort: resort) }
					} else {
						ResortDetailsView(resort: resort)
						SkiDetailsView(resort: resort)
					}
				}
				.padding(.vertical)
				.background(Color.primary.opacity(0.1))
				/// Limit our App's support of Dynamic Type Sizes w/ range
				/// In this example: limiting up to (incl.) XXXLarge Dynamic Type size using one-sided range
				.dynamicTypeSize(...DynamicTypeSize.xxxLarge)
				
				Group {
					Text(resort.description)
						.padding(.vertical)
					
					Text("Facilities")
						.font(.headline)
					
					/// Old Code for Resort Facilities (Day 97)
					/*
					/// Make a "Text List" out of the 'facilities' [String]
					/// '.list(type: )' available list type: '.and' and '.or'
					Text(resort.facilities, format: .list(type: .and))
						.padding(.vertical)
					*/
					
					/// New Resort Facility Icon Code (Day 98)
					HStack {
						/// Loop over every 'facilityTypes' objects of the 'resort'
						ForEach(resort.facilityTypes) { facility in
							/// Button to trigger Facility Alert window
							Button {
								selectedFacility = facility
								showingFacilityAlert = true
							} label: {
								/// Show corresponding Facility Icon View for each 'facility' object
								facility.icon
									.font(.title)
							}
						}
					}
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle("\(resort.name), \(resort.country)")
		.navigationBarTitleDisplayMode(.inline)
		/// Trigger alert w/ optional User 'selectedFacility' String value
		.alert(selectedFacility?.name ?? "More information", isPresented: $showingFacilityAlert, presenting: selectedFacility) { _ in } message: { facility in Text(facility.description)}
		/// Pass in empty Closure, would still get a "OK" Button to dismiss the Alert window
		
		/// User Favourite Button
		.toolbar {
			ToolbarItem(placement: .confirmationAction) {
				Button {
					if favoritedResorts.contains(resort) {
						favoritedResorts.remove(resort)
					} else {
						favoritedResorts.add(resort)
					}
				} label: {
					favoritedResorts.contains(resort)
					? Image(systemName: "heart.fill").foregroundColor(.red)
						.accessibilityLabel("Remove from Favorites")
					: Image(systemName: "heart").foregroundColor(.secondary)
						.accessibilityLabel("Add to Favorites")
				}
			}
		}
    }
}



struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			ResortView(resort: Resort.exampleResort)
		}
		/// Inject empty 'Favorites' Class Instance into Preview's NavigationView Environment
		.environmentObject(Favorites())
    }
}
