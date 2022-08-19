//
//  ContentView.swift
//  InstaFilter-SwiftUI concepts
//
//  Created by Paul Andri on 08/18/2022.
//

import SwiftUI

// DAY 62 MATERIALS
/*
// HOW PROPERTY WRAPPERS BECOME STRUCTS:
/// PROPERTY WRAPPER ARE BACKED BY ITS STRUCT
/*
struct ContentView: View {
	// STATE PROPERTY W/ PROPERTY OBSERVERS
	/// PROPERTY OBSERVERS ARE ONLY TRIGGER WHEN A CHANGE IS MADE THE '@State' WRAPPER STRUCT
	@State private var blurAmount = 0.0 {
		/*willSet {
			print("Old blur amount is: \(blurAmount)")
			print("New blur amount is: \(newValue)")
		}*/
		
		didSet {
			print("New blur amount is: \(blurAmount)")
			print("Old blur amount is: \(oldValue)")
		}
	}
	
    var body: some View {
		VStack {
			Text("Hello, world!")
				.blur(radius: blurAmount)
			
			// SLIDER VIEW DOES NOT TRIGGERS THE '@State' STRUCT'S 'nonmutating set' SETTER:
			/// BECAUSE IT IS CHANGING THE BINDING VALUE OF 'blurAmount' PROPERTY ITSLEF
			/// NOT THE '@State' WRAPPER STRUCT THAT WRAPS THE 'blurAmount' PROPERTY
			Slider(value: $blurAmount, in: 0...20)
			
			// BUTTON VIEW TRIGGERS THE '@State' STRUCT'S 'nonmutating set' SETTER:
			/// BECAUSE IT IS CHANGING THE '@State' WRAPPER STRUCT THAT WRAPS THE 'blurAmount' PROPERTY
			Button {
				blurAmount = Double.random(in: 0...20)
			} label: {
				Text("Random Blur")
					.foregroundColor(.white)
					.padding()
					.background {
						Capsule()
							.fill(.blue)
					}
			}
		}
		.padding()
    }
}
*/



// 'onChange()' MODIFIER
/// RUN A FUNCTION WHEN A PARTICULAR PROPERTY VALUE CHANGES
/// CAN BE ATTACH ANYWHERE IN OUR VIEW'S HIERARCHY
/*
struct ContentView: View {
	// STATE PROPERTY
	@State private var blurAmount = 0.0
	
	var body: some View {
		VStack {
			Text("Hello, world!")
				.blur(radius: blurAmount)
			
			Slider(value: $blurAmount, in: 0...20)
			
			Button {
				blurAmount = Double.random(in: 0...20)
			} label: {
				Text("Random Blur")
					.foregroundColor(.white)
					.padding()
					.background {
						Capsule()
							.fill(.blue)
					}
			}
			
		}
		.padding()
		/// ONCHANGE MODIFIER FOR PROPERTY 'blurAmount' VALUE CHANGES
		.onChange(of: blurAmount) { newValue in
			print("New Value is: \(newValue)")
		}
	}
}
*/



// 'confirmationDialog()' MODIFIER
/// AN ALTERNATIVE FOR 'alert()' MODIFIER
/// CONFIRMATION DIALOG VIEW SLIDES UP FROM THE BOTTOM W/ MULTIPLE BUTTONS
/*
struct ContentView: View {
	@State private var showConfirmation = false
	@State private var backgroundColor = Color.white
	
	var body: some View {
		Text("Hello, world!")
			.frame(width: 300, height: 300)
			.background(backgroundColor)
			.clipShape(RoundedRectangle(cornerRadius: 12))
			.onTapGesture {
				showConfirmation = true
			}
			/// CONFIRMATION DIALOG MODIFIER TO CHANGE 'backgroundColor' STATE PROPERTY VALUE
			.confirmationDialog("Change Background", isPresented: $showConfirmation) {
				Button("Red") { backgroundColor = Color.red }
				Button("Yellow") { backgroundColor = Color.yellow }
				Button("Green") { backgroundColor = Color.green }
				Button("Default") { backgroundColor = Color.white }
				Button("Cancel", role: .cancel) { }
			} message: {
				Text("Select a color")
			}
	}
}
*/
*/



