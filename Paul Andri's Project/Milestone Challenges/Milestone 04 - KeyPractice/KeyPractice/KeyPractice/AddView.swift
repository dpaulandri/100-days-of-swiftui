//
//  AddView.swift
//  KeyPractice
//
//  Created by Paul Andri on 08/06/2022.
//
// VIEW TO ADD NEW PRACTICE LOG

import SwiftUI

struct AddView: View {
    // 'ObservedObject' PROPERTY TO STORE AN 'Practices' OBJECT
    @ObservedObject var practices: Practices
    
    // '@Environment' PROPERTY TO DISMISS VIEW UPON TAPPING "ADD BUTTON"
    @Environment(\.dismiss) var dismiss
    
    // STATE PROPERTIES
    @State private var practiceTopic = "Scales"
    @State private var practiceKey = "C"
    @State private var practiceDate = Date.now
    @State private var practiceNote = ""
    
    // ARRAY CONTAINING 12 AVAILABLE PRACTICE KEYS
    @State private var topics = ["Scales", "Chord Voicings", "Rhythm Exercises", "Others"]
    
    // ARRAY CONTAINING 12 AVAILABLE PRACTICE KEYS
    private let keys = ["C", "C♯ / D♭", "D", "D♯ / E♭", "E", "F", "F♯ / G♭", "G", "G♯ / A♭", "A", "A♯ / B♭", "B"]
    
    var body: some View {
        NavigationView {
            Form {
                // PRACTICE TOPIC ENTRY SECTION
                Section("Topic") {
                    Picker("Topics", selection: $practiceTopic) {
                        ForEach(topics, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                // PRACTICE KEY ENTRY SECTION
                if practiceTopic != "Rhythm Exercises" {
                    Section("Tonic Key") {
                        Picker("Key", selection: $practiceKey) {
                            ForEach(keys, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                // PRACTICE DATE ENTRY SECTION
                Section("Date/Time") {
                    DatePicker("Practice Date",
                               // Bind the value of 'DatePicker' to Property '$practiceDate'
                               selection: $practiceDate, in: ...Date.now
                    )
                    // '.labelsHidden()' - Hide the Label text on screen
                    .labelsHidden() // Screen reader will still be able to read the Label
                }
                
                // PRACTICE NOTE ENTRY SECTION
                Section("Notes") {
                    TextField("Optional", text: $practiceNote)
                }
            }
            .navigationTitle("Add Practice")
            
            // ADD TOOLBAR
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    // ADD BUTTON TO SAVE THE USER INPUT VALUE AS A NEW 'PracticeItem()' STRUCT ITEM
                    Button {
                        let practiceData = PracticeItem(
                            practiceTopic: practiceTopic,
                            practiceKey: practiceKey,
                            practiceDate: practiceDate,
                            practiceNote: practiceNote
                        )
                        
                        // INSERT THE NEW 'practiceData' VALUE AS A NEW ITEM TO THE APPROPRIATE @ObservedObject Property AT INDEX #0
                        practices.practices.insert(practiceData, at: 0)
                        
                        // TRIGGERS THE '@Environment' 'dismiss' PROPERTY
                        dismiss()
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.secondary)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    // ADD BUTTON TO DISMISS ADD LOG SHEET VIEW
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.down.right.and.arrow.up.left")
                            .foregroundColor(.secondary)
                    }
                }
                
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(practices: Practices())
    }
}
