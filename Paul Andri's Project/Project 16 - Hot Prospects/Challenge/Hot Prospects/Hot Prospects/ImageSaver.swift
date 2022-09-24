//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Paul Andri on 08/20/2022.
//
// PART OF DAY 64 - SAVE IMAGES TO USER'S PHOTO LIBRARY - 'UIImageWriteToSavedPhotosAlbum()'

import UIKit


// 'ImageSaver' OBJECT CLASS THAT SAVES IMAGE TO THE USER'S PHOTO LIBRARY
// INHERITS FROM 'NSObject' PARENT CLASS
class ImageSaver: NSObject {
	// AN OPTIONAL PROPERTY THAT IS A METHOD THAT DOES NOTHING (DOESN'T NOT ACCEPT NOR RETURN ANYTHING)
	var successHandler: (() -> Void)?
	// AN OPTIONAL PROPERTY THAT IS A METHOD (ACCEPT AN 'Error' VALUE, DOES NOT RETURN ANYTHING)
	var errorHandler: ((Error) -> Void)?
	
	
	// METHOD TO SAVE IMAGE TO USER'S PHOTOLIBRARY
	func writeToPhotoAlbum(image: UIImage) {
		// CALL 'UIImageWriteToSavedPhotosAlbum()' METHOD
		/// '#selector()' - a special Compiler Directive to make sure the "Method name" exists
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
	}
	
	
	// METHOD MARKED W/ '@objc' ATTRIBUTE
	/// Tells Swift to generate code that can be read by Objective-C
	/// this Method NEEDS to have a specific signature (list of Parameters) otherwise our code just won’t work
	@objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		// CHECK IF AN 'Error' VALUE HAS BEEN RECEIVED
		if let error = error {
			// CALL THE OPTIONAL 'errorHandler' PROPERTY METHOD AND PASS IN THE ERROR
			/// NOTE ON THE SYNTAX '?' FOR OPTIONAL PROPERTY METHOD
			errorHandler?(error)
		} else {
			/// IF NOT 'Error' VALUE IS RECEIVED,
			// CALL THE OPTIONAL 'successHandler' PROPERTY METHOD (DO NOTHING)
			/// NOTE ON THE SYNTAX '?' FOR OPTIONAL PROPERTY METHOD
			successHandler?()
		}
	}
}


// 'UIImageWriteToSavedPhotosAlbum()' METHOD EXPLAINS:
/*
UIImageWriteToSavedPhotosAlbum(
	image: UIImage,
	completionTarget: Any?,
	completionSelector: Selector?,
	contextInfo: UnsafeMutablePointer?
)
 
 Syntax Explanations:
 'completionTarget':
  - Point to an Object that handles the Method
  - The Object MUST be a Class that inherit from 'NSObject' parentClass.
  - Tell Swift what Method should be called when saving completes
 
 'completionSelector':
  - Pass the "Method name" (not an actual Method) that is called by 'completionTarget'
  - This "Method name" was used by Objective-C to find the actual code at runtime, which could then be run
  - That Method NEEDS to have a specific signature (list of Parameters) otherwise our code just won’t work
 
	 On Writing the Method:
	 For performance reasons, Swift prefers not to generate code in a way that Objective-C can read,
	 so we will need to:
	 1. Mark the method using a special Compiler Directive called '#selector', which asks Swift to make sure the "Method name" exists where we say it does.
	 2. Add an Attribute called '@objc' to the Method, which tells Swift to generate code that can be read by Objective-C.
 
 'contextInfo':
  - Helps identify one image save operation from another
  - We can provide any sort of 'UnsafeRawPointer' Data here,
  - 'UnsafeRawPointer' - a raw chunk of memory that Swift makes no guarantees about whatsoever
  - It will be passed back to us when our completion Method is called
*/
