//
//  DataHandler.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/13/2022.
//
// Part of Day 91:
///Try to find a way to centralize the loading and saving code for the Cards

import Foundation

struct DataHandler {
	/// Define Card Stack's Documents Directory save path
	static let savePath = FileManager.documentsDirectory.appendingPathComponent("Card Stack")
	
	/// Method to load saved "Card Stack" JSON Data from 'savePath' (Documents Directory)
	static func loadData() -> [Card] {
		if let data = try? Data(contentsOf: savePath) {
			if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
				return decoded
			}
		}
		
		/// Return empty 'Card' Array if no saved Data were found in the 'savePath'
		return [Card]()
	}
	
	/// Method to save "Card Stack" Data as JSON Data to 'savePath' (Documents Directory)
	static func saveData(_ cards: [Card]) {
		if let data = try? JSONEncoder().encode(cards) {
			try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
		}
	}
}
