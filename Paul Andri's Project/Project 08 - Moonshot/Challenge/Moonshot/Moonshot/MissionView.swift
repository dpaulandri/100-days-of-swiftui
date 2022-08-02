//
//  MissionView.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import SwiftUI

struct MissionView: View {
    // A NESTED STRUCT
    struct CrewMember {
        let role: String
        let astronaut: Astronauts
    }
    
    // MISSION PROPERTY
    let mission: Missions
    
    // CREW PROPERTY
    let crew: [CrewMember]
    
    var body: some View {
         // GEOMETRYREADER VIEW TO POPULATE THE MISSION VIEWS
        GeometryReader { geo in
            ScrollView {
                // OUTER VSTACK VIEW
                VStack {
                    // APOLLO MISSION BADGE IMAGE VIEW
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                    
                        // IMAGE VIEW FRAME MODIFIER
                        // USES GEOMETRY VALUE TO SET 60% OF AVAILABLE SPACE AS THE MAX FRAME WIDTH
                        .frame(maxWidth: geo.size.width * 0.6)
                        .padding(.top)
                    
                    // PART OF CODE FOR DAY 42 - CHALLENGE #1
                    Text(mission.longLaunchDate)
                                        
                    
                    // INNER VSTACK VIEW
                    // VSTACK VIEW ALIGNED TO THE LEFT OF VIEW
                    // CONTAINS THE APPLE MISSION HIGHLIGHT TEXTS
                    VStack(alignment: .leading) {
                        // PART OF DAY 42 - CHALLENGE #2
                        // CUSTOM DIVIDER VIEW
                        CustomDividerVIew()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        // PART OF DAY 42 - CHALLENGE #2
                        // CUSTOM DIVIDER VIEW
                        CustomDividerVIew()
                        
                        // TITLE FOR THE CREW VIEW
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    // INNER VSTACK VIEW MODIFIER
                    .padding(.horizontal)
                    
                    
                    // PART OF DAY 42 - CHALLENGE #2
                    // APOLLO CREW MEMBER SCROLL VIEWS
                    CrewScrollView(mission: mission, crew: crew)
                    
                }
                // OUTER VSTACK VIEW MODIFIER
                .padding(.bottom)
            }
        }
        // GEOMETRYREADER VIEW MODIFIER
        .navigationTitle(mission.displayName)
        // SET THE NAVBAR TITLE DISPLAY MODE
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBG)
    }
    
    // CUSTOM INITIALIZER FOR 'MissionView' STRUCT
    init(mission: Missions, astronauts: [String: Astronauts]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
}

struct MissionView_Previews: PreviewProvider {
    // PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
    static let missions: [Missions] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronauts] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            // FORCE DARK MODE THEME
            .preferredColorScheme(.dark)
    }
}
