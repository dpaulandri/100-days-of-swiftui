//
//  ContentView.swift
//  Flashzilla-SwiftUI concepts
//
//  Created by Paul Andri on 09/29/2022.
//

import SwiftUI

// DAY 86 MATERIALS
//
// "GESTURES" IN SWIFTUI
/*
// 'onTapGesture()' & 'onLongPressGesture()' GESTURE MODIFIERS
/*
struct ContentView: View {
    var body: some View {
		// USER FINGER TOUCH INPUT GESTURES
		/// '.onTapGesture()' Modifier
		/*
		Text("Hello, world!")
		.padding()
		.onTapGesture(count: 2) {
			/// Print value if the Parent VIew is "double tapped"
			print("Double tapped!")
		}
		*/
		
		/// '.onLongPressGesture()' Modifier
		/*
		Text("Hello, world!")
		.padding()
		.onLongPressGesture {
			/// Print value if the Parent VIew is "long pressed"
			print("Long pressed!")
		}
		*/
		
		/// '.onLongPressGesture()' Modifier w/ 'minimumDuration'
		/*
		Text("Hello, world!")
		.padding()
		.onLongPressGesture(minimumDuration: 2) {
			/// Print value if the Parent VIew is "long pressed" (for at least 2 seconds)
			print("Long pressed!")
		}
		*/
		
		/// '.onLongPressGesture()' Modifier w/ 'minimumDuration' & 'onPressingChanged' Closure
		Text("Hello, world!")
		.padding()
		.onLongPressGesture(minimumDuration: 2) { /// The "Completion" Closure
			/// Print value if the Parent VIew is "long pressed" (for at least 2 seconds)
			print("Long pressed!")
		} onPressingChanged: { inProgress in /// The "Change" Closure
			print("In progress: \(inProgress)!")
		}
		/// Code Logic:
		/*
		 This will be given a single Boolean parameter as input, and it will work like this:
		 1. As soon as you press down the 'onPressingChanged' Closure will be called with its parameter set to 'true'.
		 2. If you release before the Gesture has been recognized (so, if you release after 1 second when
		 using a 2-second recognizer), the 'onPressingChanged' Closure will be called with its parameter set to 'false'.
		 3. If you hold down for the full length of the recognizer, then the 'onPressingChanged' Closure will be called with its parameter set to 'false' (because the Gesture is no longer "in flight"), and your "Completion" Closure will be called too.
		*/
    }
}
*/


// ADVANCED GESTURE W/ 'gesture()' MODIFIER + 'MagnificationGesture()' GESTURE STRUCT
/// A Gesture that recognizes a "Magnification ("pinching") motion" and tracks the amount of Magnification.
/*
struct ContentView: View {
	/// State Properties to track the current & final amount of Scale FX amount
	@State private var currentAmount = 0.0
	@State private var finalAmount = 1.0
	
	var body: some View {
		Text("Hello, world!")
			/// 'scaleEffect()' + 'MagnificationGesture()' Modifiers
			/// Pinch In & Out to scale/magnify the Parent View
			.scaleEffect(finalAmount + currentAmount)
			.gesture(
				MagnificationGesture()
					/// Whenever a "pinching" Gesture happen
					.onChanged { amount in
						/// Store the new amount of "pinching" value into 'currentAmount' State value
						currentAmount = amount - 1
					}
					/// Whenever a "pinching" Gesture ended
					.onEnded { amount in
						/// Add the 'currentAmount' value into the 'finalAmount' State value
						finalAmount += currentAmount
						/// Reset 'currentAmount' State value to 0, preparing for more "pinching" gesture input(s)
						currentAmount = 0
					}
			)
	}
}
*/


// ADVANCED GESTURE W/ 'gesture()' MODIFIER + 'RotationGesture()' GESTURE STRUCT
/// A Gesture that recognizes a "Rotation motion" and tracks the angle of the Rotation.
/*
struct ContentView: View {
	/// State Properties to track the current & final amount of "Rotation Angle" amount
	@State private var currentAmount = Angle.zero
	@State private var finalAmount = Angle.zero
	
	var body: some View {
		Text("Hello, world!")
			/// 'rotationEffect()' + 'RotationGesture()' Modifiers
			/// Rotate the Parent View w/ "Rotation Gesture"
			.rotationEffect(currentAmount + finalAmount)
			.gesture(
				RotationGesture()
					/// Whenever a "rotating" Gesture happen
					.onChanged { angle in
						/// Store the new amount of "angle" value into 'currentAmount' State value
						currentAmount = angle
					}
					/// Whenever a "rotating" Gesture ended
					.onEnded { angle in
						/// Add the 'currentAmount' value into the 'finalAmount' State value
						finalAmount += currentAmount
						/// Reset 'currentAmount' State value to '.zero', preparing for more "rotating" gesture input(s)
						currentAmount = .zero
					}
			)
	}
}
*/


