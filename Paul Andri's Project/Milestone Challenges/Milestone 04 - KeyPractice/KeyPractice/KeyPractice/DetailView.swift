//
//  DetailView.swift
//  KeyPractice
//
//  Created by Paul Andri on 08/06/2022.
//
// DETAIL VIEW OF EACH PRACTICE LOG ITEM

import SwiftUI

struct DetailView: View {
    let practice: PracticeItem

    
    var body: some View {
        NavigationView {
            VStack(alignment: .trailing) {
                List {
                    Section("Practice Topic") {
                        Text(practice.practiceTopic)
                    }
                    Section("Tonic Key") {
                        Text(practice.practiceTopic != "Rhythm Exercises" ? practice.practiceKey : "N/A")
                    }
                    
                    Section("Date/Time") {
                        Text(practice.practiceDate.formatted())
                    }
                    
                    Section("Note") {
                        Text(practice.practiceNote.isEmpty ? "-" : practice.practiceNote)
                    }
                }
                
                Spacer()
            }
            //.frame(maxHeight: .infinity)
        }
        .navigationTitle("Practice Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    // PASS DUMMY DATA
    static let practiceDummy = PracticeItem(practiceTopic: "Test", practiceKey: "C", practiceDate: Date.now, practiceNote: "")
    
    static var previews: some View {
        DetailView(practice: practiceDummy)
    }
}
