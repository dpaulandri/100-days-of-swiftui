//
//  ContentView.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import SwiftUI

struct ContentView: View {
    //STATE PROPERTY WHETHER SHOWING GRID VIEW
    @State private var showList = false
    
    // LOAD JSON DATAS INTO CONTENT VIEW USING 'Bundle' EXTENSION (REF 'Bundle-Decodable.swift')
    // WE MUST TYPE ANNOTATE THE PROPERTIES DATA TYPES FOR THIS TO WORK
    let astronauts: [String: Astronauts] = Bundle.main.decode("astronauts.json")
    let missions: [Missions] = Bundle.main.decode("missions.json")
    
    // COLUMNS DEFINITION FOR LAZYVGRID VIEW
    let columns = [
        // 1 ADAPTIVE COLUMN W/ MINIMUM WIDTH OF 150PT
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        // CHECK IF OUR JSONDECODER BUNDLE EXTENSION & PROPERTIES WORKS
        /*
         Text("\(astronauts.count)")
         Text("\(missions.count)")
         */
        
        NavigationView {
            VStack {
                if showList {
                    BadgeListView()
                } else {
                    BadgeGridIView()
                }
            }
            // TOOLBAR MODIFIER
            .toolbar {
                // BUTTON TO TRIGGER LIST/GRID VIEW
                Button {
                    showList.toggle()
                } label: {
                    Image(systemName: showList ? "square.grid.2x2" : "list.bullet")
                }
				// PART OF DAY 76 - CHALLENGE #3
				/// FULL APP ACCESSIBILITY REVIEW
				.accessibilityElement()
				.accessibilityLabel(showList ? "Switch to Grid View" : "Switch to List View")
				.accessibilityAddTraits(.isButton)
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
