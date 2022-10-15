//
//  ContentView.swift
//  Layout-Geometry
//
//  Created by Paul Andri on 10/14/2022.
//

import SwiftUI

// DAY 92 MATERIALS
/*
// HOW LAYOUT WORKS IN SWIFTUI
/*
/// PARENT-CHILD VIEW RELATIONSHIP, VIEW MODIFIER ORDER & "LAYOUT NEUTRAL" VIEW
/*
// 'ContentView' is the Child View to 'SwiftUI' Parent View
/// 'ContentView' is 'layout neutral':
/// The whole size of 'ContentView' == the whole content of 'body' Property (no more no less)
/// It doesn’t have any size of its own, and instead adjusts to fit whatever size is needed
struct ContentView: View {
    var body: some View {
		VStack {
			/// Modifier order #1
            Text("Hello, world!")
				.padding(20) /// Parent View of 'Text'
				.background(.red) /// Parent View of 'padding'
				/// "Backgrounds" are 'layout neutral'
			
			/// Modifier order #2
			Text("Hello, world!")
			/// "Backgrounds" are 'layout neutral'
				.background(.red) /// Parent View of 'Text'
				.padding(20) /// Parent View of 'background'
        }
    }
}
*/

/// LAYOUT NEUTRAL "SIDE EFFECTS"
/*
/// 1. If your View hierarchy is wholly 'layout neutral',
/// then it will automatically take up all available space
/*
struct ContentView: View {
	var body: some View {
		Color.red
		/// 'Color' VIew is Layout Neutral
		/// It will automatically take up all available space
	}
}
*/

/// 2. If we use '.frame()' on an 'Image' that isn’t resizable,
/// we get a larger 'frame' without the 'Image' inside changing size
/*
struct ContentView: View {
	var body: some View {
		Image("PaulAndri") /// Image View w/o '.resizable()' Modifier
			.frame(width: 300, height: 300)
	}
}
*/

*/

*/


// ALIGNMENT - 'alignment' PARAMETERS
/*
struct ContentView: View {
	var body: some View {
		/// 'alignment' parameter in '.frame()' Modifier
		/*
		Text("Live long and prosper")
			.frame(width: 300, height: 300, alignment: .topLeading)
			.offset(x: 50, y: 50)
		*/
		
		
		/// 'alignment' parameter in 'Stack' View
		//
		VStack {
			HStack(alignment: .bottom) {
				Text("Live")
					.font(.caption)
				Text("long")
				Text("and")
					.font(.title)
				Text("prosper")
					.font(.largeTitle)
			}
			
			/*
			 SwiftUI has two special Alignments that align Text on the baseline of either the first Child (.firstTextBaseline) or the last Child (.lastTextBaseline).
			 This will cause all Views in a Stack to be aligned on a single unified baseline, regardless of their font.
			 */
			HStack(alignment: .lastTextBaseline) {
				Text("Live")
					.font(.caption)
				Text("long")
				Text("and")
					.font(.title)
				Text("prosper")
					.font(.largeTitle)
			}
		}
		//
		
		
		
	}
}
*/


// ALIGNMENT GUIDES - '.alignmentGuide()' MODIFIER
/*
/*
 '.alignmentGuide()' Modifier takes two Parameters:
 1. the "Alignment guide" we want to change, and
 2. A Closure that returns a new "Alignment".
	The closure is given a 'ViewDimensions' Object that contains the Width and Height of its View,
	along with the ability to read its various Edges.
*/
struct ContentView: View {
	var body: some View {
		/// Common '.alignmentGuide()'
		/*
		VStack {
			/// '.alignmentGuide()' VSTACK
			VStack {
				VStack(alignment: .leading) {
					Text("Leading, Hello, world!")
						.alignmentGuide(.leading) { d in
							/// Uses the Text View's 'leading' side as the 'leading' edge of the Alignment Guide
							d[.leading]
						}
					Text("This is a longer line of text")
				}
				.background(.red)
				.frame(width: 400, height: 250)
				.background(.blue)
				
				
				VStack(alignment: .leading) {
					Text("Hello, world! Trailing")
						.alignmentGuide(.leading) { d in
							/// Uses the Text View's 'trailing' side as the 'leading' edge of the Alignment Guide
							d[.trailing]
						}
					Text("This is a longer line of text")
				}
				.background(.red)
				.frame(width: 400, height: 250)
				.background(.blue)
			}
			
			/// '.offset()' VSTACK (FOR COMPARISON ONLY)
			/*
			 If we 'offset' a 'Text' its original dimensions don’t actually change,
			 even though the resulting View is rendered in a different location.
			 the 'VStack' wouldn’t expand to contain it.
			*/
			VStack{
				Text("Hello, world! Trailing")
					.offset(x: -100, y: 0)
				Text("This is a longer line of text")
			}
			.background(.red)
			.frame(width: 400, height: 250)
			.background(.blue)
		}
		*/
		
		
		/// '.alignmentGuide()' w/ custom "Alignment" Closure
		VStack(alignment: .leading) {
			/// 'ForEach' Loop
			ForEach(0..<15) { position in
				Text("Number \(position)")
					/// '.alignmentGuide()' w/ custom "Alignment" Closure
					.alignmentGuide(.leading) { _ in
						CGFloat(position) * -10 ///(Tiered Effect)
						//CGFloat(240) /// Constant Value
						//CGFloat(-120) /// Constant Value
					}
			}
		}
		.background(.red)
		.frame(width: 400, height: 400)
		.background(.blue)
	}
}
*/


