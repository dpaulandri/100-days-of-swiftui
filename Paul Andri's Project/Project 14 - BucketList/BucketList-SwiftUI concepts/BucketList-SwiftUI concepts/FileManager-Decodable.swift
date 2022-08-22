//
//  FileManager-Decodable.swift
//  BucketList-SwiftUI concepts
//
//  Created by Paul Andri on 08/21/2022.
//
// MINI CHALLENGE FOR DAY 68 MATERIAL - READ/WRITE DATA TO "DOCUMENTS DIRECTORY"
// CONVERT Project 8 "MoonShot" 'Bundle-Decodable' EXTENSTION TO 'FileManager' EXTENSION

import Foundation

// ADD 'decode' METHOD AS AN 'FileManager' EXTENSION
extension FileManager {
	// CONVERT "GENERIC" DATA INTO ANOTHER "GENERIC" DATA
	// THIS METHOD WILL RETURN A "GENERIC" TYPE DATA
	func decode<T: Codable>(_ file: String) -> T {
		// GET THE APP'S "DOCUMENTS DIRECTORY" PATH
		/// CALLS 'getDocumentsDirectory' METHOD
		/// '.appendingPathComponent("t")' - DEFINE URL DATA COMPONENT & ITS FILENAME
		guard let url = try? getDocumentsDirectory().appendingPathComponent(file) else {
			fatalError("Failed to locate \(file) in App's Documents Directory!")
		}
		
		// TRY TO LOAD THE JSON DATA FROM 'url' URL PATH
		// WE USE 'Data(contentsOf: )' BECAUSE CODABLE USES 'Data' TYPE
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from App's Documents Directory!")
		}
		
		// CREATE A JSONDECODER INSTANCE
		let decoder = JSONDecoder()
		
		
		// PASS ON A DATE FORMAT TO JSONDECODER
		// STEP 1: CREATE AN INSTANCE OF 'DateFormatter'
		let dateFormatter = DateFormatter()
		
		// STEP 2: PASS ON 'dateFormat' TO THE 'dateFormatter'
		// '.dateFormat' FORMAT VALUE IS CASE-SENSITIVE!!!
		dateFormatter.dateFormat = "y-MM-dd"
		
		// STEP 3: PASS ON 'dateFormatter' AS THE FORMAT FOR JSONDECODER's 'dataDecodingStrategy'
		decoder.dateDecodingStrategy = .formatted(dateFormatter)
		
		
		// TRY TO DECODE THE JSON DATA FROM 'data' TO A "GENERIC" TYPE DATA
		guard let loaded = try? decoder.decode(T.self, from: data) else {
			fatalError("Failed to decode \(file) from Bundle!")
		}
		
		// RETURN 'loaded', A "GENERIC" TYPE DATA TO THE METHOD
		return loaded
	}
	
	
	// FROM DAY 68 MATERIAL - READ/WRITE DATA TO "DOCUMENTS DIRECTORY"
	// METHOD TO GET USER'S "DOCUMENTS DIRECTORY" PATH FOR OUR APP, RETURNS AN 'URL' VALUE
	func getDocumentsDirectory() -> URL {
		/// FIND ALL POSSIBLE "DOCUMENTS DIRECTORY" PATH FOR THE USER (SHOULD ONLY BE ONE)
		/// 'FileManager' is a Class
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		
		/// SEND BACK THE FIRST "DOCUMENTS DIRECTORY" PATH FOUND
		return paths[0]
	}
}
