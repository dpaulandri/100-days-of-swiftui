//
//  PracticeItem.swift
//  KeyPractice
//
//  Created by Paul Andri on 08/06/2022.
//

import Foundation

// A STRUCT TO REPRESENT A SINGLE "Practice" DATA
// STRUCT CONFORMS TO:
// - 'Identifiable' PROTOCOL - THIS TYPE CAN BE IDENTIFIED UNIQUELY
// - 'Codable' PROTOCOL - TO ALLOW JSON DATA EN/DECODING IN OUR 'Expenses' CLASS
// 'Identifiable' REQUIRES AN 'id' PROPERTY THAT CONTAINS A UNIQUE IDENTIFIER
struct PracticeItem: Identifiable, Codable {
    // UNIQUE ENTRY 'id' PROPERTY THAT AUTO-GENERATES 'UUID'
    // THIS PROPERTY IS REQUIRED TO MAKE THE STRUCT CONFORM TO 'Identifiable' PROTOCOL
    var id = UUID()
    
    // STORE THE PRACTICE'S TOPIC
    let practiceTopic: String
    let practiceKey: String
    let practiceDate: Date
    let practiceNote: String
}
