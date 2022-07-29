//
//  BusinessExpenses.swift
//  iExpense
//
//  Created by Paul Andri on 07/29/2022.
//

// PART OF DAY 38 CHALLENGE #3
import Foundation

// A CLASS TO STORE OUR BUSINESS EXPENSE PROPERTIES VALUES
// CONFORM TO 'ObservableObject' PROTOCOL
class BusinessExpenses: ObservableObject {
    // '@Published' - AUTOMATICALLY PUBLISHES CHANGE ANNOUNCEMENTS
    // An empty Array to store datas from 'ExpenseItem' struct
    @Published var items = [ExpenseItem]() {
        
        // 'didSet' OBSERVED
        didSet {
            // ENCODE 'items' PROPERTY VALUES TO JSON DATA & STORE IT IN 'UserDefaults'
            
            // TRY TO READ & ENCODE THE 'items' VALUE TO A JSON DATA FOR A NEW CONSTANT 'encoded'
            if let encoded = try? JSONEncoder().encode(items) {
                // IF SUCCESSFUL:
                // SAVE THE 'encoded' VALUE TO 'UserDefaults' W/ "Expenses" AS ITS DATA KEY
                UserDefaults.standard.set(encoded, forKey: "BusinessExpenses")
            }
        }
    }
    
    // CUSTOM INITIALIZER FOR 'Expenses' CLASS
    init() {
        // DECODE JSON DATA VALUES FROM 'Expenses' KEY ITEMS IN 'UserDefaults' & ASSIGN ITS VALUE TO 'items' PROPERTY
        
        // ATTEMPT TO READ THE DATA FROM 'UserDefaults' for "Expenses" Key Items
        if let savedExpenses = UserDefaults.standard.data(forKey: "BusinessExpenses") {
            // IF SUCCESSFULLT RETRIEVED 'Expenses' DATA FROM 'UserDefaults'
            // ATTEMPT TO DECODE [ExpenseItem] Data from the successfully retrieved 'savedExpenses'
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedExpenses) {
                items = decodedItems
                return
            }
        }
        
        // IF FAILED TO RETRIEVE ANY ITEM FROM 'UserDefaults' OR '[ExpenseItem]
        items = []  // Return 'items' as an empty Array
    }
    
}
