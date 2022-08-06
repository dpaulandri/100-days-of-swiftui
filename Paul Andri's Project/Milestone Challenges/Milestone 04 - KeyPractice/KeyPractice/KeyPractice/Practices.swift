//
//  Practice.swift
//  KeyPractice
//
//  Created by Paul Andri on 08/06/2022.
//

import Foundation

// A CLASS TO STORE OUR PRACTICE PROPERTIES VALUES
// CONFORM TO 'ObservableObject' PROTOCOL
class Practices: ObservableObject {
    // '@Published' - AUTOMATICALLY PUBLISHES CHANGE ANNOUNCEMENTS
    // An empty Array to store datas from 'PracticeItem' struct
    @Published var practices = [PracticeItem]() {
        
        // 'didSet' OBSERVER
        didSet {
            // ENCODE 'items' PROPERTY VALUES TO JSON DATA & STORE IT IN 'UserDefaults'
            
            // TRY TO READ & ENCODE THE 'items' VALUE TO A JSON DATA FOR A NEW CONSTANT 'encoded'
            if let encoded = try? JSONEncoder().encode(practices) {
                // IF SUCCESSFUL:
                // SAVE THE 'encoded' VALUE TO 'UserDefaults' W/ "Practices" AS ITS DATA KEY
                UserDefaults.standard.set(encoded, forKey: "Practices")
            }
        }
    }
    
    
    // CUSTOM INITIALIZER FOR 'Practices' CLASS
    init() {
        // DECODE JSON DATA VALUES FROM 'Practices' KEY ITEMS IN 'UserDefaults' & ASSIGN ITS VALUE TO 'practices' PROPERTY
        
        // ATTEMPT TO READ THE DATA FROM 'UserDefaults' for "Practices" Key Items
        if let savedPractices = UserDefaults.standard.data(forKey: "Practices") {
            // IF SUCCESSFULLT RETRIEVED 'Practices' DATA FROM 'UserDefaults'
            // ATTEMPT TO DECODE [PracticeItem] Data from the successfully retrieved 'savedPractices'
            if let decodedItems = try? JSONDecoder().decode([PracticeItem].self, from: savedPractices) {
                practices = decodedItems
                return
            }
        }
        
        // IF FAILED TO RETRIEVE ANY ITEM FROM 'UserDefaults' OR '[PracticeItem]
        practices = []  // Return 'items' as an empty Array
    }
    
}
