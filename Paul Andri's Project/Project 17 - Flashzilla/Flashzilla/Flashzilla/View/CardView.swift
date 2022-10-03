//
//  CardView.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/03/2022.
//

import SwiftUI

struct CardView: View {
	/// 'Card' Object Property
	let card: Card
	
	/// Closure Parameter Property for "Card" removal (might or might not have a Value)
	///  Optionally accepts NO parameter, returns 'Void'
	///  Defaulting to 'nil' so we don’t need to provide it unless it’s explicitly needed
	var removal: (() -> Void)? = nil
	
	/// State Property to hide 'Card's 'answer' Property by default
	@State private var isShowingAnswer = false
	
	/// State Property to track how far the User has dragged the "Card"
	@State private var offset = CGSize.zero
	
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 25, style: .continuous)
				.fill(.white)
				.shadow(radius: 10)
				/// Shadow is added to add depth & separate 'RoundedRectangle' from the Background
			
			VStack {
				Text(card.prompt)
					.font(.largeTitle)
					.foregroundColor(.black)
				
				/// Show 'answer' Text View only when 'isShowingAnswer' Property State is 'true'
				if isShowingAnswer {
					Text(card.answer)
						.font(.title)
						.foregroundColor(.gray)
				}
			}
			.padding()
			.multilineTextAlignment(.center)
		}
		.frame(width: 450, height: 250)
		/*
		 Tip: A width of 450 is no accident:
		 The smallest iPhones have a landscape width of 480 points
		 so this means our card will be fully visible on all devices.
		*/
		
		/// '.rotationEffect()', '.offset()' & '.opacity()' Modifiers based on User Drag Gesture input value ( 'offset' State Property)
		.rotationEffect(.degrees(Double(offset.width / 5)))
		.offset(x: offset.width * 5, y: 0)
		.opacity(2 - Double(abs(offset.width / 50)))
		/// '.opacity()' Code Explanation:
		/*
		 • We’re going to take 1/50th of the "Drag" amount, so the card doesn’t fade out too quickly.
		 • We don’t care whether they have moved to the left (negative numbers) or to the right
		 (positive numbers), so we’ll put our value through the 'abs()' (Absolute number) Function.
		 If this is given a positive number it returns the same number, but if it’s given a negative number it removes the negative sign and returns the same value as a positive number.
		 • We then use this result to subtract from '2'.
		*/
		
		.gesture(
			/// Updates 'offset' Property's 'CGSize' value as the User drags the "Card" around.
			DragGesture()
				.onChanged { gesture in
				/// Read the 'translation' Property to see where the User has dragged the "Card" to & set it as 'offset' value
					offset = gesture.translation
				}
				.onEnded { _ in
					/// Check whether the User has dragged the "Card" more than 100 points in either direction
					if abs(offset.width) > 100 {
						/// Remove the "Card" by attempting to call 'removal' Closure (do nothing if failed)
						removal?()
					} else {
						/// Set 'offset' Property 'CGSize' value back to '0'
						offset = .zero
					}
				}
		)
		.onTapGesture {
			/// Toggle 'isShowingAnswer' Property's Bool State
			isShowingAnswer.toggle()
		}
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView(card: Card.exampleCard)
    }
}
