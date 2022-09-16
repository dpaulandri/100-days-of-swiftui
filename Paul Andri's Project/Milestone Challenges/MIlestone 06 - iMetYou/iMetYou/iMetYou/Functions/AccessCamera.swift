//
//  AccessCamera.swift
//  iMetYou
//
//  Created by Paul Andri on 09/16/2022.
//
// PART OF DAY 78 - LET USER TAKE NEW PHOTO FOR PROFILE PICTURE

import SwiftUI

// SWIFTUI STRUCT THAT CONFORMS TO 'UIViewControllerRepresentable' PROTOCOL
/*
 'UIViewControllerRepresentable' Protocol builds on SwiftUI's 'View' Protocol,
 which means the Struct we’re defining can be used inside a SwiftUI View hierarchy,
 However we don’t provide a 'body' Property because the View’s 'body' is the "View Controller" itself;
 it just shows whatever UIKit sends back.
*/
// Conforming to 'UIViewControllerRepresentable' Protocol does require us to fill in that Struct with two Methods:
///- 'makeUIViewController()': responsible for creating the initial "View Controller", and
///- 'updateUIViewController()': designed to let us update the "View Controller" when some SwiftUI State changes.
struct AccessCamera: UIViewControllerRepresentable {
	// BINDING PROPERTY W/ OPTIONAL 'UIImage' DATA TYPE
	/// CREATES A BINDING FROM 'ImagePicker' STRUCT UP TO WHATEVER CREATED IT INSTANCE (PARENT "View")
	@Binding var image: UIImage?
	
	// NESTED "COORDINATOR" CLASS, INHERITS FROM 'NSObject'CLASS
	// CONFORMS TO 'UINavigationControllerDelegate' & 'UIImagePickerControllerDelegate' PROTOCOLS
	/* REASON:
	 1. It makes the Class inherit from 'NSObject', which is the "parentClass" for almost everything in UIKit.
		REQUIRED FOR ALL OBJECTIVE-C RUNTIME.
		'NSObject' allows Objective-C to ask the Object what functionality it supports at runtime,
		which means the photo picker can say things like “hey, the user selected an image, what do you want to do?”
	*/
	/// ACTS AS THE BRIDGE BETWEEN THE UIKit's "View Controller" AND SwiftUI's "View"
	class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
		// PROPERTY THAT POINTS TO THE 'AccessCamera' "PARENT"
		///  TELL "COORDINATOR" WHAT IT'S "PARENT" IS, SO IT CAN MODIFY VALUES THERE DIRECTLY
		var parent: AccessCamera
		
		// CUSTOM INITIALIZER FOR 'Coordinator' CLASS
		init(_ parent: AccessCamera) {
			// ASSIGN THE INCOMING 'AccessCamera' STRUCT INTO 'parent' PROPERTY
			self.parent = parent
		}
		
		// METHOD TO READ THE RESPONSE FROM 'UIImagePickerController'
		/* This Method receives two Objects we care about:
			 1. The 'UIImagePickerController' that the user was interacting with,
			 2. '[UIImagePickerController]'-an Array of the users selections,
			 because it’s possible to let the user select multiple images at once.
		 */
		func picker(_ picker: UIImagePickerController, didFinishPicking cameraImage: [UIImagePickerController.InfoKey : Any]) {
			// STEP 1: TELL THE 'UIImagePickerController' "PICKER" TO DISMISS ITSELF (W/ ANIMATION)
			picker.dismiss(animated: true)
			
			// TRY TO CREATE AN UIIMAGE OBJECT FROM THE EDITED CAMERA IMAGE
			if let image = cameraImage[.editedImage] as? UIImage {
				// IF SUCCESS, SET THE UIIMAGE OBJECT AS THE UIIMAGE DATA FOR THE PARENT'S 'image' PROPERTY
				parent.image = image
			}
		}
	}
	
	// 'makeUIViewController()': responsible for creating some sort of initial "View Controller"
	/// METHOD TO CREATE 'UIImagePickerController'
	func makeUIViewController(context: Context) -> UIImagePickerController {
		/// 1. CREATE A NEW 'UIImagePickerController' INSTANCE
		let imageSource = UIImagePickerController()
		/// 2. CONFIGURE 'UIImagePickerController' TO GET THE IMAGE SOURCE FROM iDEVICE'S CAMERA (ALLOWS EDITING)
		imageSource.sourceType = .camera
		imageSource.allowsEditing = true
		imageSource.delegate = context.coordinator
		
		// RETURNS THE 'UIImagePickerController'
		return imageSource
	}
	
	// 'updateUIViewController()': designed to let us update the "View Controller" when some SwiftUI State changes
	/// NOT USED
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
	
	// METHOD TO CREATE & CONFIGURE AN INSTANCE OF "COORDINATOR" CLASS, RETURNS THE CREATED 'Coordinator'
	/// THIS METHOD IS AUTOMATICALLY CALLED  BY SWIFTUI WHENEVER AN INSTANCE OF 'AccessCamera' STRUCT IS CREATED
	/// PURPOSE: Tell 'AccessCamera' that it should have a "coordinator" to handle communication from 'UIImagePickerController'
	func makeCoordinator() -> Coordinator {
		// CREATE AN INSTANCE OF 'Coordinator' CLASS
		/// Passes the 'AccessCamera' Struct into the "coordinator"
		Coordinator(self)
	}
	
}