// DAY 63 MATERIALS
//
// INTEGRATING 'CoreImage' W/ SWIFTUI
/// 'CoreImage' - Apple's framework for manipulation Image files; applying image sharpening, blurs, vignettes, etc.
/*
// IMPORT 'CoreImage' & 'CoreImage.CIFilterBuiltins' FRAMEWORKS
/// Filters are the things that do the actual work of transforming Image Data
import CoreImage
import CoreImage.CIFilterBuiltins /// 'CoreImage' BUILT-IN FILTERS


struct ContentView: View {
	/// STATE PROPERTY OF 'Image?' DATA TYPE
	@State private var image: Image?
	
	var body: some View {
		VStack {
			// DRAW 'image' IMAGE PROPERTY (OPTIONAL)
			/// WILL BE DRAWN IF 'image' VALUE EXIST
			image?
				/// 'image' PROPERTY MODIFIERS
				.resizable()
				.scaledToFit()
		}
		/// VSTACK VIEW MODIFIER
		.onAppear(perform: loadImage)
	}
	
	// METHOD TO LOAD 'UIImage' USING 'image' PROPERTY
	func loadImage() {
		// STEP01: TRY TO CREATE AN 'UIImage' IMAGE DATA USING AN IMAGE FILE
		guard let inputImage = UIImage(named: "PaulAndri-Memoji.jpeg") else { return }

		// STEP02: CREATE A 'CIImage' IMAGE DATA USING 'inputImage' ('UIImage')
		let beginImage = CIImage(image: inputImage)
		
		// STEP03: CREATE AN 'CGImage' CONTEXT
		let context = CIContext()
		
		// STEP04: DEFINE 'CIFilter' FILTER TYPE TO USE
		// EXAMPLES OF DIFFERENT 'CIFilter'
		/*
		/// EX. FILTER: 'CIFilter.sepiaTone()'
		let currentFilter = CIFilter.sepiaTone()
		
		// STEP 05: CUSTOMISE 'CIFilter' FILTER RECIPE SETTINGS:
		/// USE 'beginImage' 'CIImage' IMAGE DATA AS THE 'CIFilter'S INPUT IMAGE
		currentFilter.inputImage = beginImage
		 /// STATIC WAY TO DEFINE 'CIFIlter'S FILTER RECIPE:
		currentFilter.intensity = 1 /// '1' - FULL INTENSITY
		 
		 
		/// EX. FILTER: 'CIFilter.pixellate()'
		let currentFilter = CIFilter.pixellate()
		 
		// STEP 05: CUSTOMISE 'CIFilter' FILTER RECIPE SETTINGS:
		/// USE 'beginImage' 'CIImage' IMAGE DATA AS THE 'CIFilter'S INPUT IMAGE
		currentFilter.inputImage = beginImage
		 /// STATIC WAY TO DEFINE 'CIFIlter'S FILTER RECIPE:
		currentFilter.scale = 15 /// DEFINE THE PIXEL SCALE
		 
		 
		/// EX. FILTER: 'CIFilter.crystallize()'
		let currentFilter = CIFilter.crystallize()
		 
		// STEP 05: CUSTOMISE 'CIFilter' FILTER RECIPE SETTINGS:
		/// USE 'beginImage' 'CIImage' IMAGE DATA AS THE 'CIFilter'S INPUT IMAGE
		currentFilter.inputImage = beginImage
		 /// STATIC WAY TO DEFINE 'CIFIlter'S FILTER RECIPE:
		currentFilter.radius = 100 /// DEFINE THE CRYSTAL RADIUS
		*/
		/// EX. FILTER: 'CIFilter.twirlDistortion()'
		let currentFilter = CIFilter.twirlDistortion()
		
		// STEP 05: CUSTOMISE 'CIFilter' FILTER RECIPE SETTINGS:
		/// USE 'beginImage' 'CIImage' IMAGE DATA AS THE 'CIFilter'S INPUT IMAGE
		currentFilter.inputImage = beginImage
		
		/// STATIC WAY TO DEFINE 'CIFIlter'S FILTER RECIPE:
		// DEFINE THE TWIRL DISTORTION FX CENTER
		currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
		
		/// DYNAMIC WAY TO DEFINE 'CIFIlter'S FILTER RECIPE:
		/// STEP A: CREATE PROPERTIES TO HOLD  VALUES
		let amount = 5.0
		let radius = 1000
		
		/// STEP B: CREATE A PROPERTY TO QUERY CURRENTLY SELECTED 'CIFilter' FILTER RECIPE'S INPUT KEYS
		let inputKeys = currentFilter.inputKeys
		
		/// STEP C: CONDITIONAL 'CIFilter' FILTER RECIPE VALUE SETTINGS
		/// CONDITON 1: IF THE 'CIFIlter' CONTAINS FILTER INTENSITY KEY
		if inputKeys.contains(kCIInputIntensityKey) {
			/// SET 'amount' PROPERTY VALUE AS ITS VALUE
			currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
		}
		/// CONDITON 2: IF THE 'CIFIlter' CONTAINS FILTER RADIUS KEY
		if inputKeys.contains(kCIInputRadiusKey) {
			/// SET 'radius' PROPERTY VALUE AS ITS VALUE
			currentFilter.setValue(radius, forKey:kCIInputRadiusKey)
		}
		/// CONDITON 3: IF THE 'CIFIlter' CONTAINS FILTER SCALE KEY
		if inputKeys.contains(kCIInputScaleKey) {
			/// SET 'amount' PROPERTY VALUE AS ITS VALUE
			currentFilter.setValue(amount * 10, forKey:kCIInputScaleKey)
		}
		
		
		// STEP 06: TRY TO APPLY THE 'CIFilter' FILTER TO THE IMAGE & OUTPUT A SWIFTUI 'Image' VIEW:
		/// 6A. GET A 'CIImage' OUTPUT IMAGE FROM 'currentFilter' FILTER, EXIT IF FAILS
		guard let outputImage = currentFilter.outputImage else { return }
		
		/// 6B. ATTEMPT TO CREATE A 'CGImage' FROM OUR 'outputImage' ('CIImage') USING 'CIContext()'
		///  'from: outputImage.extent' MEANT THE FULL-SIZE OF 'outputImage' FILTER RECIPE
		if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
			/// 6B.1 CONVERT THE 'cgImg' ('CGImage') INTO AN 'UIImage'
			let uiImage = UIImage(cgImage: cgImg)
			
			/// 6B.2 CONVERT 'uiImage' ('UIImage') INTO A SWIFTUI 'Image'
			/// THE RESULTING SWIFTUI 'Image' OUTPUT IS ASSIGNED AS THE NEW 'image' STATE PROPERTY VALUE
			image = Image(uiImage: uiImage)
		}
	}
}
*/



