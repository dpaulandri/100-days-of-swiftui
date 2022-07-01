//
//  ContentView.swift
//  WeSplit
//
//  Created by Paul Andri on 01/07/22.
//

import SwiftUI  // Import SwiftUI Framework

// 'ContentView' conforms to SwiftUI's 'View' Protocol
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

// 'ContentView_Previews' conforms to 'PreviewProvider' Protocol
// ONLY FOR TESTING, DEBUGGING, DESIGNING & PREVIEWING PURPOSES
// WILL NOT BE SHIP IN THE FINAL APP PRODUCT
// OPT ⌥ + CMD ⌘ + P to resume paused Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


