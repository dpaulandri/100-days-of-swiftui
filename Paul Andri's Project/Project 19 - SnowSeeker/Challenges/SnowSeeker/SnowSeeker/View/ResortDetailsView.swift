//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//

import SwiftUI

struct ResortDetailsView: View {
	/// View will receive a 'Resort' object in its initializer
	let resort: Resort
	
	/// Computed 'String' Property corresponding to the 'Resort' object's 'size' value
	var size: String {
		switch resort.size {
		case 1:
			return "Small"
		case 2:
			return "Medium"
		default:
			return "Large"
		}
	}

	/// Computed 'String' Property corresponding to the 'Resort' object's 'price' value
	var price: String {
		/// Repeat "$" for n time(s) according to the 'prize' Int value
		String(repeating: "S", count: resort.price)
	}
	
    var body: some View {
		Group {
			VStack {
				Text("Size")
					.font(.caption.bold())
				Text(size)
					.font(.title3)
			}
			
			VStack {
				Text("Price")
					.font(.caption.bold())
				Text(price)
					.font(.title3)
			}
		}
		.frame(maxWidth: .infinity)
    }
}



struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		ResortDetailsView(resort: Resort.exampleResort)
    }
}
