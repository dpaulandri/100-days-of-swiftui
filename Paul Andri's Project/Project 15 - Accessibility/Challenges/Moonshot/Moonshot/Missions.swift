//
//  Missions.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import Foundation

// A 'Missions'' TYPE STRUCT FOR 'missions.json' JSON DATA
struct Missions: Codable, Identifiable {
    // NESTED STRUCT
    // A 'CrewRole'' TYPE STRUCT FOR 'missions.json' JSON DATA
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    
    // 'launchDate' IS OPTIONAL DATE VALUE
    // BECAUSE MISSION #1 DID NOT HAVE A 'launchDate' VALUE
    let launchDate: Date?
    
    // 'crew' PROPERTY IS A 'CrewRole' TYPE ARRAY
    let crew: [CrewRole]
    
    let description: String
    
    // COMPUTED PROPERTY FOR APOLLO MISSION DISPLAY NAMES
    var displayName: String {
        "Apollo \(id)"
    }
    
    // COMPUTED PROPERTY FOR APOLLO IMAGE FILE NAMES
    var image: String {
        "apollo\(id)"
    }
    
    // COMPUTED PROPERTY FOR FORMATTED 'launchDate' STRING VALUE
    // WILL FORMAT THE 'launchDate' INTO THE APPROPRIATE USER iDEVICE's DATE FORMAT SETTINGS
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    // PART OF CODE FOR DAY 42 - CHALLENGE #1
    var longLaunchDate: String {
        launchDate?.formatted(date: .complete, time: .omitted) ?? "Not Launch"
    }
}
