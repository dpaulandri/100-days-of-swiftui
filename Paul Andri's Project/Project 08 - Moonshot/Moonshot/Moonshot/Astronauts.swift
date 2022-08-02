//
//  Astronauts.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import Foundation

// A 'Astronauts' TYPE STRUCT FOR 'astronauts.json' JSON DATA
struct Astronauts: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
