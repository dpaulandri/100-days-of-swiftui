//
//  AstronautView.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import SwiftUI

struct AstronautView: View {
    
    // ASTRONAUT PROPERTY
    let astronaut: Astronauts
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView {
                VStack{
                    // THE IMAGE FILE NAME IS THE SAME AS ASTRONAUT'S ID
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
					// PART OF DAY 76 - CHALLENGE #3
					/// FULL APP ACCESSIBILITY REVIEW
						.accessibilityLabel("Official Mission Picture of \(astronaut.name)")
						.accessibilityRemoveTraits(.isImage)
                    
                    // CUSTOM DIVIDER
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBG)
                        .padding(.vertical)
                    
                    Text(astronaut.description)
                    
                    // CUSTOM DIVIDER
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBG)
                        .padding(.vertical)
                        
                }
                .padding()
            }
            // SCROLL VIEW MODIFIER
            .background(.darkBG)
            // USE ASTRONAUT'S NAME AS ITS NAVBAR TITLE
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

struct AstronautView_Previews: PreviewProvider {
    // PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
    static let astronauts: [String: Astronauts] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        // '!' SWIFT'S FORCE UNWRAP, AVOID USE WHENEVER POSSIBLE
        AstronautView(astronaut: astronauts["armstrong"]!)
        // FORCE DARK MODE THEME
        .preferredColorScheme(.dark)
    }
}
