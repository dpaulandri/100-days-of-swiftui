//
//  ContentView.swift
//  InstaFilter
//
//  Created by Paul Andri on 08/20/2022.
//

// IMPORT 'CoreImage' API & ITS BUILT-IN FILTERS MODULE
import CoreImage
import CoreImage.CIFilterBuiltins

import SwiftUI

struct ContentView: View {
	// IMAGE PROPERTIES:
	/// STATE PROPERTY FOR STORING OPTIONAL 'Image' DATA
	@State private var image: Image?
	/// STATE PROPERTY TO STORE USER SELECTED PICTURE AS FILTER INPUT IMAGE
	@State private var inputImage: UIImage?
	/// STATE PROPERTY TO STORE 'CIFilter' PROCESSED 'UIImage' DATA
	@State private var processedImage: UIImage?
	
	// 'CoreImage' FILTER RELATED STATE PROPERTIES:
	/// STATE PROPERTY TO STORE CHOSEN 'CIFilter' TYPE
	@State private var currentFilter: CIFilter = CIFilter.sepiaTone()
	/// STATE PROPERTY TO TRACK WHETHER FILTER 'confirmationDialog' VIEW IS CURRENTLY SHOWN
	@State private var showFilterSheet = false
	
	// PART OF DAY 67 - CHALLENGE #2:
	/// STATE PROPERTY FOR STORING 'CoreImage' FILTER "RADIUS" VALUE
	@State private var filterRadius = 50.0
	/// STATE PROPERTY FOR STORING 'CoreImage' FILTER "SCALE" VALUE
	@State private var filterScale = 5.0
	/// STATE PROPERTY FOR STORING 'CoreImage' FILTER "SATURATION" VALUE
	@State private var filterSaturation = 50.0
	/// STATE PROPERTY FOR STORING 'CoreImage' FILTER "INTENSITY" VALUE
	@State private var filterIntensity = 0.5
	
	
	// 'CoreImage'S CONTEXT PROPERTY
	let context = CIContext()
	
