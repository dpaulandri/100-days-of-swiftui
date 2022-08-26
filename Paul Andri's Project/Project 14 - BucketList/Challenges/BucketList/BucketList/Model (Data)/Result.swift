//
//  Result.swift
//  BucketList
//
//  Created by Paul Andri on 08/25/2022.
//
// CUSTOM OBJECT DATA TYPE STRUCTS FOR WIKIPEDIA API QUERY RESULT JSON DATA

import Foundation

// Wikipedia’s API sends back JSON data in a precise format,
// so we need to define 'Codable' Structs capable of storing it all.

// The structure is this:

/// • The main 'Result' contains "the result of our query" in a KEY called 'query'.
struct Result: Codable {
	let query: Query
}

/// • Inside the 'Query' is a 'pages' Dictionary,
/// with "page IDs" as the "KEY" and "the Wikipedia pages" themselves as "VALUES".
struct Query: Codable {
	let pages: [Int: Page]
}

/// • Each 'Page' has a lot of information, including its "coordinates", "title", "terms", and more.
///  'terms' is a Dictionary w/ 'String' value as its "KEY" and an Array of "String" as its "VALUES".
///  STRUCT IS ALSO COMFORMING TO 'Comparable' PROTOCOL
struct Page: Codable, Comparable {
	let pageid: Int
	let title: String
	let terms: [String: [String]]?
	
	// COMPUTED PROPERTY FOR PLACE DESCRIPTION
	var description: String {
		// OPTIONAL CHAINING & NIL COALESCING
		/* LOGIC:
		 1. ATTEMPT TO UNWRAP 'terms';
		 2. ATTEMPT READ 'description' DICTIONARY KEY
		 3. ATTEMPT TO READ & GET THE FIRST ITEM OF THAT ARRAY
		 ELSE SEND BACK THE DEFAULT VALUE
		*/
		terms?["description"]?.first ?? "No description available."
	}
	
	// STATIC 'LESS THAN' FUNCTION FOR CUSTOM 'Comparable' COMFORMANCE
	static func <(lhs: Page, rhs: Page) -> Bool {
		/// ASCENDING SORT BY 'title' PROPERTY VALUE
		lhs.title < rhs.title
	}
}
