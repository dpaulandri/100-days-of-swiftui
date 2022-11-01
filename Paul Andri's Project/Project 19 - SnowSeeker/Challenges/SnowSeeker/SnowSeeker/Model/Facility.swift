//
//  Facility.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/31/2022.
//

import SwiftUI

struct Facility: Identifiable {
	let id = UUID()
	var name: String
	
	/// Dictionary of all possibile Facility icons ["Facility String" : "SFSymbol icon String name"]
	private let icons = [
		"Accommodation": "house",
		"Beginners" : "1.circle",
		"Cross-country" : "map",
		"Eco-friendly" : "leaf.arrow.circlepath",
		"Family" : "person.3"
	]
	
	/// Dictionary for Facility alert window's description ["Facility String" : "Facility description String value"]
	private let descriptions = [
		"Accommodation": "This resort has popular on-site accommodation.",
		"Beginners" : "This resort has lots of ski schools.",
		"Cross-country" : "This resort has many cross-country ski routes.",
		"Eco-friendly" : "This resort has won an award for environmental friendliness.",
		"Family" : "This resort is popular with families."
	]
	
	/// Facility Icon View
	var icon: some View {
		/// Try to find the corresponding "SFSymbol Icon String name" in 'icons' Dictionary by using the current Facility 'name' String value
		if let iconName = icons[name] {
			/// Return SFSymbol Image w/ 'iconName' String value as it's SFSymbol name
			return Image(systemName: iconName)
				.accessibilityLabel(name)
				.foregroundColor(.secondary)
		} else {
			fatalError("Unknown facility type: \(name)")
		}
	}
	
	/// Computed Property for Facility Description
	var description: String {
		/// Try to find the corresponding Facility Description String value in 'descriptions' Dictionary by using the current Facility 'name' String value
		if let message = descriptions[name] {
			/// Returns the corresponding Facility Description 'String' value
			return message
		} else {
			fatalError("Unknown facility type: \(name)")
		}
	}
}
