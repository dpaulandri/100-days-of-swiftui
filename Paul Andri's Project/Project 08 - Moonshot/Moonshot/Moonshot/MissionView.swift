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
                                        
                    
                    // INNER VSTACK VIEW
                    // VSTACK VIEW ALIGNED TO THE LEFT OF VIEW
                    // CONTAINS THE APPLE MISSION HIGHLIGHT TEXTS
                    VStack(alignment: .leading) {
                        // CUSTOM DIVIDER
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBG)
                            .padding(.vertical)
                        
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        // CUSTOM DIVIDER
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBG)
                            .padding(.vertical)
                        
                        // TITLE FOR THE CREW VIEW
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    // INNER VSTACK VIEW MODIFIER
                    .padding(.horizontal)
                    
                    
                    // APOLLO CREW MEMBER VIEWS
                    // HORIZONTAL SCROLL VIEW NESTED WITHIN THE OUTER VSTACK VIEW
                    // 'showsIndicators: false' HIDES THE SCROLL BAR INDICATORS
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                // NAVIGATION LINK
                                NavigationLink {
                                    // LINK TO THE APPROPRIATE ASTRONAUT VIEW ON IMAGE TAP
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    HStack {
                                        // IMAGE FILE NAME IS THE SAME AS THE ASTRONAUTS' JSON DATA ID
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Circle())
                                        
                                        VStack(alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(crewMember.role == "Commander" ? .headline.weight(.heavy) : .headline)
                                            
                                            Text(crewMember.role)
                                                .foregroundColor(.secondary)
                                                .font(crewMember.role == "Commander" ? .body.bold() : .body)
                                                
                                        }
                                    }
                                    // HSTACK VIEW MODIFIERS
                                    // HORIZONTAL PADDING FOR HSTACK VIEW
                                    .padding(.horizontal)
                                    // HIGHLIGHT THE BACKGROUND OF "Commander" ASTRONAUTS
                                    .background(crewMember.role == "Commander" ? .lightBG : .darkBG)
                                    
                                }
                            }
                            // FOREACH VIEW MODIFIER
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                    }
                    
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