// WRAPPING 'UIKit' 'UIViewController' IN SWIFTUI VIEW
/// WORK IN CONJUCTION W/ 'ImagePicker' VIEW STRUCT
//
struct ContentView: View {
	// STATE PROPERTY OF OPTIONAL 'Image' VIEW
	@State private var image: Image?
	
	// STATE PROPERTY FOR SHOWING 'ImagePicker' VIEW
	@State private var showImagePicker = false
	
	
	var body: some View {
		VStack {
			// DRAW 'image' IMAGE PROPERTY (OPTIONAL)
			/// WILL BE DRAWN IF 'image' VALUE EXIST
			image?
				.resizable()
				.scaledToFit()
			
			/// BUTTON TO SHOW 'ImagePicker' VIEW
			Button {
				// SET 'true' BOOL VALUE TO 'showImagePicker' STATE PROPERTY
				showImagePicker = true
			} label: {
				Text("Select Image")
					.foregroundColor(.white)
					.padding()
					.background {
						Capsule()
							.fill(.blue)
					}
					.frame(width: 200, height: 50)
			}
		}
		// VSTACK VIEW MODIFIERS
		.sheet(isPresented: $showImagePicker) {
			// CALL 'ImagePicker' VIEW
			ImagePicker()
		}
	}
}
//
 
//

/*
//
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
	}
}
//

//
//
struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
	}
}
*/


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
