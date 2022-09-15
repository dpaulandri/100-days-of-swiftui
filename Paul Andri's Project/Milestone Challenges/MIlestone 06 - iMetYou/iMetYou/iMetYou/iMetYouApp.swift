//
//  iMetYouApp.swift
//  iMetYou
//
//  Created by Paul Andri on 09/14/2022.
//

import SwiftUI

@main
struct iMetYouApp: App {
	// CREATE A NEW 'DataController' CLASS INSTANCE AS '@StateObject' PROPERTY
	@StateObject private var dataController = DataController()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
			// CONTENT VIEW MODIFIER
			// INJECT 'dataController' STATE OBJECT INTO OUR MAIN APP'S SWIFTUI ENVIRONMENT
			// THIS MAKE OUR COREDATA PERSISTENT STORAGE AVAILABLE TO BE USED ANYWHERE WITHIN THE APP
				.environment(\.managedObjectContext, dataController.container.viewContext)
			// 'managedObjectContext' - THE "LIVE" VERSION OF OUR DATA
			/* When you load objects and change them,
			 those changes only exist in memory until you specifically save them back to the PERSISTENT STORES */
        }
    }
}
