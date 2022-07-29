//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Paul Andri on 07/29/2022.
//

import Foundation

// A STRUCT TO REPRESENT A SINGLE "EXPENSE" DATA
// STRUCT CONFORMS TO:
// - 'Identifiable' PROTOCOL - THIS TYPE CAN BE IDENTIFIED UNIQUELY
// - 'Codable' PROTOCOL - TO ALLOW JSON DATA EN/DECODING IN OUR 'Expenses' CLASS
// 'Identifiable' REQUIRES AN 'id' PROPERTY THAT CONTAINS A UNIQUE IDENTIFIER
struct ExpenseItem: Identifiable, Codable {
    // UNIQUE ENTRY 'id' PROPERTY THAT AUTO-GENERATES 'UUID'
    // THIS PROPERTY IS REQUIRED TO MAKE THE STRUCT CONFORM TO 'Identifiable' PROTOCOL
    var id = UUID()
    
    let expenseName: String
    let type: String
    let amount: Double
}
