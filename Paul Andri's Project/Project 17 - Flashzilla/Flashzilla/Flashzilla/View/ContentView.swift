//
//  ContentView.swift
//  Flashzilla
//
//  Created by Paul Andri on 10/03/2022.
//

import SwiftUI

struct ContentView: View {
	/// Environment Property to read iDevice's "Differentiate Without Color" Accessibility setting
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	
	/// Environment Property to read App's "Scene Phases"
	@Environment(\.scenePhase) var scenePhase
	/// State Property to track App's '.active" Scene Phase
	@State private var isActive = true
	
	/*
	 Swift’s Arrays have a helpful Initializer: 'init(repeating:count:)',
	 which takes one Value and Repeats it a number of times to create the Array
	*/
	/// State Property for an Array of 'Card' Object
	@State private var cards = [Card](repeating: Card.exampleCard, count: 10)
	
	/// Properties for "Timer" function
	@State private var timeRemaining = 99
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	
    var body: some View {
		/// Bottom 'ZStack'
		ZStack {
			/// App Background Image
			Image(decorative: "background")
				.resizable()
				.ignoresSafeArea()
			
			/// Show "Swipe Direction Info" VStack if iDevice's "Differentiate Without Color" Accessibility setting is ON
			if differentiateWithoutColor {
				VStack {
					HStack {
						HStack {
							Image(systemName: "xmark.circle")
							Image(systemName: "rectangle.lefthalf.inset.filled.arrow.left")
						}
						.font(.title3)
						.padding()
						.background(.black.opacity(0.7))
						.clipShape(RoundedRectangle(cornerRadius: 25))
							
						Spacer()
						
						HStack {
							Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
							Image(systemName: "checkmark.circle")
						}
						.font(.title3)
						.padding()
						.background(.black.opacity(0.7))
						.clipShape(RoundedRectangle(cornerRadius: 25))
					}
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
				}
			}
			
			/// 'VStack' containing 'Timer' and "3D Card Stack"
			VStack {
				Text("Time: \(timeRemaining)")
				/// Modifies the text view’s font to use "fixed-width digits", while leaving other characters proportionally spaced.
					.monospacedDigit()
					.font(.largeTitle)
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 5)
					.background(.black.opacity(0.75))
					.clipShape(Capsule())
				
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
				/// Conditionally Allow View's User Interativity / Input
				.allowsHitTesting(timeRemaining > 0)
				
				/// Conditionally show Button View if 'cards' Array is empty, call 'resetCardStack' Method
				if cards.isEmpty {
					Button("Start Again", action: resetCardStack)
						.padding()
						.background(.white)
						.foregroundColor(.black)
						.clipShape(Capsule())
				}
			}
		}
		/// 'onReceive' Modifier, receiving Change Notifications from 'timer' Property's Publisher
		.onReceive(timer) { time in
			/// Check for 'isActive' Property's Bool State, Exit Closure if 'false' (the App is NOT in the ".active" Scene Phase)
			guard isActive else { return }
			/// This causes the following codes to pause whenever the App is NOT in the ".active" Scene Phase
			
			/// This 'if' statement adds a trivial Condition to make sure 'timeRemaining' value NEVER stray into negative number
			if timeRemaining > 0 {
				timeRemaining -= 1
			}
		}
		/// 'onChange' Modifier, reacting to changes of the App's 'scenePhase' Environment value
		.onChange(of: scenePhase) { newPhase in
			if newPhase == .active {
				/// If 'cards' Array is NOT empty, ensure "Countdown Timer" behave as expected
				if cards.isEmpty == false {
					isActive = true
				}
			} else {
				isActive = false
			}
		}
    }
	
	/// Method to remove 'Card' from "Card Stack"
	func removeCard(at index: Int) {
		cards.remove(at: index)
		
		/// Conditionally stop the "Countdown Timer" when 'cards' Array is Empty
		if cards.isEmpty {
			isActive = false
		}
	}
	
	/// Method to Start New Game (Reset App Property State values)
	func resetCardStack() {
		cards = [Card](repeating: Card.exampleCard, count: 10)
		timeRemaining = 99
		isActive = true
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