	// STATE PROPERTY TO TRACK WHETHER 'PHPickerView' IS CURRENTLY SHOWN
	@State private var showingImagePicker = false
	
	
    var body: some View {
		NavigationView {
			VStack {
				// ZSTACK VIEW FOR DRAWING 'image' & BACKGROUND
				ZStack {
					// RECTANGLE AS BACKGROUND CANVA
					Rectangle()
						.fill(.secondary)
					
					// VISIBLE ONLY WHEN 'image' STATE PROPERTY HAS NO VALUE
					Text("Tap to select a picture")
						.foregroundColor(.white)
						.font(.headline)
					
					// DRAW 'image' IF IT HAS AN 'Image' VALUE
					image?
						.resizable()
						.scaledToFit()
				}
				// ZSTACK MODIFIER
				// ONTAPGESTURE TO TRIGGER IMAGE PICKER
				.onTapGesture {
					// SET 'showingImagePicker' PROPERTY STATE TO 'true' ON TAP
					/// TRIGGERS IMAGE PICKER
					showingImagePicker = true
				}
				
				
				// DAY 67 - CHALLENGE #2 - MORE THAN ONE FILTER INPUT KEY SLIDER VALUE INPUT
				// VSTACK FOR CONDITIONAL SLIDER INPUT FOR 'CoreImage' FILTER KEY VALUES
				VStack {
					// CONDITIONAL HSTACK FOR 'CoreImage' FILTER "RADIUS" KEY VALUE
					if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
						HStack {
							Text("Radius")
							Slider(value: $filterRadius, in: 0...200)
							/// ONCHANGE MODIFIER FOR SLIDER VIEW
							/// WATCH FOR ANY VALUE CHANGES IN 'filterRadius' STATE PROPERTY
							/// CALL 'applyProcessing()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
							/// '_ in' - IGNORE THE INPUT
								.onChange(of: filterRadius) { _ in applyProcessing() }
						}
						.padding()
					}
					
					// CONDITIONAL HSTACK FOR 'CoreImage' FILTER "SCALE" KEY VALUE
					if currentFilter.inputKeys.contains(kCIInputScaleKey) {
						HStack {
							Text("Scale")
							Slider(value: $filterScale, in: 0...200)
							/// ONCHANGE MODIFIER FOR SLIDER VIEW
							/// WATCH FOR ANY VALUE CHANGES IN 'filterScale' STATE PROPERTY
							/// CALL 'applyProcessing()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
							/// '_ in' - IGNORE THE INPUT
								.onChange(of: filterScale) { _ in applyProcessing() }
						}
						.padding()
					}
					
					// CONDITIONAL HSTACK FOR 'CoreImage' FILTER "SATURATION" KEY VALUE
					if currentFilter.inputKeys.contains(kCIInputSaturationKey) {
						HStack {
							Text("Saturation")
							Slider(value: $filterSaturation, in: 0...200)
							/// ONCHANGE MODIFIER FOR SLIDER VIEW
							/// WATCH FOR ANY VALUE CHANGES IN 'filterSaturation' STATE PROPERTY
							/// CALL 'applyProcessing()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
							/// '_ in' - IGNORE THE INPUT
								.onChange(of: filterSaturation) { _ in applyProcessing() }
						}
						.padding()
					}
					
					// CONDITIONAL HSTACK FOR 'CoreImage' FILTER "INTENSITY" KEY VALUE
					if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
						HStack {
							Text("Intensity")
							Slider(value: $filterIntensity)
							/// ONCHANGE MODIFIER FOR SLIDER VIEW
							/// WATCH FOR ANY VALUE CHANGES IN 'filterIntensity' STATE PROPERTY
							/// CALL 'applyProcessing()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
							/// '_ in' - IGNORE THE INPUT
								.onChange(of: filterIntensity) { _ in applyProcessing() }
						}
						.padding()
					}
				}
						
			}
			.padding([.horizontal, .bottom])
			.navigationTitle("InstaFilter")
			.toolbar {
				// CHANGE 'CoreImage' FILTER TYPE BUTTON
				ToolbarItem(placement: .bottomBar) {
					Button {
						// TOGGLE 'showFilterSheet' BOOL STATE
						/// TRIGGERS 'confirmationDialog' SHEET VIEW TO CHOOSE A NEW 'CIFilter'
						showFilterSheet = true
					} label: {
						Label("Select Filter", systemImage: "camera.filters")
							.labelStyle(.titleAndIcon)
					}
				}
				
				// SAVE IMAGE BUTTON
				/// CONTAINS CODE FOR  DAY 67 - CHALLENGE #1
				ToolbarItem(placement: .primaryAction) {
					Button {
						saveImage()
					} label: {
						Label("Save Image", systemImage: "square.and.arrow.down")
							.labelStyle(.iconOnly)
					}
					// DAY 67 - CHALLENGE #1 - DISABLE SAVE BUTTON IF 'image' STATE PROPERTY IS 'nil'
					.disabled(image == nil)
				}
			}
			// ONCHANGE MODIFIER;
			/// WATCH FOR ANY VALUE CHANGES IN 'inputImage' STATE PROPERTY
			/// CALL 'loadImage()' METHOD WHEN IT DID, INVOKING VIEW REDRAW
			/// '_ in' - IGNORE THE INPUT
			.onChange(of: inputImage) { _ in loadImage() }
			// SHEET VIEW BINDED TO 'showingImagePicker' PROPERTY STATE
			.sheet(isPresented: $showingImagePicker) {
				// CREATE AN 'ImagePicker' STRUCT INSTANCE FOR 'PHPickerViewController'
				ImagePicker(image: $inputImage)
			}
			// CONTAINS CODE FOR DAY 67 - CHALLENGE #3 - ADD 3 MORE 'CIFilter' TYPES
			// CONFIRMATIONDIALOG SHEET MODIFIER (CHOOSE FILTER TYPE)
			.confirmationDialog("Select a Filter", isPresented: $showFilterSheet) {
				// ASSORTED SELECTION OF 'CIFilter' TYPES (NON-EXHAUSTIVE)
				/// 'MAX 10 CHILDVIEW' LIMIT APPLIES!
				Button("Pixellate") { setFilter(CIFilter.pixellate()) }
				Button("Crystallize") { setFilter(CIFilter.crystallize()) }
				Button("Motion Blur") { setFilter(CIFilter.motionBlur()) }
				Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
				Button("Color Control") { setFilter(CIFilter.colorControls()) }
				Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
				Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
				Button("Vignette") { setFilter(CIFilter.vignette()) }
				Button("Morphology Gradient") { setFilter(CIFilter.morphologyGradient()) }
				Button("Cancel", role: .cancel) { }
			}
			
		}
    }
	
	
	// METHOD TO LOAD & PREPARE USER SELECTED IMAGE (IN 'inputImage' STATE PROPERTY) FOR FILTERING
	func loadImage() {
		/// TRY TO GET THE FILTER INPUT IMAGE FROM 'inputImage' STATE PROPERTY, EXIT IF FAIL
		guard let inputImage = inputImage else { return }
		
		/// TRY TO CONVERT 'inputImage' VALUE FROM 'UIImage' INTO 'CIImage' TYPE
		let beginImage = CIImage(image: inputImage)
		
		/// SET 'beginImage' AS THE 'CIImage' DATA FOR OUR CURRENT 'CIFilter' TO WORK WITH
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		
		/// CALL 'applyProcessing' METHOD
		applyProcessing()
	}
	
	// METHOD TO SAVE 'CIFIlter' PROCESSED IMAGE TO USER'S PHOTO LIBRARY
	func saveImage() {
		/// CHECK WHETHER THERE'S AN 'UIImage' VALUE IN 'processedImage' STATE PROPERTY, EXIT IF FAIL
		guard let processedImage = processedImage else { return }
		
		/// CREATE A NEW 'ImageSaver' OBJECT CLASS
		let imageSaver = ImageSaver()
		
		/// CALL 'ImageSaver' OBJECT CLASS' OPTIONAL PROPERTY METHOD 'successHandler'
		imageSaver.successHandler = {
			/// PRINT MESSAGE TO DEBUG CONSOLE
			print("Successfully saved!")
		}
		
		/// CALL 'ImageSaver' OBJECT CLASS' OPTIONAL PROPERTY METHOD 'successHandler'
		imageSaver.errorHandler = {
			/// PRINT LOCALIZED ERROR MESSAGE TO DEBUG CONSOLE
			print("Failed to save! \($0.localizedDescription)")
		}
		
		/// PASS-IN 'processedImage' ('UIImage') DATA TO BE SAVED USING THE OBJECT CLASS' 'writeToPhotoAlbum()' METHOD
		imageSaver.writeToPhotoAlbum(image: processedImage)
	}
	
	// METHOD TO APPLY FILTER PROCESSING TO THE 'inputImage' AND ASSIGN ITS RESULT TO 'image' STATE PROPERTY
	/// CONTAIN PART OF CODES FOR DAY 67 - CHALLENGE #2
	func applyProcessing() {
		// CONDITIONAL 'CIFilter' INPUT KEY SET VALUE SETTINGS:
		/// GET THE LIST OF FILTER INPUT KEYS SUPPORTED BY THE CURRENT 'CIFilter'
		let inputKeys = currentFilter.inputKeys
		
		/// IF CURRENT 'CIFilter' SUPPORT "Radius" KEY
		if inputKeys.contains(kCIInputRadiusKey) {
			// PART OF DAY 67 - CHALLENGE #2
			/// SET 'filterRadius' PROPERTY VALUE  AS CURRENT 'CoreImage' FILTER'S 'kCIInputRadiusKey' VALUE
			currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
		}
		/// IF CURRENT 'CIFilter' SUPPORT "Scale" KEY
		if inputKeys.contains(kCIInputScaleKey) {
			// PART OF DAY 67 - CHALLENGE #2
			/// SET 'filterScale' PROPERTY VALUE AS CURRENT 'CoreImage' FILTER'S 'kCIInputScaleKey' VALUE
			currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
		}
		/// IF CURRENT 'CIFilter' SUPPORT "Saturation" KEY
		if inputKeys.contains(kCIInputSaturationKey) {
			// PART OF DAY 67 - CHALLENGE #2
			/// SET 'filterSaturation' PROPERTY VALUE  AS CURRENT 'CoreImage' FILTER'S 'kCIInputScaleKey' VALUE
			currentFilter.setValue(filterSaturation, forKey: kCIInputSaturationKey)
		}
		/// IF CURRENT 'CIFilter' SUPPORT "Intesity" KEY
		if inputKeys.contains(kCIInputIntensityKey) {
			/// SET 'filterIntensity' PROPERTY VALUE AS CURRENT 'CoreImage' FILTER'S 'kCIInputIntensityKey' VALUE
			currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
		}
		
		
		// CHECK TO MAKE SURE THAT THERE'S AN OUTPUT IMAGE FROM THE FILTER
		guard let outputImage = currentFilter.outputImage else { return }
		
		// TRY TO CREATE A 'CGImage' USING 'outputImage' VALUE
		/// 'from: outputImage.extent' THE WHOLE SIZE SCOPE OF 'outputImage'
		if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
			// IF SUCCESSFUL, CREATE AN 'UIImage' USING 'cgImg' (CGImage) VALUE
			let uiImage = UIImage(cgImage: cgImg)
			
			// ASSIGN THE 'CIFilter' PROCESSED 'uiImage' DATA TO 'processedImage' STATE PROPERTY
			/// THIS 'UIImage' WILL BE THE PASSED INTO 'UIImageWriteToSavedPhotosAlbum'() METHOD
			processedImage = uiImage
			
			// CREATE AN 'Image' USING 'uiImage' VALUE AND SET THE VALUE TO 'image' STATE PROPERTY
			image = Image(uiImage: uiImage)
		}
	}
	
	// METHOD TO SET NEW 'CIFilter' VALUE TO 'currentFilter' STATE PROPERTY
	func setFilter(_ filter: CIFilter) {
		// SET NEW 'CIFilter' VALUE TO 'currentFilter' STATE PROPERTY
		currentFilter = filter
		// CALL 'loadImage' TO TRIGGER 'image' REDRAW, REFLECTING THE NEW 'CIFilter' TYPE
		loadImage()
	}
	
}



// PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
