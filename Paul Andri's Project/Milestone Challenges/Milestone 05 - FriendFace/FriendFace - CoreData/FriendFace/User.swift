//
//  User.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//

import Foundation

// 'User' DATA TYPE STRUCT
// CONFORMS TO 'Codable' & 'Identifiable' PROTOCOLS
struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    // COMPUTED PROPERTY FOR 'registered' DATE FORMATTING
    var registeredDate: String {
        registered.formatted(date: .long, time: .omitted)
    }
}
