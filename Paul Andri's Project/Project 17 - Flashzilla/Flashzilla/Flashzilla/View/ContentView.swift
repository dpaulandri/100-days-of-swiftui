//
//  ContentView.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/03/2022.
//

import SwiftUI

struct ContentView: View {
	/*
	 Swift’s Arrays have a helpful Initializer: 'init(repeating:count:)',
	 which takes one Value and Repeats it a number of times to create the Array
	*/
	/// State Property for an Array of 'Card' Object
	@State private var cards = [Card](repeating: Card.exampleCard, count: 10)
	
	
    var body: some View {
		/// Bottom 'ZStack'
		ZStack {
			/// App Background Image
			Image(decorative: "background")
				.resizable()
				.ignoresSafeArea()
			
			/// 'VStack' containing 'Timer' and "3D Card Stack"
			VStack {
				/// 'ZStack' for "3D Card Stack" of many 'CardView'
				ZStack {
					ForEach(0..<cards.count, id: \.self) { index in
						CardView(card: cards[index]) {
							/// 'withAnimation' will cause the remaining "Card Stack" to "float up"
							withAnimation {
								/// Call 'removeCard' method to remove 'Card' from "Card Stack"
								removeCard(at: index)
							}
						}
						/// Call '.stacked()' 'View' Extension to offset 'CardView' in a "Card Stack"
						.stacked(at: index, in: cards.count)
					}
				}
			}
		}
    }
	
	/// Method to remove 'Card' from "Card Stack"
	func removeCard(at index: Int) {
		cards.remove(at: index)
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
