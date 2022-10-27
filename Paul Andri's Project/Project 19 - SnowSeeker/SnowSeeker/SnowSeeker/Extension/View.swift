//
//  View.swift
//  SnowSeeker
//
//  Created by Paul Andri on 10/27/2022.
//

import SwiftUI

extension View {
	// METHOD TO ENFORE '.stack' NAVIGATIONVIEW STYLE ON ALL iPHONES (REGARDLESS OF SCREEN SIZES)
	/// We use the '@ViewBuilder' attribute here because the two returned 'View' types are different
	@ViewBuilder func phoneOnlyStackNavigationView() -> some View {
		if UIDevice.current.userInterfaceIdiom == .phone {
			self.navigationViewStyle(.stack)
		} else {
			self
		}
	}
}
