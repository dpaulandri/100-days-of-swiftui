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
	
	/// Environment Property to read iDevice's "VoiceOver" Accessibility setting
	@Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
	
	/// Environment Property to read App's "Scene Phases"
	@Environment(\.scenePhase) var scenePhase
	/// State Property to track App's '.active" Scene Phase
	@State private var isActive = true
	
	/*
	 Swift’s Arrays have a helpful Initializer: 'init(repeating:count:)',
	 which takes one Value and Repeats it a number of times to create the Array
	*/
	/// State Property for an Array of 'Card' Object
	@State private var cards = DataHandler.loadData()
	
	/// State Property to track whether 'EditCardsView' is being shown
	@State private var showingEditScreen = false
	
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
					// Part of Day 91 - Challenge #3
					/// Add "Wrong" Card back into the "CardStack" Array to try again
					ForEach(Array(cards.enumerated()), id: \.element) { item in
						CardView(card: item.element) { putback in
							withAnimation {
								removeCard(at: item.offset, reinsert: putback)
							}
						}
						/// Call '.stacked()' 'View' Extension to offset 'CardView' in a "Card Stack"
						.stacked(at: item.offset, in: cards.count)
						/// Allow only the "top" Card on the "Card Stack" to be Interactive
						.allowsHitTesting(item.offset == cards.count - 1)
						/// HIde all but the "top" Card on the "Card Stack" from VoiceOver
						.accessibilityHidden(item.offset < cards.count - 1)
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
			
			
			/// '+' Button to show 'EditCardsView' VStack
			VStack {
				HStack {
					Spacer()
					
					Button {
						showingEditScreen = true
					} label: {
						Image(systemName: "plus.circle")
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(Circle())
					}
				}
				
				Spacer()
			}
			.foregroundColor(.white)
			.font(.largeTitle)
			.padding()
			
			
			/// IF iDevice's "Differentiate Without Color" OR "VoiceOver" Accessibility setting is ON:
			/// Show "Correct" & "Incorrect" Button VStack as the alternative Input Method
			if differentiateWithoutColor || voiceOverEnabled {
				VStack {
					Spacer()
					
					HStack {
						/// Button to mark Answer as "Wrong / Incorrect"
						Button {
							withAnimation {
								removeCard(at: cards.count - 1, reinsert: true)
							}
						} label: {
							HStack {
								Image(systemName: "xmark.circle")
								Image(systemName: "rectangle.lefthalf.inset.filled.arrow.left")
							}
							.font(.title3)
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(RoundedRectangle(cornerRadius: 25))
						}
						.accessibilityLabel("Wrong")
						.accessibilityHint("Mark answer as incorrect")
							
						Spacer()
						
						/// Button to mark Answer as "Correct"
						Button {
							withAnimation {
								removeCard(at: cards.count - 1, reinsert: false)
							}
						} label: {
							HStack {
								Image(systemName: "rectangle.righthalf.inset.filled.arrow.right")
								Image(systemName: "checkmark.circle")
							}
							.font(.title3)
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(RoundedRectangle(cornerRadius: 25))
						}
						.accessibilityLabel("Correct")
						.accessibilityHint("Mark answer as correct")
					}
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
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
		/// Sheet View to show 'EditCardsView'
		/// Code Logic & Explanations:
		/*
		'onDismiss' - attach a Function to the 'sheet' that'll run automatically when the 'sheet' is dismissed
		
		'content: EditCardsView.init' - pass the 'EditCardsView' initializer directly to the 'sheet':
		“When we want to read the 'content' for the 'sheet', call the 'EditCardsView' initializer and it will send you back the View to use.”
		 
		IMPORTANT:
		This approach only works because 'EditCardsView' has an initializer that accepts NO Parameters. If you need to pass in specific values you need to use the "closure-based" approach instead:
		 
		 .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
		   EditCards()
		 }
		*/
		.sheet(isPresented: $showingEditScreen, onDismiss: resetCardStack, content: EditCardsView.init)
		/// Perform 'resetCardStack' whenever the View appear
		.onAppear(perform: resetCardStack)
    }
	
	
	// Part of Day 91 - Challenge #3 - Add "Wrong" Card back into the "CardStack" Array to try again
	/// Method to remove 'Card' from "Card Stack"
	func removeCard(at index: Int, reinsert: Bool) {
		/// Check to make sure the "Card Stack" Index value is NOT lesser than '0', EXIT if "Card Stack" Index value is less than '0'
		guard index >= 0 else { return }
		
		/// Part of Day 91 - Challenge #3 - Add "Wrong" Card back into the "CardStack" Array to try again
		if reinsert {
			cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
		} else {
			/// Remove "Card" at its received 'index' Position
			cards.remove(at: index)
		}
		
		/// Conditionally stop the "Countdown Timer" when 'cards' Array is Empty
		if cards.isEmpty {
			isActive = false
		}
	}
	
	/// Method to Start New Game (Reset App Property State values)
	func resetCardStack() {
		timeRemaining = 99
		isActive = true
		/// Call 'loadData' Method to load saved "Card Stack" JSON Data from 'DocumentsDirectory'
		cards = DataHandler.loadData()
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
