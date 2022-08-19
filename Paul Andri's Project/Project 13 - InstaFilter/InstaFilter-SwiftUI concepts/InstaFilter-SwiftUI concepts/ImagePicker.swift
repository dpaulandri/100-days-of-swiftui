//
//  ImagePicker.swift
//  InstaFilter-SwiftUI concepts
//
//  Created by Paul Andri on 08/19/2022.
//
// PART OF DAY 63 - 'WRAPPING 'UIKit' 'UIViewController' IN SWIFTUI VIEW' MATERIAL

// IMPORT 'PhotosUI' & 'SwiftUI' FRAMEWORKS
import PhotosUI
import SwiftUI

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