// CREATE CUSTOM ALIGNMENT GUIDE
/*
/// STEP 1: Create an extension for 'VerticalAlignment' (OR 'HorizontalAlignment')
extension VerticalAlignment {
	/// STEP 2: Create a custom Type 'enum' that conforms to 'AlignmentID' Protocol
	/// 'AlignmentID' - a Type that can be use to create custom "Alignment guides"
	enum MidAccountAndName: AlignmentID {
		/* The 'AlignmentID' protocol has only one requirement:
		 The conforming Type MUST provide a 'static defaultValue(in:)' Method that accepts a 'ViewDimensions' object and returns a 'CGFloat' specifying how a 'View' should be aligned if it doesn’t have an '.alignmentGuide()' Modifier.
		 
		 We'll be given the existing 'ViewDimensions' object for the 'View', we can either pick one of those for the 'default' or use a "hard-coded" value.
		*/
		static func defaultValue(in context: ViewDimensions) -> CGFloat {
			/// Pass back the '.top' Value from the passed-in 'ViewDimensions' context
			context[.top]
		}
	}
	
	/// STEP 3: Define 'MidAccountAndName' as an extension for 'VerticalAlignment'
	static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
	var body: some View {
		/// HStack is aligned based on the alignment of '.midAccountAndName'
		HStack(alignment: .midAccountAndName) {
			VStack {
				Text("@dpaulandri")
				Text("@dpaulandri")
					/// Custom '.alignmentGuide()' along '.midAccountAndName'
					/*
					 '.midAccountAndName' is only a "guide": it helps you align Views along a single line, but doesn’t say how they should be aligned.
					 This means we still need to provide the Closure to '.alignmentGuide()' that positions the Views along that guide as we want.
					*/
					.alignmentGuide(.midAccountAndName) {
						/// Align to the 'VerticalAlignment's 'center' position
						d in d[VerticalAlignment.center]
					}
				Image("PaulAndri")
					.resizable()
					.frame(width: 64, height: 64)
				Text("@dpaulandri")
				Text("@dpaulandri")
				Text("@dpaulandri")
			}
			
			VStack {
				Text("NAME")
				Text("NAME")
				Text("NAME")
				Text("PAUL ANDRI")
					/// Custom '.alignmentGuide()' along '.midAccountAndName'
					/*
					 '.midAccountAndName' is only a "guide": it helps you align Views along a single line, but doesn’t say how they should be aligned.
					 This means we still need to provide the Closure to '.alignmentGuide()' that positions the Views along that guide as we want.
					 */
					.alignmentGuide(.midAccountAndName) {
						/// Align to the 'VerticalAlignment's 'center' position
						d in d[VerticalAlignment.center]
					}
					.font(.largeTitle)
				Text("NAME")
				Text("NAME")
			}
		}
	}
}
*/

*/



// DAY 93 MATERIALS
//
// ABSOLUTE POSITIONING FOR SWIFTUI VIEWS - '.position()' Modifier
/*
/// '.position()' Modifier - Absolute Positioning vs '.offset()' Modifier - Relative Positioning
struct ContentView: View {
	var body: some View {
		VStack {
			// '.position()' View Modifier - "Absolute" Positioning
			Text("Hello, world!")
			/// '.position()' View take up ALL AVAILABLE SPACES in order to position its 'Text' Child View properly
				.position(x: 100, y: 100)
			/// '.background()' View take up ALL AVAILABLE SPACES in order to position its '.position()' Child View properly
				.background(.red)
				.frame(width: 300, height: 300)
			
			// 'offset()' View Modifier - "Relative" Positioning
			Text("Hello, world!")
			/// '.offset()' View take up ALL AVAILABLE SPACES in order to position its 'Text' Child View properly
				.offset(x: 100, y: 100)
			/// '.background()' View take up ALL AVAILABLE SPACES in order to position its '.position()' Child View properly
				.background(.red)
				.frame(width: 300, height: 300)
			
				// '.offset()' Modifier behaviour explanation:
				/*
				 When we use the '.offset()' Modifier, we’re changing the location where a View should be rendered without actually changing its underlying geometry. This means when we apply '.background()' afterwards it uses the original position of the 'Text' View, not its "offset".
				 
				 If you move the modifier order so that '.background()' comes before '.offset()' then things work more like you might have expected, showing once again that MODIFIER ORDER MATTERS.
				 */
		}
	}
}
*/


