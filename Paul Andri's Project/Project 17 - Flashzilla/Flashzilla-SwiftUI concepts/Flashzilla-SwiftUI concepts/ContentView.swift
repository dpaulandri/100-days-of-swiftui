//
//  ContentView.swift
//  Flashzilla-SwiftUI concepts
//
//  Created by Paul Andri on 09/29/2022.
//

import SwiftUI

// DAY 86 MATERIALS
/*
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
/*
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
/*
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
*/
*/

*/



// DAY 87 MATERIALS
//
// TRIGGER EVENTS REPEATEDLY USING A "TIMER"
// 'Timer' Class & '.onReceive()' Modifier
/*
 'Timer' Class
 An iOS 'Foundation' core system library's built-in Class.
 Designed to run a Function after a certain number of seconds,
 but it can also run code repeatedly.

 Use w/ Apple's 'Combine' framework to add an Extension,
 so that "Timers" can become "Publishers"; things that announce when their value changes.
 
 The 'Timer' Class is “best effort” – the system makes no guarantee it will execute precisely.
*/
/*
struct ContentView: View {
	// CODE TO CREATE 'Timer' "PUBLISHER"
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	/// Code Logic:
	/*
	 1. It asks the 'Timer' to fire every "1 second".
	 2. It says the 'Timer' should run on the "main thread".
	 3. It says the 'Timer' should run on the "common run loop",
		which is the one you’ll want to use most of the time.
		("Run loops" lets iOS handle "running code while the user is actively doing something",
		such as scrolling in a 'List'.)
	 4. It "connects the 'Timer' immediately", which means it will start counting time.
	 5. It "assigns the whole thing to the 'Timer' constant" so that it stays alive.
	*/
	
	// AN EXAMPLE OF 'Timer' PUBLISHER'S 'tolerance' PARAMETER
	/*
	 Example code:
	 let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
	 
	 if you’re OK with your Timer having a little "float", you can specify some 'tolerance'.
	 This allows iOS to perform important energy optimization, because it can fire the Timer at any point "between its "scheduled fire time" and its "scheduled fire time" PLUS the 'tolerance' you specify".
	 
	 In practice this means the system can perform "Timer Coalescing":
	 It can "push back your Timer just a little so that it fires at the same time as one or more other Timers", which means it can keep the CPU idling more and save battery power.

	 If you need to keep time strictly then leaving off the 'tolerance' Parameter will make your Timer as accurate as possible, but please note that EVEN WITHOUT any 'tolerance' the 'Timer' Class is still “best effort” – the system makes no guarantee it will execute precisely.
	*/
	
	// TRACK HOW MANY TIME THE 'Timer' "PUBLISHER" CHANGE NOTIFICATION HAS BEEN RECEIVED
	@State private var counter = 0
	
	
	var body: some View {
		Text("Hello, world!")
			/// '.onReceive()' Modifier
			/*
			 '.onReceive()' Modifier
			 Accepts a "Publisher" as its first Parameter and a "Function" to run as its second.

			 It will make sure that "Function" is called whenever the "Publisher" sends its "Change Notification".
			*/
			.onReceive(timer) { time in
				if counter == 5 {
					/// Cancel the 'Timer' "Publisher" activity once 'counter' State reached '5'
					timer.upstream.connect().cancel()
					/// Code Explanation:
					/*
					 The 'timer' Property we made is an 'autoconnect' Publisher,
					 so we need to go to its 'upstream' Publisher to find the 'timer' itself.
					 From there we can 'connect' to the 'timer' Publisher, and ask it to "cancel" itself.
					*/
				} else {
					/// If the 'Timer' "Publisher" activity once 'counter' State HAS NOT reached '5';
					/// Print out every 1 second (ref. 'Timer' "Publisher" Property setting above)
					print("The time is now \(time)")
				}
				
				/// Increase  'counter' State value by '1' whenever a 'Timer' "PUBLISHER" Change Notification is received
				counter += 1
			}
	}
}
*/