// "GESTURES CLASH" & 'highPriorityGesture()' MODIFIER
/* SwiftUI will always give the "Child View’s" Gesture Priority by default,
 However, we can use the 'highPriorityGesture()' modifier to force the "Parent View"’s Gesture to trigger instead */
/*
struct ContentView: View {
	var body: some View {
		// PARENT VIEW
		VStack {
			// CHILD VIEW
			Text("Hello, world!")
				/// Child View Gesture Modifier
				.onTapGesture {
					print("Child View tapped!")
				}
		}
		/*
		/// Parent View Gesture Modifier
		.onTapGesture {
			print("Parent View tapped!")
		}
		*/
		/// Parent View 'highPriorityGesture()' modifier
		/// 'highPriorityGesture()' modifier causes the 'Parent View's Gesture modifier to be prioritise over its Child's
		.highPriorityGesture(
			TapGesture()
				.onEnded { _ in
					print("Parent View tapped!")
				}
		)
	}
}
*/


// "GESTURES CLASH" & 'simultaneousGesture()' MODIFIER
/* SwiftUI will always give the "Child View’s" Gesture Priority by default,
 However, we can use the 'simultaneousGesture()' modifier to tell SwiftUI we want both the "Parent" and "Child" Gestures to trigger at the same time */
/*
struct ContentView: View {
	var body: some View {
		// PARENT VIEW
		VStack {
			// CHILD VIEW
			Text("Hello, world!")
				/// Child View Gesture Modifier
				.onTapGesture {
					print("Child View tapped!")
				}
		}
		/*
		/// Parent View Gesture Modifier
		.onTapGesture {
			print("Parent View tapped!")
		}
		*/
		/// Parent View 'simultaneousGesture()' modifier
		/// 'simultaneousGesture()' modifier causes both the "Parent" & "Child" View's Gesture modifiers to trigger at the same time
		.simultaneousGesture(
			TapGesture()
				.onEnded { _ in
					print("Parent View tapped!")
				}
		)
	}
}
*/


// GESTURE SEQUENCES
/* SwiftUI lets us create "Gesture sequences",
 where one Gesture will only become active if another Gesture has first succeeded */
/*
struct ContentView: View {
	/// State Property to track how far the Circle has been dragged
	@State private var offset = CGSize.zero
	
	/// State Property to track whether the Circle is currently being dragged or not
	@State private var isDragging = false
	
	var body: some View {
		/// A 'DragGesture' that updates 'offset' & 'isDragging' State property as it moves around
		let dragGesture = DragGesture()
			.onChanged { value in offset = value.translation }
			.onEnded { _ in
				withAnimation {
					offset = .zero
					isDragging = false
				}
			}
		
		/// A 'LongPressGesture' that enables 'isDragging' State
		let longPressGesture = LongPressGesture()
			.onEnded { value in
				withAnimation {
					isDragging = true
				}
			}
		
		/// A "SEQUENCED GESTURE" that forces the User to perform 'LongPressGesture' then 'DragGesture'
		let sequencedGestures = longPressGesture.sequenced(before: dragGesture)
		
		/// An Interactive 'Circle' Shape
		Circle()
			.fill(.red)
			.frame(width: 200, height: 200)
			/// Scale up 150% whenever 'isDragging' state is 'true'
			.scaleEffect(isDragging ? 1.5 : 1)
			/// Offset the 'Circle' shape to whatever 'offset' value we had back from 'DragGesture'
			.offset(offset)
			/// Uses our 'sequencedGestures'
			.gesture(sequencedGestures)
	}
}
*/

*/



// "HAPTIC" VIBRATIONS W/ 'UINotificationFeedbackGenerator' (UIKit) & 'CoreHaptics'
/*
// 'UINotificationFeedbackGenerator' (UIKit, Simple Haptics)
/*
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
			/// Call 'simpleSuccessHaptic' Method whenever the View is tapped
			.onTapGesture(perform: simpleSuccessHaptic)
	}
	
	/// Method to generate 'UINotificationFeedbackGenerator' "Success" Haptic feedbacks
	func simpleSuccessHaptic() {
		let hapticGenerator = UINotificationFeedbackGenerator()
		hapticGenerator.notificationOccurred(.success)
		/// Other available '.notificationOccurred()' values: '.error' & '.warning'
	}
}
*/


