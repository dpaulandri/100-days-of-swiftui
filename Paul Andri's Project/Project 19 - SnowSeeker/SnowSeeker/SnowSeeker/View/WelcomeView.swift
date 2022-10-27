//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//
// Created as the Secondary View to accomodate for SwiftUI's 'NavigationView' current default behaviour when an App is launched on iPad, iPhone in Landscape orientation and wider screen

import SwiftUI

struct WelcomeView: View {
    var body: some View {
		VStack {
			Text("Welcome to SnowSeeker!")
				.font(.largeTitle)
			
			HStack {
				Text("Please select a Resort by tapping")
				Image(systemName: "sidebar.left")
					.foregroundColor(.blue)
				Text("on the top left corner.")
			}
			.foregroundColor(.secondary)
		}
    }
}



struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
