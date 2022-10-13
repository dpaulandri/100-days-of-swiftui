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
	///  Optionally accepts a 'Boolean' Parameter, returns 'Void' - Part of Day 91 - Challenge #3
	///  Defaulting to 'nil' so we don’t need to provide it unless it’s explicitly needed
	var removal: ((Bool) -> Void)? = nil
	
	/// Environment Property to read iDevice's "Differentiate Without Color" Accessibility setting
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	
	/// Environment Property to read iDevice's "VoiceOver" Accessibility setting
	@Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
	
	/// State Property to hide 'Card's 'answer' Property by default
	@State private var isShowingAnswer = false
	
	/// State Property for a new subClass of 'UINotificationFeedbackGenerator' (Haptic Feedback)
	@State private var feedback = UINotificationFeedbackGenerator()
	
	/// State Property to track how far the User has dragged the "Card"
	@State private var offset = CGSize.zero
	
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 25, style: .continuous)
				.fill(
					/* Paul Hudson's code
					/// Ternary Conditional Operator for 'fill' depending on iDevice's "Differentiate Without Color" Accessibility setting
					differentiateWithoutColor
					? .white
					: .white
					/// 'fill' Color will fade away as the User Drag/Swipe the Card away
					.opacity(1 - Double(abs(offset.width / 50)))
					/// '.opacity()' Code Explanation:
					/*
					• We’re going to take 1/50th of the "Drag" amount, so the card doesn’t fade out too quickly.
					• We don’t care whether they have moved to the left (negative numbers) or to the right (positive numbers), so we’ll put our value through the 'abs()' (Absolute number) Function.
					  If this is given a positive number it returns the same number, but if it’s given a negative number it removes the negative sign and returns the same value as a positive number.
					• We then use this result to subtract from '1'.
					*/
					*/
					.white
					/// 'fill' Color will fade away as the User Drag/Swipe the Card away
					.opacity(1 - Double(abs(offset.width / 50)))
					/// '.opacity()' Code Explanation:
					/*
					• We’re going to take 1/50th of the "Drag" amount, so the card doesn’t fade out too quickly.
					• We don’t care whether they have moved to the left (negative numbers) or to the right (positive numbers), so we’ll put our value through the 'abs()' (Absolute number) Function.
					  If this is given a positive number it returns the same number, but if it’s given a negative number it removes the negative sign and returns the same value as a positive number.
					• We then use this result to subtract from '1'.
					*/
				)
				.background(
					/* Paul Hudson's code
					/// Ternary Conditional Operator for 'background' depending on iDevice's "Differentiate Without Color" Accessibility setting
					differentiateWithoutColor
					? nil /// No background
					: RoundedRectangle(cornerRadius: 25, style: .continuous)
						/// Fill Color depends on User Drag/Swipe direction (Right = Green, Left = Red)
						.fill(offset.width > 0 ? .green : .red)
					*/
					/// Ternary Conditional Operator for 'background' depending on iDevice's "Differentiate Without Color" Accessibility setting
					differentiateWithoutColor
					? RoundedRectangle(cornerRadius: 25, style: .continuous)
						/// Fill Color depends on User Drag/Swipe direction (Right = White, Left = Black)
						/// Part of Day 91 - Challenge #2 - Card BG Colour bug fix
						.fill(offset.width == 0 ? .white : (offset.width > 0 ? .white : .black))
					: RoundedRectangle(cornerRadius: 25, style: .continuous)
						/// Fill Color depends on User Drag/Swipe direction (Right = Green, Left = Red)
						/// Part of Day 91 - Challenge #2 - Card BG Colour bug fix
						.fill(offset.width == 0 ? .white : (offset.width > 0 ? .green : .red))
				)
				/// Shadow is added to add depth & separate 'RoundedRectangle' from the Background
				.shadow(radius: 10)
			
			
			/// Question Prompt & Answer VStack View
			VStack {
				/// Show the suitable Text View depending on iDevice's "VoiceOver" Accessibility setting
				if voiceOverEnabled {
					/// Show the suitable Text View depending on 'isShowingAnswer' Program State
					Text(isShowingAnswer ? card.answer : card.prompt)
						.font(.largeTitle)
						.foregroundColor(.black)
				} else {
					Text(card.prompt)
						.font(.largeTitle)
						.foregroundColor(.black)
					
					/// Show 'answer' Text View only when 'isShowingAnswer' Property State is 'true'
					if isShowingAnswer {
						Text(card.answer)
							.font(.title)
							.foregroundColor(.gray)
						/// Ternary Conditional Operator for 'opacity' depending on "Differentiate Without Color" Accessibility setting
							.opacity(offset.width < 0 ? (differentiateWithoutColor ? (1 - Double(abs(offset.width / 50))) : 1) : 1)
						/// '.opacity()' Code Explanation:
						/*
						 • We’re going to take 1/50th of the "Drag" amount, so the card doesn’t fade out too quickly.
						 • We don’t care whether they have moved to the left (negative numbers) or to the right (positive numbers), so we’ll put our value through the 'abs()' (Absolute number) Function.
						 If this is given a positive number it returns the same number, but if it’s given a negative number it removes the negative sign and returns the same value as a positive number.
						 • We then use this result to subtract from '1'.
						 */
					}
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
		.accessibilityAddTraits(.isButton)
		.gesture(
			/// Updates 'offset' Property's 'CGSize' value as the User drags the "Card" around.
			DragGesture()
				.onChanged { gesture in
					/// Read the 'translation' Property to see where the User has dragged the "Card" to & set it as 'offset' value
					offset = gesture.translation
					
					/// Prepare & Wamup the Haptic Engine (reduces Haptic Feeback event latency)
					feedback.prepare()
				}
				.onEnded { _ in
					// Part of Day 91 - Challenge #3
					/// Add "Wrong" Card back into the "CardStack" Array to try again
					/// Check whether the User has dragged the "Card" more than 100 points in either direction
					if abs(offset.width) > 100 {
						/// TRIGGER HAPTICS FOR "WRONG" (DRAGGESTURE TO THE LEFT)
						if offset.width < 0 {
							/// Play '.error' Haptic feeback pattern if User Drag Gesture is to the LEFT
							feedback.notificationOccurred(.error)
							
							/// Put the Card back onto the Card Stack
							removal?(true)
							
							/// Set 'offset' Property 'CGSize' value back to '0'
							offset = .zero
						} else {
							/// Remove the "Card" by attempting to call 'removal' Closure (do nothing if failed)
							removal?(false)
						}
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
		/// This make the "Card" that are not fully "Swiped/Dragged" to return to the top w/ 'spring' Animation
		/// Watches the 'offset' State Property value
		.animation(.spring(), value: offset)
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
		CardView(card: Card.exampleCard)
    }
}
