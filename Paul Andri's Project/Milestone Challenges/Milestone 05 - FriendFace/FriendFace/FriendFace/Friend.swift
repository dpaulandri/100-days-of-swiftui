//
//  Friend.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//

import Foundation

// 'Friend' DATA TYPE STRUCT
// CONFORMS TO 'Codable' & 'Identifiable' PROTOCOLS
struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}
