//
//  ContentView.swift
//  GeometryFX
//
//  Created by Paul Andri on 10/16/2022.
//
// Day 94 - 'GeometryReader' FX Challenge Day

import SwiftUI

struct ContentView: View {
	/// Property not used due to Challenge #3
	//let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
	
	var body: some View {
		GeometryReader { fullView in
			ScrollView(.vertical) {
				ForEach(0..<50) { index in
					GeometryReader { geo in
						Text("Row #\(index)")
							.font(.title)
							.frame(maxWidth: .infinity)
							.background(
								/// Not used due to Challenge #3
								//colors[index % 7]
								
								// Day 94 - Challenge #3
								/// Make the Views change color as you scroll.
								/// For the best effect, you should create colors using the 'Color(hue:saturation:brightness:)' initializer,
								/// feeding in varying values for the hue.
								/// Use 'min()' with the 'hue' so that hue values don’t go beyond '1.0'
								Color(hue: Double(min(1.0, Double.random(in: 0.0...1.0))), saturation: 1, brightness: 1)
							)
							.rotation3DEffect(
								.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5,
								axis: (x: 0, y: 1, z: 1)
							)
							// Day 94 - Challenge #1
							/// Make views near the top of the scroll view fade out to 0 opacity
							/// Suggest starting at about 200 points from the top.
							/// '.origin' = A point that specifies "the coordinates of the rectangle’s origin"
							.opacity(geo.frame(in: .global).origin.y >= 200 ? 1 : geo.frame(in: .global).origin.y / 600)
							// Day 94 - Challenge #2
							/// Make views adjust their scale depending on their vertical position,
							/// with Views near the bottom being large and views near the top being small.
							/// Suggest going no smaller than 50% of the regular size.
							/// Use 'max()' to handle the scaling so that Views don’t go smaller than half their size
							.scaleEffect(max(0.5, (geo.frame(in: .global).minY / 1500 + 0.5)))
					}
					.frame(height: 40)
				}
			}
		}
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