// BE NOTIFIED WHEN SWIFTUI APP IS "ACTIVE" / "INACTIVE" / "MOVED TO THE BACKGROUND"
// '.scenePhase' Environment Value
/*
struct ContentView: View {
	// '.scenePhase' ENVIRONMENT VALUE
	@Environment(\.scenePhase) var scenePhase
	
	var body: some View {
		Text("Hello, world!")
			.padding()
			/// 'onChange()' Modifier watching value changes from App's '.scenePhase' Environment Value
			.onChange(of: scenePhase) { newPhase in
				if newPhase == .active {
					print("App is Active!")
				} else if newPhase == .inactive {
					print("App is Inactive!")
				} else if newPhase == .background {
					print("App is in the Background!")
				}
				/// Code Logic & Explanation:
				/*
				 There are three "Scene Phases" we need to care about:
				 • "Active scenes" are running right now, which on iOS means they are visible to the User. On macOS an App’s window might be wholly hidden by another App’s window, but that’s okay – it’s still considered to be "active".
				 • "Inactive scenes" are running and might be visible to the User, but the User isn’t able to access them.
					For example, if you’re swiping down to partially reveal the "Control Center" then the App underneath is considered inactive.
				 • "Background scenes" are not visible to the User, which on iOS means they might be terminated at some point in the future.
				 */
			}
	}
}
*/



// SUPPORTING SPECIFIC "ACCESSIBILITY" NEEDS - Accessibility Environment Values
//
// Accessibility Setting: "Differentiate without Color"
/*
 “Differentiate without color”, helpful for the 1 in 12 men who have Color Blindness.
 When this setting is enabled, Apps should try to make their UI clearer using Shapes, Icons, and Textures rather than Colors.
*/
/*
struct ContentView: View {
	// ENVIRONMENT VALUE TO READ iOS "Differentiate without Color" ACCESSIBILITY SETTING VALUE
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	
	var body: some View {
		HStack {
			if differentiateWithoutColor {
				Image(systemName: "checkmark.circle")
			}
			Text("Success")
		}
		.padding()
		.background(differentiateWithoutColor ? .black : .green)
		.foregroundColor(.white)
		.clipShape(Capsule())
	}
}
*/


// Accessibility Setting: "Reduce Motion"
/*
 When this is enabled, Apps should limit the amount of Animation that causes Movement on screen.
 For example, the iOS App Switcher makes views fade in and out rather than scale up and down.
*/
// METHOD 1: USES "ACCESSIBILITY" ENVIRONMENT VALUE W/O WRAPPER
/*
struct ContentView: View {
	// ENVIRONMENT VALUE TO READ iOS "Reduce Motion" ACCESSIBILITY SETTING VALUE
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	@State private var scale = 1.0
	
	var body: some View {
		Text("Hellow, World!")
			.scaleEffect(scale)
			.onTapGesture {
				if reduceMotion {
					scale *= 1.5
				} else {
					withAnimation {
						scale *= 1.5
					}
				}
			}
	}
}
*/


// METHOD 2: USES METHOD WRAPPER & UIKIT'S 'UIAccessibility' DATA
/*
// METHOD TO READ iOS 'UIAccessibility.isReduceMotionEnabled' SETTING VALUE
// METHOD MIGHT THROW ERROR, RETURNS SUITABLE 'Result' VALUE
/// Uses UKit’s 'UIAccessibility' Data
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
	/// If iOS "Reduce Motion" Accessibility Setting is Enabled
	if UIAccessibility.isReduceMotionEnabled {
		/// Return 'body' only (NO Animation)
		return try body()
	} else {
		/// Else, return 'body' w/ Default Animation
		return try withAnimation(animation, body)
	}
}

struct ContentView: View {
	// STATE PROPERTY TO TRACK SCALE FX'S SCALE AMOUNT
	@State private var scale = 1.0
	
	var body: some View {
		Text("Hellow, World!")
			.scaleEffect(scale)
			.onTapGesture {
				/// Call 'withOptionalAnimation' Method
				withOptionalAnimation {
					/// Multiply 'scale' State value by 1.5 with each User Tap Input
					scale *= 1.5
				}
			}
	}
}
*/


// Accessibility Setting: "Reduce Transparency"
/*
 When enabled, Apps should reduce the amount of "Blur" and "Translucency" used in their Designs to make doubly sure everything is clear.
*/
//
struct ContentView: View {
	// ENVIRONMENT VALUE TO READ iOS "Reduce Transparency" ACCESSIBILITY SETTING VALUE
	@Environment(\.accessibilityReduceTransparency) var reduceTransparency
	
	var body: some View {
		Text("Hello, world!")
			.padding()
			.background(reduceTransparency ? .black : .black.opacity(0.5))
			.foregroundColor(.white)
			.clipShape(Capsule())
	}
}
//

//

//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