// 'CoreHaptics' Framework (Advanced Haptics)
/*
/// Import 'CoreHaptics' Framework Module
import CoreHaptics

struct ContentView: View {
	/// State Property to store 'CHHapticEngine' Class Object Instance (Optional)
	/// This actual Object is responsible for creating the Haptic feeback's "vibrations"
	@State private var engine: CHHapticEngine?
	
	var body: some View {
		Text("Hello, world!")
			/// Call 'prepareHaptics' Method as soon and whenever the View appears
			.onAppear(perform: prepareHaptics)
			/// Call 'complexSuccessHaptics' Method whenever the View is tapped
			.onTapGesture(perform: complexSuccessHaptics)
	}
	
	/// Method to check the current iDevice for Haptics supports & prepare the Haptic engine for Haptic events
	func prepareHaptics() {
		/// Check if iDevice supports "Haptics" functionality, "Exit Method" if iDevice DOES NOT SUPPORT "Haptics"
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
		
		do {
			/// Try to create a new 'CHHapticEngine' Class Object Instance, to be stored in 'engine' State Property
			engine = try CHHapticEngine()
			/// Try to start the 'CHHapticEngine' to get ready for Haptic events
			try engine?.start()
		} catch {
			print("There was an error creating the Haptic engine: \(error.localizedDescription).")
		}
	}
	
	/// Method to generate ONE Intense & Sharp "Haptic Tap" (as "Success" Haptic feedback)
	func complexSuccessHaptics() {
		/// Check if iDevice supports "Haptics" functionality, "Exit Method" if iDevice DOES NOT SUPPORT "Haptics"
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
		
		// Create Empty 'CHHapticEvent' Array
		var events = [CHHapticEvent]()
		
		// Create ONE Intense & Sharp 'CHHapticEvent' & append it to 'events' Array
		let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
		let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
		let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
		events.append(event)
		
		// Convert 'events' into a "Haptic Pattern" & play it immediately
		do {
			let pattern = try CHHapticPattern(events: events, parameters: [])
			let player = try engine?.makePlayer(with: pattern)
			try player?.start(atTime: 0) // Start playing Haptic immediately
		} catch {
			print("Failed to play Haptic pattern: \(error.localizedDescription).")
		}
	}
	
	/// Experimental Method to generate several "Haptic Taps" of increasing & decreasing Intensity & Sharpness
	func hapticsExperiments() {
		/// Check if iDevice supports "Haptics" functionality, "Exit Method" if iDevice DOES NOT SUPPORT "Haptics"
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
		
		// Create Empty 'CHHapticEvent' Array
		var events = [CHHapticEvent]()
		
		// Create several 'CHHapticEvent' of increasing Intensity & Sharpness & append it to 'events' Array
		for i in stride(from: 0, to: 1, by: 0.1) {
			let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
			let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
			let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
			events.append(event)
		}
		
		// Create several 'CHHapticEvent' of decreasing Intensity & Sharpness & append it to 'events' Array
		for i in stride(from: 0, to: 1, by: 0.1) {
			let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
			let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
			let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
			// '1 + i' - Make these events happen AFTER the previous 'increasing' events (1 sec)
			events.append(event)
		}
		
		// Convert 'events' into a "Haptic Pattern" & play it immediately
		do {
			let pattern = try CHHapticPattern(events: events, parameters: [])
			let player = try engine?.makePlayer(with: pattern)
			try player?.start(atTime: 0) // Start playing Haptic immediately
		} catch {
			print("Failed to play Haptic pattern: \(error.localizedDescription).")
		}
	}
}
*/
*/


// DISABLE "USER INTERACTIVITY" - '.allowsHitTesting()' & '.contentShape()' Modifiers
// SwiftUI's User interactivity controls:
//
// '.allowsHitTesting()' Modifier
/// When this Modifier is attached to a View with its parameter set to 'false', the View isn’t tappable.
/*
struct ContentView: View {
	var body: some View {
		ZStack {
			Rectangle()
				.fill(.blue)
				.frame(width: 300, height: 300)
				.onTapGesture {
					print("Rectangle tapped!")
				}
			
			Circle()
				.fill(.red)
				.frame(width: 300, height: 300)
				.onTapGesture {
					print("Circle tapped!")
				}
				// '.allowsHitTesting()' Modifier
				.allowsHitTesting(false)
				/*
				 When this Modifier is attached to a View with its parameter set to 'false', the View isn’t tappable.
				 */
		}
	}
}
*/


// '.contentShape()' Modifier
/// Lets us specify the "tappable shape" of a View.
//
struct ContentView: View {
	var body: some View {
		/// Where the 'contentShape()' Modifier really becomes useful is w/  "tap" actions attached to Stacks with 'Spacer()',
		/// because by default SwiftUI won’t trigger actions when a Stack 'Spacer()' is tapped
		VStack {
			Text("Hello")
			Spacer()
				.frame(height: 100)
			Text("World")
		}
		/// 'contentShape()' Modifier
		.contentShape(Rectangle())
		.onTapGesture {
			print("VStack tapped!")
		}
	}
}
//
//

//



/*
//
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
		.padding()
	}
}
*/



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
