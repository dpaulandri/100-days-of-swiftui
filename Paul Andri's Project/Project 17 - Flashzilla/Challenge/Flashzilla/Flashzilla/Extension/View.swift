//
//  View.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/03/2022.
//

import SwiftUI

extension View {
	/*
	 'stacked()' Modifier that takes a "position" in an Array along w/ the total size of the Array,
	 and offsets the 'y'(vertical) axis of a "View" by some amount based on those values.
	 */
	func stacked(at position: Int, in total: Int) -> some View {
		let offset = Double(total - position)
		return self.offset(x:0, y: offset * 10)
	}
}
