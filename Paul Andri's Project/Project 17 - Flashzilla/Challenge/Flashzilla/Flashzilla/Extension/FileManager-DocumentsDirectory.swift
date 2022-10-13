//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Paul Andri on 08/26/2022.
//
// Part of Day 91:
///Try to find a way to centralize the loading and saving code for the Cards

import Foundation

extension FileManager {
	// COMPUTED PROPERTY CLOSURE TO GET THE USER'S DOCUMENTS DIRECTORY URL PATH
	static var documentsDirectory: URL {
		// GET ALL THE USER'S DOCUMENTS DIRECTORY URL PATHS (AN ARRAY)
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		// RETURN THE FIRST PATH URL VALUE
		return path[0]
	}
}
