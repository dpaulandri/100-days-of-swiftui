//
//  ContentView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//

import SwiftUI

struct ContentView: View {
    // MAIN BDOY VIEW PROPERTY
    var body: some View {
        NavigationView {
            // CALL LIST VIEW
            ListView()
                .navigationBarTitle("FriendFace")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
