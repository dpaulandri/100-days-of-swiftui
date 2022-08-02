//
//  BadgeListView.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//
// PART OF DAY 42 - CHALLENGE #3

import SwiftUI

struct BadgeListView: View {
    //STATE PROPERTY WHETHER SHOWING GRID VIEW
    @State private var showList = false
    
    // LOAD JSON DATAS INTO CONTENT VIEW USING 'Bundle' EXTENSION (REF 'Bundle-Decodable.swift')
    // WE MUST TYPE ANNOTATE THE PROPERTIES DATA TYPES FOR THIS TO WORK
    let astronauts: [String: Astronauts] = Bundle.main.decode("astronauts.json")
    let missions: [Missions] = Bundle.main.decode("missions.json")
    
    var body: some View {
        // LIST VIEW
        ZStack {
            Color.darkBG
                .ignoresSafeArea()
            
            List {
                ForEach(missions) { mission in
                    NavigationLink {
                        // LINK TO THE APPROPRIATE MISSION VIEW ON IMAGE TAP
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            Spacer()
                            
                            // INNER VSTACK VIEW
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            // VIEW MODIFIERS FOR THE INNER VSTACK VIEW
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBG)
                            
                        }
                        
                    }
                }
                // LIST STYLE MODIFIERS
                .listStyle(.plain)
                .listRowBackground(Color.darkBG)
                
            }
            // LIST VIEW MODIFIERS
            .listStyle(.plain)
            // NAVIGATION TITLE MODIFIERS FOR
            .navigationTitle("Moonshot")
            // SET PREFERRED COLOUR SCHEME TO DARK MODE (FORCE DARK THEME)
            .preferredColorScheme(.dark)
            
        }
        
    }
}

struct BadgeListView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeListView()
    }
}
