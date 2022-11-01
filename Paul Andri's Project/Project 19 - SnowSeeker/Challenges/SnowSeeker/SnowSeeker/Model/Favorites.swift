//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/31/2022.
//

import SwiftUI

// 'Favorites' Class for User favourited resorts
class Favorites: ObservableObject {
	/// Property to store the Set of User favourited resorts
	private var favoritedResorts: Set<String>
	
	/// Property to store UserDefaults' Save Key String
	private let saveKey = "Favorites"
	
	/// Custom Initializer
	init() {
		// Day 99 - Challenge #2
		/// Load Saved Data from UserDefaults w/ 'saveKey'
		if let data = UserDefaults.standard.data(forKey: saveKey) {
			/// Try to decode the fetched JSON Data
			if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
				/// Assign decoded 'Set<String>' Data as the value for 'favoritedResorts' Property
				favoritedResorts = decoded
				
				/// Exit Initializer immediately
				return
			}
		}
		
		/// If FAILED TO LOAD saved Data from UserDefaults, initliase 'favoritedResorts ' as an Empty Array
		favoritedResorts = []
	}
	
	/// Method to return a Bool value if  'favoritedResorts' Set contains the passed-in Resort Object (by matching its String 'id')
	func contains(_ resort: Resort) -> Bool {
		favoritedResorts.contains(resort.id)
	}
	
	/// Method to add the passed-in Resort object into 'favoritedResorts', update all Views, and Save any changes
	func add(_ resort: Resort) {
		objectWillChange.send() /// Send Value change notification to SwiftUI Views
		favoritedResorts.insert(resort.id) /// Insert object to 'favoritedResorts' Set
		save() /// Call 'save()' Method
	}
	
	/// Method to remove the passed-in Resort object from 'favoritedResorts', update all Views, and Save any changes
	func remove(_ resort: Resort) {
		objectWillChange.send() /// Send Value change notification to SwiftUI Views
		favoritedResorts.remove(resort.id) /// Remove object from 'favoritedResorts' Set
		save() /// Call 'save()' Method
	}
	
	// Day 99 - Challenge #2
	/// Method to save Data & changes into UserDefaults
	func save() {
		/// Try to encode 'favoritedResorts' Property Data into JSON Data
		if let encoded = try? JSONEncoder().encode(favoritedResorts) {
			/// Save the encoded Data into UserDefaults w/ 'saveKey'
			UserDefaults.standard.set(encoded, forKey: saveKey)
		}
	}
}
