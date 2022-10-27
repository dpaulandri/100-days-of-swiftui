//
//  Resort.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//

import Foundation

struct Resort: Codable, Identifiable {
	let id: String
	let name: String
	let country: String
	let description: String
	let imageCredit: String
	let price: Int
	let size: Int
	let snowDepth: Int
	let elevation: Int
	let runs: Int
	let facilities: [String]
	
	/// Static properties to decode, store all 'Resort' data into an Array & extract the first 'Resort' object as an example
	/// More flexible, expandable & reusable
	static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
	static let exampleResort = allResorts[0]
	
	/// Static example property to store the first 'Resort' object data from decoded 'resorts.json'
	/// More specific
	static let firstResort = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
