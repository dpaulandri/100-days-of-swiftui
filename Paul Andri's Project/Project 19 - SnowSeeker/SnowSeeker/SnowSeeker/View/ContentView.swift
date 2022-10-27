//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//

import SwiftUI

struct ContentView: View {
	/// Property to decode & load all 'Resort' object from 'resorts.json' in the App Bundle
	let resorts: [Resort] = Bundle.main.decode("resorts.json")
	
	/// State Property to hold User input search 'String' value
	@State private var searchText = ""
	
	
    var body: some View {
		NavigationView {
			/// Create a List out of 'filteredResorts' Computed Property
			List(filteredResorts) { resort in
				NavigationLink {
					// Call detailed ResortView
					ResortView(resort: resort)
				} label: {
					Image(resort.country)
						.resizable()
						.scaledToFill()
						.frame(width: 44, height: 30)
						.clipShape(RoundedRectangle(cornerRadius: 5))
						.overlay(
							RoundedRectangle(cornerRadius: 5)
								.stroke(.black, lineWidth: 1)
						)
					
					VStack(alignment: .leading) {
						Text(resort.name)
							.font(.headline)
						Text("\(resort.runs) runs")
							.foregroundColor(.secondary)
					}
				}
			}
			.navigationTitle("SnowSeeker")
			/// Make List searchable
			.searchable(text: $searchText, prompt: "Enter name or country")
			
			// Secondary View to be shown by 'NavigationView' when the App launches on wider screen
			WelcomeView()
		}
		/// Optionally enforce "Stack" NavigationView style on all iPhones (regadless of size)
		/// ref. 'View.swift' extension file
		//.phoneOnlyStackNavigationView()
    }
	
	/// Computed Property to filter 'resorts' Array, returns [Resort] based on 'searchText' value
	var filteredResorts: [Resort] {
		if searchText.isEmpty {
			return resorts
		} else {
			return resorts.filter {
				/// Filter by Resort's Name & Country
				$0.name.localizedCaseInsensitiveContains(searchText) ||
				$0.country.localizedCaseInsensitiveContains(searchText)
			}
		}
	}
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
