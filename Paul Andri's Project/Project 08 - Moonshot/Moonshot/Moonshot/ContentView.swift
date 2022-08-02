//
//  ContentView.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import SwiftUI

struct ContentView: View {
    
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
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        // NAVIGATION LINK
                        NavigationLink {
                            // LINK TO THE APPROPRIATE MISSION VIEW ON IMAGE TAP
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            // OUTER VSTACK VIEW
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                // INNER VSTACK VIEW
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                // VIEW MODIFIERS FOR THE INNER VSTACK VIEW
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBG)
                                
                            }
                            // VIEW MODIFIERS FOR THE OUTER VSTACK VIEW
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBG)
                            )
                        }
                    }
                }
                // LAZYVGRID VIEW MODIFIER
                // ADD PADDING TO THE HORIZONTAL & BOTTOM OF LAZYVGRID VIEW
                .padding([.horizontal, .bottom])
            }
            // 'ScrollView' MODIFIERS
            // NAVIGATION TITLE MODIFIERS FOR 'ScrollView'
            .navigationTitle("Moonshot")
            // MAKE 'ScrollView' BACKGROUND TO 'darkBG' COLOR
            .background(.darkBG)
            // SET PREFERRED COLOUR SCHEME TO DARK MODE (FORCE DARK THEME)
            .preferredColorScheme(.dark)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