// 'GeometryReader' - UNDERSTANDING '.frame(in: )' & "SPACE COORDINATES"
/*
// BASIC 'GeometryReader'
/*
struct ContentView: View {
	var body: some View {
		VStack {
			// 'GeometryReader' return View that has a flexible "preferred size" (NOT ABSOLUTE), which means it will expand to take up more space as needed.
			GeometryReader { geo in
				/// 'geo' parameter is a 'GeometryProxy':
				/// Contains the proposed 'View' size, any "safe area insets" that have been applied, plus a Method for reading 'frame' values
				Text("Hello, world!")
					.frame(width: geo.size.width * 0.9)
					.background(.red)
			}
			.background(.green)
			
			Text("More text")
				.background(.yellow)
			Text("More text")
				.background(.gray)
			Text("More text")
				.background(.blue)
		}
	}
}
*/

// ADVANCED'GeometryReader' W/ 'GeometryProxy's '.frame(in: )' Method & '.coordinateSpace()' Modifier
/*
// '.frame(in: )' Method - Use to read the 'frame' value of a 'View'
// '.coordinateSpace()' Modifier - Use to create custom "Coordinate Spaces"
// SwiftUI "Coordinate Spaces":
/// - The "Global space" - measuring our View’s frame relative to the whole screen
/// - The "Local space" - measuring our View’s frame relative to its "Parent View"
/// - The "Custom Coordinate space" - measuring our View’s frame relative to a "Coordinate Space"

struct OuterView: View {
	var body: some View {
		VStack {
			Text("Top")
			InnerView()
				.background(.green)
			Text("Bottom")
		}
	}
}

struct InnerView: View {
	var body: some View {
		HStack {
			Text("Left")
			
			GeometryReader { geo in
				Text("Center")
					.background(.blue)
					.onTapGesture {
						/// Print the "Global space" frame center coordinate value
						/// Measuring our 'GeometryReader' View’s frame relative to the whole screen
						print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
						
						/// Print the "Local space" frame center coordinate value
						/// Measuring our 'GeometryReader' View’s frame relative to its "Parent View" ('InnerView')
						print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
						
						/// Print the "custom Coordinate space" frame center coordinate value
						/// Measuring our 'GeometryReader' View’s frame relative to 'OuterView' inside 'ContentView'
						print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
					}
			}
			.background(.orange)
			
			Text("Right")
		}
	}
}

struct ContentView: View {
	var body: some View {
		OuterView()
			.background(.red)
			/// Create custom "Coordinate Space"
			.coordinateSpace(name: "Custom")
	}
}
*/
*/



// 'GeometryReader' + 'SrollView' FXs
//
// SPINNING HELIX EFFECT
//
struct ContentView: View {
	let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
	
	var body: some View {
		GeometryReader { fullView in /// <- get the size of the Full Main View
			ScrollView {
				ForEach(0..<50) { index in
					GeometryReader { geo in
						Text("Row #\(index)")
							.font(.title)
							.frame(maxWidth: .infinity)
							.background(colors[index % 7]) /// '%' - Modulus / Remainder operator
							/// 3D Rotation FX Modifier
							.rotation3DEffect(
								/// '.minY' = "Top edge" of the View
								.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5,
								// axis: (x: 0, y: 1, z: 0)
								axis: (x: 0, y: 0, z: 1) /// Spin on both the 'y' Horizontal & 'z' Depth Axis
								/// Other axis examples:
								/*
								 // axis: (x: 1, y: 0, z: 0) /// Spin only on the 'x' Vertical Axis
								 // axis: (x: 0, y: 1, z: 0) /// Spin only on the 'y' Horizontal Axis
								 // axis: (x: 0, y: 0, z: 1) /// Spin only on the 'z' Depth Axis
								 */
							)
					}
					.frame(height: 40)
				}
			}
		}
	}
}
//


// COVER-FLOW STYLE SCROLLING EFFECT
/*
struct ContentView: View {
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 0) {
				ForEach(1..<20) { num in
					GeometryReader { geo in
						Text("Number \(num)")
							.font(.largeTitle)
							.padding()
							.background(.red)
							.rotation3DEffect(
								.degrees(-geo.frame(in: .global).minX) / 8,
								axis: (x: 0, y: 1, z: 0)
							)
							.frame(width: 200, height: 200)
					}
					.frame(width: 200, height: 200)
				}
			}
		}
	}
}
*/

//




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
