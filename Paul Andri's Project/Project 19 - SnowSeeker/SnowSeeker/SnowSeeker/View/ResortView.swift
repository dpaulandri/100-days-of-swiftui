//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//

import SwiftUI

struct ResortView: View {
	/// View will receive a 'Resort' object in its initializer
	let resort: Resort
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 0) {
				Image(decorative: resort.id)
					.resizable()
					.scaledToFit()
				
				HStack {
					ResortDetailsView(resort: resort)
					SkiDetailsView(resort: resort)
				}
				.padding(.vertical)
				.background(Color.primary.opacity(0.1))
				
				Group {
					Text(resort.description)
						.padding(.vertical)
					
					Text("Facilities")
						.font(.headline)
					/// Make a "Text List" out of the 'facilities' [String]
					Text(resort.facilities, format: .list(type: .and))
						.padding(.vertical)
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle("\(resort.name), \(resort.country)")
		.navigationBarTitleDisplayMode(.inline)
    }
}



struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
		ResortView(resort: Resort.exampleResort)
    }
}
