//
//  ImagePicker.swift
//  InstaFilter-SwiftUI concepts
//
//  Created by Paul Andri on 08/19/2022.
//

// IMPORT 'PhotosUI' & 'SwiftUI' FRAMEWORKS
import PhotosUI
import SwiftUI

// PART OF DAY 64 MATERIAL - USING "COORDINATORS" TO MANAGED SWIFTUI "View Controllers"
// SWIFTUI STRUCT THAT CONFORMS TO 'UIViewControllerRepresentable' PROTOCOL
// UPGRADED 'ImagePicker' STRUCT FROM DAY 63'S
/*
 'UIViewControllerRepresentable' Protocol builds on SwiftUI's 'View' Protocol,
 which means the Struct we’re defining can be used inside a SwiftUI View hierarchy,
 However we don’t provide a 'body' Property because the View’s 'body' is the "View Controller" itself;
 it just shows whatever UIKit sends back.
*/
// Conforming to 'UIViewControllerRepresentable' Protocol does require us to fill in that Struct with two Methods:
///- 'makeUIViewController()': responsible for creating the initial "View Controller", and
///- 'updateUIViewController()': designed to let us update the "View Controller" when some SwiftUI State changes.
struct ImagePicker: UIViewControllerRepresentable {
	// BINDING PROPERTY W/ OPTIONAL 'UIImage' DATA TYPE
	/// CREATES A BINDING FROM 'ImagePicker' STRUCT UP TO WHATEVER CREATED IT INSTANCE (PARENT "View")
	@Binding var image: UIImage?
	
	// ADDED NESTED-CLASS - FROM DAY 64 MATERIAL - USING "COORDINATORS" TO MANAGED SWIFTUI "View Controllers"
	// NESTED "COORDINATOR" CLASS, INHERITS FROM 'NSObject'CLASS  & CONFORMS TO 'PHPickerViewControllerDelegate' PROTOCOL
	/* REASONS:
	 1. It makes the Class inherit from 'NSObject', which is the "parentClass" for almost everything in UIKit.
		REQUIRED FOR ALL OBJECTIVE-C RUNTIME.
		'NSObject' allows Objective-C to ask the Object what functionality it supports at runtime,
		which means the photo picker can say things like “hey, the user selected an image, what do you want to do?”
	 2. It makes the Class conform to the 'PHPickerViewControllerDelegate' Protocol,
		which is what adds functionality for detecting when the user selects an image.
		('NSObject' lets Objective-C check for the functionality; this Protocol is what actually provides it.)
	*/
	/// ACTS AS THE BRIDGE BETWEEN THE UIKit's "View Controller" AND SwiftUI's "View"
	class Coordinator: NSObject, PHPickerViewControllerDelegate {
		// PROPERTY THAT POINTS TO THE 'ImagePicker' "PARENT"
		///  TELL "COORDINATOR" WHAT IT'S "PARENT" IS, SO IT CAN MODIFY VALUES THERE DIRECTLY
		var parent: ImagePicker
		
		// CUSTOM INITIALIZER FOR 'Coordinator' CLASS
		init(_ parent: ImagePicker) {
			// ASSIGN THE INCOMING 'ImagePicker' STRUCT INTO 'parent' PROPERTY
			self.parent = parent
		}
		
		// METHOD TO READ THE RESPONSE FROM 'PHPickerViewController'
		/* This Method receives two Objects we care about:
			 1. The 'PHPickerViewController' that the user was interacting with,
			 2. '[PHPickerResult]'-an Array of the users selections,
			 because it’s possible to let the user select multiple images at once.
		 */
		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
			// STEP 1: TELL THE 'PHPickerViewController' "PICKER" TO DISMISS ITSELF (W/ ANIMATION)
			picker.dismiss(animated: true)
			
			// STEP 2: TRY TO READ AN 'iteamProvider' FROM THE RECEIVED '[PHPickerResult]'
			/// EXIT METHOD IF "EMPTY"
			guard let provider = results.first?.itemProvider else { return }
			
