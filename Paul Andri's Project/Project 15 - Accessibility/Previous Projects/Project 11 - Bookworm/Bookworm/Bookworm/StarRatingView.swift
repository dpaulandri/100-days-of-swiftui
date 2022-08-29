//
//  StarRatingView.swift
//  Bookworm
//
//  Created by Paul Andri on 08/12/2022.
//
// CUSTOM STAR RATING VIEW
// DAY 75 - ADD ACCESSIBILITY FUNCTIONS TO STAR RATING VIEW

import SwiftUI

struct StarRatingView: View {
    // '@Binding' PROPERTY TO STORE USER 'rating' VALUE
    /*
     '@Binding' Property Wrapper
     - Stores a mutable Value in a View that points to other Value from elsewhere-
     - Allow sharing of a local '@State' Property Data w/ another View
    */
    @Binding var rating: Int
    
    // PROPERTY TO STORE RATING LABEL'S STRING VALUE
    var label = ""
    
    // PROPERTY TO STORE MAXIMUM BOOK RATING POSSIBLE
    var maxRating = 5
    
    // STAR RATING IMAGE PROPERTIES
    var offImage: Image? // OPTIONAL 'Image' VIEW
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
        HStack {
            // IF 'label' PROPERTY IS NOT EMPTY
            if label.isEmpty == false {
                Text(label)
            }
            
            // FOREACH VIEW TO GENERATE THE "STAR RATING" TAP INPUT VIEW
            // '1..<maxRating + 1' ALLOWS RATING RANGE OF 1 - 5
            ForEach(1..<maxRating + 1, id: \.self) { number in
                // DISPLAY IMAGE CORRESPONDING TO THE 'number' VALUE
                image(for: number)
                    // TERNERY OPERATOR TO DETERMINE THE 'image' VIEW'S 'foregroundColor'
                    .foregroundColor(number > rating ? offColor : onColor)
                    // TAP GESTURE MODIFIER FOR USER RATING TAP INPUT ON THE 'image' VIEW
                    .onTapGesture {
                        // ASSIGN THE 'rating' PROPERTY VALUE ACCORDING TO THE 'image' THE USER TAPPED ON
                        rating = number
                    }
					// DAY 75:
					// METHOD ONE - ACCESSIBILITY TO TAP GESTURE ONLY
					/*
					/// 1. ADD MEANINGFUL ACCESSIBILITY LABEL
					/// USES TERNARY OPERATOR
					.accessibilityLabel("\(rating == 1 ? "1 star" : "\(number) stars")")
					/// 2. REMOVE IMAGE TRAIT FROM IMAGE VIEW
					.accessibilityRemoveTraits(.isImage)
					/// 3. CONDITIONALLY ADD BUTTON & SELECTED TRAIT TO VIEW
					/// '.isSelected' - WHAT IS CURRENTLY SELECTED (number = rating)
					.accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected])
					*/
            }
        }
		// DAY 75:
		// METHOD TWO - ACCESSIBILITY TO THE WHOLE HSTACK VIEW
		/// 1. GROUP ALL CHILD VIEW & IGNORE IT FROM VOICEOVER
		.accessibilityElement()
		/// 2. ADD CUSTOM ACCESSIBILITU LABEL
		.accessibilityLabel(label)
		/// 3. READ THE CONTROL VALUE BASED ON 'rating' PROPERTY VALUE
		.accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
		/// 4. ADD CUSTOM ADJUSTABLE SWIPE INPUT ACTION
		.accessibilityAdjustableAction { direction in
			switch direction {
			case .increment:
				if rating < maxRating { rating += 1 }
			case .decrement:
				if rating > 1 { rating -= 1 }
			default:
				break
			}
		}
    }
    
    
    // METHOD TO SELECT THE CORRECT ON/OFFIMAGE & COLOR
    func image(for number: Int) -> Image {
        // IF THE PASSED-IN 'number' VALUE IS GREATER THAN THE 'rating' PROPERTY VALUE
        if number > rating {
            // RETURN 'offImage'
            return offImage ?? onImage
        } else {
            // FOR EVERY OTHER CASES:
            return onImage
        }
    }
}



struct RatingScoreView_Previews: PreviewProvider {
    static var previews: some View {
        // PASS IN DUMMY CONSTANT BINDING RATING VALUE
        StarRatingView(rating: .constant(4))
    }
}
