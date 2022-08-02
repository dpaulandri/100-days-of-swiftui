//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//
// PART OF DAY 42 - CHALLENGE #2

import SwiftUI

struct CrewScrollView: View {
    
    // MISSION PROPERTY
    let mission: Missions
    
    // CREW PROPERTY
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        
        // HORIZONTAL SCROLL VIEW
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
}

struct CrewScrollView_Previews: PreviewProvider {
    // PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
    static let missions: [Missions] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronauts] = Bundle.main.decode("astronauts.json")
    static var crew = [MissionView.CrewMember.init(role: "Commander", astronaut: astronauts["armstrong"]!)]
    
    static var previews: some View {
        CrewScrollView(mission: missions[0], crew: crew)
            // FORCE DARK MODE THEME
            .preferredColorScheme(.dark)
    }
}