			// STEP 3: IF STEP 2 IS SUCCESSFUL, TRY TO LOAD & USE THE SELECTED IMAGE(S) AS 'UIImage' TYPE OBJECT
			if provider.canLoadObject(ofClass: UIImage.self) {
				provider.loadObject(ofClass: UIImage.self) { image, _ in
					// ASSIGN LOADED 'UIImage' OBJECT AS 'ImagePicker' STRUCT'S 'image' PROPERTY DATA
					/// 'as? UIImage' - ATTEMPTS TO CONVERT 'image' TO AN 'UIImage' OBJECT;
					/// RETURNS 'nil' IF FAILED TO CONVERT
					self.parent.image = image as? UIImage
				}
			}
		}
	}
	
	// 'makeUIViewController()': responsible for creating some sort of initial "View Controller"
	/// METHOD TO CREATE 'PHPickerViewController'
	func makeUIViewController(context: Context) -> PHPickerViewController {
		/// 1. CREATE A NEW PHOTO PICKER CONFIGURATION
		var config = PHPickerConfiguration()
		/// 2. APPLY FILTER TO LIMIT 'PHPickerConfiguration'  TO ONLY  IMAGE FILES
		config.filter = .images
		
		/// CREATE A 'PHPickerViewController' THAT DOES THE ACTUAL WORK OF SELECTING IMAGE
		let picker = PHPickerViewController(configuration: config)
		
		// ADDED "DELEGATE" CONFIG TO 'PHPickerViewController' - FROM DAY 64 MATERIAL - USING "COORDINATORS" ...
		/// “Delegates” - Objects that respond to events that occur elsewhere
		/// PURPOSE: Tell 'PHPickerViewController' that whenever something happens it should tell our "coordinator"
		picker.delegate = context.coordinator
		
		// RETURNS THE 'PHPickerViewController'
		return picker
	}
	
	// 'updateUIViewController()': designed to let us update the "View Controller" when some SwiftUI State changes
	/// NOT USED FOR PROJECT 13: INSTAFILTER PROJECT
	func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
	
	// ADDED METHOD - FROM DAY 64 MATERIAL - USING "COORDINATORS" TO MANAGED SWIFTUI "View Controllers"
	// METHOD TO CREATE & CONFIGURE AN INSTANCE OF "COORDINATOR" CLASS, RETURNS THE CREATED 'Coordinator'
	/// THIS METHOD IS AUTOMATICALLY CALLED  BY SWIFTUI WHENEVER AN INSTANCE OF 'ImagePicker' STRUCT IS CREATED
	/// PURPOSE: Tell 'ImagePicker' that it should have a "coordinator" to handle communication from 'PHPickerViewController'
	func makeCoordinator() -> Coordinator {
		// CREATE AN INSTANCE OF 'Coordinator' CLASS
		/// Passes the 'ImagePicker' Struct into the "coordinator"
		Coordinator(self)
	}
	
}


// PART OF DAY 63 MATERIAL - 'WRAPPING 'UIKit' 'UIViewController' IN SWIFTUI VIEW' MATERIAL
// SWIFTUI STRUCT THAT CONFORMS TO 'UIViewControllerRepresentable' PROTOCOL
/* (SUPERCEEDED BY THE UPGRADED VERSION (DAY 64))
// STRUCT THAT CONFORMS TO 'UIViewControllerRepresentable' PROTOCOL
/*
 'UIViewControllerRepresentable' Protocol builds on SwiftUI's 'View' Protocol,
 which means the Struct we’re defining can be used inside a SwiftUI View hierarchy,
 However we don’t provide a 'body' Property because the View’s 'body' is the "View Controller" itself;
 it just shows whatever UIKit sends back.
*/
// Conforming to 'UIViewControllerRepresentable' Protocol does require us to fill in that Struct with two Methods:
///- 'makeUIViewController()': responsible for creating the initial "View Controller", and
///- 'updateUIViewController()': designed to let us update the "View Controller" when some SwiftUI State changes.
struct ImagePicker: UIViewControllerRepresentable {
	// HACK CODE TO MAKE XCODE AUTO GENERATE THE PROTOCL STUBS BELOW BY "FIXING" THE PROBLEM
	///typealias UIViewControllerType = PHPickerViewController
	
	// 'makeUIViewController()': responsible for creating the initial "View Controller"
	func makeUIViewController(context: Context) -> PHPickerViewController {
		/// 1. CREATE A NEW PHOTO PICKER CONFIGURATION
		var config = PHPickerConfiguration()
		/// 2. APPLY FILTER TO LIMIT 'PHPickerConfiguration'  TO ONLY  IMAGE FILES
		config.filter = .images
		
		/// CREATE & RETURNS A 'PHPickerViewController' THAT DOES THE ACTUAL WORK OF SELECTING IMAGE
		let picker = PHPickerViewController(configuration: config)
		return picker
	}
	
	// 'updateUIViewController()': designed to let us update the "View Controller" when some SwiftUI State changes
	func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
		/// NOT USED FOR PROJECT 13: INSTAFILTER PROJECT
	}
}
 */
