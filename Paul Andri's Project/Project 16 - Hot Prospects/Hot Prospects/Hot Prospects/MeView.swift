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
	
	// PROPERTIES STORING CORE IMAGE CONTEXT & A 'CIFilter' INSTANCE OF QR CODE GENERATOR
	let context = CIContext()
	let filter = CIFilter.qrCodeGenerator()
	
	
    var body: some View {
		NavigationView {
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
				
				// GENERATE & SHOW QR CODE IMAGE BY CALLING ON 'generateQRCode' METHOD
				VStack(alignment: .center) {
					Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
						.interpolation(.none) // TURN OFF IMAGE INTERPOLATION
						.resizable()
						.scaledToFit()
						.frame(width: 200, height: 200)
				}
			}
			.navigationTitle("Your Code")
		}
    }
	
	
	// METHOD TO GENERATE USER QR CODE FROM 'String' INPUT DATA, RETURNS AN 'UIImage'
	func generateQRCode(from string: String) -> UIImage {
		// CONVERT 'String' TYPE DATA INTO A 'Data' TYPE INPUT FOR CIFILTER 'message' PARAM VALUE
		filter.message = Data(string.utf8)
		
		// ATTEMPT TO READ AN OUTPUT IMAGE FROM CIFILTER'S 'outputImage'
		if let outputImage = filter.outputImage {
			// ATTEMPT TO CREATE A COREIMAGE FROM CIFILTER'S 'outputImage'
			if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
				// CONVERT COREIMAGE TO 'UIImage' & RETURN THE 'UIImage' (THE QR CODE IMAGE)
				return UIImage(cgImage: cgImg)
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
