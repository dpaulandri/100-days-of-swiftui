//
//  ContentView.swift
//  Day24-Challenge3
//
//  Created by Paul Andri on 07/08/2022.
//

import SwiftUI

//Create a new custom View Modifier
struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

// Custom View Modifier as a 'View' Protocol extension
extension View {
    func boldTitle () -> some View {
        modifier(ProminentTitle())
    }
}


struct ContentView: View {
    var body: some View {
        Text("TITLE")
            .boldTitle() // <- custom View Modifier
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
