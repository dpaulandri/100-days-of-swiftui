//
//  ContentView.swift
//  AccessibilityTechniques
//
//  Created by Paul Andri on 08/27/2022.
//

import SwiftUI

// INDENTIFY VIEWS W/ USEFUL "ACCESSIBILITY LABELS"
/*
 '.accessibilityLabel()'
 - Straight to the point
 - Read immediately

 Ex: "Delete"


 '.accessibilityHint()'
 - Provide info for the View's purpose
 - Read after a short delay

 Ex: "Deletes email from inbox"


 '.accessibilityAddTraits()'
 '.accessibilityRemoveTraits()'
 Provides/remove extra info (traits) about how the View works

 Ex:
 - '.isButton'
 - '.isImage'
 */
/*
struct ContentView: View {
	// PICTURE ARRAY PROPERTY
	let pictures = [
		"ales-krivec-15949",
		"galina-n-189483",
		"kevin-horstmann-141705",
		"nicolas-tissot-335096"
	]
	
	// ACCESSIBILITY LABEL STRING VALUE ARRAY PROPERTY
	/// CORESSPONDS TO THE PICTURE ARRAY INDEX ORDER
	let labels = [
		"Tulips",
		"Frozen tree buds",
		"Sunflower field",
		"Fireworks"
	]
	
	// STATE PROPERTY TO GENERATE RANDOM INT VALUE FOR THE INDEX OF 'pictures' ARRAY
	@State private var selectedPicture = Int.random(in: 0...3)
	
    var body: some View {
        // DRAW A RANDOM PICTURE FROM THE 'pictures' ARRAY
		/// USING THE INDEX # FROM 'selectedPicture' STATE PROPERTY
		Image(pictures[selectedPicture])
			.resizable()
			.scaledToFit()
			.onTapGesture {
				// GENERATE ANOTHER RANDOM INDEX# ON EACH TAP
				selectedPicture = Int.random(in: 0...3)
			}
			// ACCESSIBILITY LABEL MODIFIER W/ DYNAMIC STRING LABEL
			.accessibilityLabel(labels[selectedPicture])
			// ADD "BUTTON" TRAIT TO THE IMAGE VIEW
			///(BECAUSE OF THE IMAGE VIEW IS ALSO A TAPPABLE "BUTTON")
			.accessibilityAddTraits(.isButton)
			// REMOVE "IMAGE" TRAIT FROM THE IMAGE VIEW
			/// MAKE THE IMAGE VIEW BE READ AS A ONLY "BUTTON BY SCREEN READER
			.accessibilityRemoveTraits(.isImage)
	}
}
*/



// HIDE ACCESSIBILITY DATA
/*
struct ContentView: View {
	var body: some View {
		// WAYS TO HIDE VIEW FROM ACCESSIBILITY SYSTEM / VOICEOVER
		VStack {
			// 'Image(decorative: "image-name")'
			// HIDE IMAGE FROM SCREEN READER
			/*
			 Tells SwiftUI the Image View doesn't convey any info and should be ignored by VoiceOver.
			 However, added Accessibility Labels, important Traits & Hints will be read.
			 */
			Image(decorative: "nicolas-tissot-335096")
				.onTapGesture {
					print("Image")
				}
				.accessibilityLabel("Decorative Image")
				.accessibilityAddTraits(.isButton)
			
			
			// '.accessibilityHidden(true)' MODIFIER
			// MAKE ANY VIEW COMPLETELY INVISIBLE TO THE ACCESSIBILITY SYSTEM
			/// REGARDLESS OF WHAT TRAITS IT HAS
			Circle()
				.fill(.blue)
				.accessibilityLabel("Blue Circle Shape")
				.accessibilityAddTraits(.isButton)
				.accessibilityHidden(true)
		}
	}
}
*/

// GROUP ACCESSIBILITY DATA
/*
struct ContentView: View {
	var body: some View {
		// GROUPING ACCESSIBILITY ELEMENTS TO BE READ BY VOICEOVER
		VStack {
			Text("Your score is")
			Text("1000")
				.font(.title)
		}
		// '.accessibilityElement()' MODIFIER
		// COMBINE VSTACK VIEW'S CHILDREN VIEWS INTO A SINGLE ACCESSIBILITY ELEMENT
		/// READ AS ONE SENTENCE
		.accessibilityElement(children: .combine)
		
		
		// GROUPING ACCESSIBILITY ELEMENTS TO BE IGNORED BY VOICEOVER
		VStack {
			Text("Your score is")
			Text("1000")
				.font(.title)
		}
		// '.accessibilityElement()' MODIFIER
		// COMBINE VSTACK VIEW'S CHILDREN VIEWS INTO A SINGLE ACCESSIBILITY ELEMENT
		// ACCESSIBILITY SYSTEM WILL COMPLETELY IGNORE THE CHILDREN VIEWS
		.accessibilityElement()
		// .accessibilityElement(children: .ignore)
		/*
		 Note:
		 - '.ignore' is the default Parameter value for '.accessibilityElement()' MODIFIER
		 - '.accessibilityElement()' IS THE SAME AS '.accessibilityElement(children: .ignore)'
		*/
		// MANUALLY ADD ACCESSIBILITY LABEL	TO BE READ
		.accessibilityLabel("User Score readout")
	}
}
*/



// READ CONTROL VALUES
//
struct ContentView: View {
	// STATE PROPERTY TO STORE AN INT VALUE
	@State private var value = 10
	
	var body: some View {
		VStack {
			Spacer()
			
			Text("Value: \(value)")
				.font(.title)
			
			Spacer()
			
			// HSTACK VIEW FOR BUTTONS
			HStack {
				Spacer()
				
				Button {
					value -= 1
				} label: {
					Label("Decrement", systemImage: "minus")
						.foregroundColor(.white)
						.padding()
						.frame(width: 44, height: 44)
						.background {
							Circle()
								.fill(.red)
						}
						.labelStyle(.iconOnly)
				}
				
				Spacer()
				
				Button {
					value += 1
				} label: {
					Label("Increment", systemImage: "plus")
						.foregroundColor(.white)
						.padding()
						.frame(width: 44, height: 44)
						.background {
							Circle()
								.fill(.blue)
						}
						.labelStyle(.iconOnly)
				}
				
				Spacer()
			}
			
			Spacer()
		}
		// IGNORE THE VSTACK VIEW'S BUTTONS FOR VOICEOVER
		.accessibilityElement()
		// ADD CUSTOM ACCESSIBILITY LABEL FOR THE VSTACK VIEW
		.accessibilityLabel("Value")
		// SEPARATE THE BUTTON CONTROL'S VALUE FROM THE LABEL
		.accessibilityValue(String(value))
		// SPECIFY CUSTOM USER "SWIPE" INPUT ACTION
		// ONLY AVAILABLE FOR USER USING VOICEOVER/SCREENREADER ACCESSIBILITY SYSTEM
		.accessibilityAdjustableAction { direction in
			// DEFINE THE DIRECTION OF "SWIPING" FOR INCREASING & DECREASING VALUE
			// SWIPE UP: INCREASE, SWIPE DOWN: DECREASE
			switch direction {
			case .increment:
				value += 1
			case .decrement:
				value -= 1
			default:
				print("Not handled.")
			}
		}
	}
}
//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
