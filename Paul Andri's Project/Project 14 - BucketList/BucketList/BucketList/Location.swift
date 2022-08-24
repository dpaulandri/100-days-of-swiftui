//
//  Location.swift
//  BucketList
//
//  Created by Paul Andri on 08/24/2022.
//

import Foundation
// 'CoreLocation' MODULE IS NEEDED FOR THE COMPUTED PROPERTY 'coordinate'
import CoreLocation

// 'Location' CUSTOM DATA OBJECT TYPE STRUCT
/// CONFORMS TO 'Identifiable', 'Codable' & 'Equatable' PROTOCOLS:
/// - 'Identifiable' - allow creation of many unique & identifable map location markers
/// - 'Codable' - load & save map data easily
/// - 'Equatable' - so we can find one particular location in an Array of locations
struct Location: Identifiable, Codable, Equatable {
	/// 'id' IS A 'var' PROPERTY BECAUSE;
	/// NEEDED TO FORCE SWIFTUI TO REDRAW TO REFLECT CHANGES WHENEVER NEW 'name' & 'description' VALUES ARE SAVED
	var id: UUID
	/// 'name' & 'description' ARE 'var' BECAUSE WE WANT TO ALLOW USER TO EDIT ITS VALUES
	var name: String
	var description: String
	let latitude: Double
	let longitude: Double
	
	// COMPUTED PROPERTY OF 'Location' OBJECT'S 'CLLocationCoordinate2D' VALUE
	var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	// AN EXAMPLE STATIC PROPERTY OF AN 'Location' DATA OBJECT
	/// USERFUL FOR TESTING/PREVIEW PURPOSES
	static let example = Location(
		id: UUID(),
		name: "Buckingham Palace",
		description: "Where Queen Elizabeth II lives with her dorgis.",
		latitude: 51.501,
		longitude: -0.141)
	
	// STATIC METHOD FOR CUSTOM "EQUALS TO" 'Equatable' PROTOCOL COMPARISON
	static func ==(lhs: Location, rhs: Location) -> Bool {
		/// COMPARE ONLY THE 'Location' DATA OBJECT'S 'id' PROPERTY VALUE
		lhs.id == rhs.id
	}
}
