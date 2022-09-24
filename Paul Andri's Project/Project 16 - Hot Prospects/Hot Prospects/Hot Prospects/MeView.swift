//
//  MeView.swift
//  Hot Prospects
//
//  Created by Paul Andri on 09/23/2022.
//

// IMPORT CORE IMAGE & ITS BUILTIN FILTER TO GENERATE QR CODE
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
	// STATE PROPERTIES TO HOLD USER'S INFO
	@State private var name = ""
	@State private var emailAddress = ""
	
	// STATE PROPERTY TO STORE(CACHE) A QR CODE UIIMAGE
	@State private var qrCode = UIImage()
	
	// STATE PROPERTY TO TRACK ALERT WINDOW AFTER THE QR CODE IS SUCCESSFULLY SAVED
	@State private var showAlert = false
	
	// PROPERTIES STORING CORE IMAGE CONTEXT & A 'CIFilter' INSTANCE OF QR CODE GENERATOR
	let context = CIContext()
	let filter = CIFilter.qrCodeGenerator()
	
	
    var body: some View {
		NavigationView {
			VStack {
				VStack {
					// SHOW QR CODE IMAGE THAT ARE SAVED(CACHED) IN 'qrCode' STATE PROPERTY
					Image(uiImage: qrCode)
						.interpolation(.none) // TURN OFF IMAGE INTERPOLATION
						.resizable()
						.scaledToFit()
						.frame(width: 250, height: 250)
						.contextMenu {
							// CONTEXT MENU BUTTON TO SAVE QR CODE
							Button {
								// CREATE AN INSTANCE OF 'ImageSaver' CLASS
								let imageSaver = ImageSaver()
								
								// CALL 'writeToPhotoAlbum' METHOD FROM 'ImageSaver' CLASS
								/// SAVE 'qrCode' STATE PROPERTY QR CODE UIIMAGE INTO USER'S PHOTO LIBRARY
								imageSaver.writeToPhotoAlbum(image: qrCode)
								
								// TRIGGER ALERT WINDOW
								showAlert = true
							} label: {
								Label("Save QR Code", systemImage: "square.and.arrow.down")
							}
						}
				}
				.padding()
				.alert("QR Code", isPresented: $showAlert) {
					Button("Dismiss") { }
				} message: {
					Text("Successfully saved.")
				}
				
				// VSTACK FOR USER INPUT FORM
				VStack {
					Form {
						TextField("Name", text: $name)
						// 'textContentType()' Modifier for 'TextField' View.
						/// Tell iOS the kind of info that 'TextField is asking the user for;
						/// allowing iOS to provide auto-complete Data on behalf of the User.
							.textContentType(.name)
							.autocorrectionDisabled(true)
							.autocapitalization(.words)
							.font(.title)
						
						TextField("Email Address", text: $emailAddress)
						// 'textContentType()' Modifier for 'TextField' View.
						/// Tell iOS the kind of info that 'TextField is asking the user for;
						/// allowing iOS to provide auto-complete Data on behalf of the User.
							.textContentType(.emailAddress)
							.autocorrectionDisabled(true)
							.textInputAutocapitalization(.never)
							.keyboardType(.emailAddress)
							.font(.title)
					}
				}
			}
			.navigationTitle("Your Code")
			// CALL 'updateQRCode' METHOD WHENEVER THIS VIEW IS SHOWN
			.onAppear(perform: updateQRCode)
			// CALL 'updateQRCode' METHOD WHENEVER 'name' AND/OR 'emailAddress' STATE PROPERTY VALUE(S) CHANGED
			.onChange(of: name) { _ in updateQRCode() }
			.onChange(of: emailAddress) { _ in updateQRCode() }
		}
    }
	
	// METHOD TO UPDATE & CACHE QR CODE 'UIImage' TO 'qrCode' STATE PROPERTY
	func updateQRCode() {
		// GENERATE QR CODE IMAGE BY CALLING ON 'generateQRCode' METHOD
		qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
	}
	
	// METHOD TO GENERATE USER QR CODE FROM 'String' INPUT DATA, RETURNS AN 'UIImage'
	func generateQRCode(from string: String) -> UIImage {
		// CONVERT 'String' TYPE DATA INTO A 'Data' TYPE INPUT FOR CIFILTER 'message' PARAM VALUE
		filter.message = Data(string.utf8)
		
		// ATTEMPT TO READ AN OUTPUT IMAGE FROM CIFILTER'S 'outputImage'
		if let outputImage = filter.outputImage {
			// ATTEMPT TO CREATE A COREIMAGE FROM CIFILTER'S 'outputImage'
			if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
				/// STORE (CACHE) THE RESULTING 'UIImage' INTO 'qrCode' STATE PROPERTY
				qrCode = UIImage(cgImage: cgImg)
				// RETURN THE FINAL 'UIImage' (THE QR CODE IMAGE)
				return qrCode
			}
		}
		
		/// IF FAILED TO CREATE A 'UIimage' TYPE QR CODE  OUTPUT IMAGE;
		// RETURN AN 'UIimage' OF A 'SF Symbol' (OR AN EMPTY 'UIimage')
		return UIImage(systemName: "xmark.circle") ?? UIImage()
	}
}



struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
