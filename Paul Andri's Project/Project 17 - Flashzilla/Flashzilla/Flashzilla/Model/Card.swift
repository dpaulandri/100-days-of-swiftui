//
//  Card.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/03/2022.
//

import Foundation

struct Card {
	let prompt: String
	let answer: String
	
	/// Static 'Card' Object Property for Previewing & Prototypic purposes
	static let exampleCard = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
