//
//  ContentView.swift
//  KeyPractice
//
//  Created by Paul Andri on 08/06/2022.
//

import SwiftUI

struct ContentView: View {
    // '@StateObject' - WATCH FOR ANY '@Published' PROPERTY CHANGE ANNOUNCEMENTS & REFRESHES ANY VIEWS THAT USES THE OBJECT
    /*
    // '@StateObject' IS ONLY USED WHEN CREATING NEW CLASS INSTANCE, USE 'ObservedObject' FOR OTHER OBJECT
    // CREATE "Practices" CLASS INSTANCES
    */
    @StateObject private var practices = Practices()
    
    // PROGRAM STATE PROPERTY OF WHETHER THE "Addiew" Sheet View is shown
    @State private var showAddView = false
    
    var body: some View {
        
        NavigationView{
            List {
                // SHOW SAVED PRACTICE LOGS
                Section("Practice Logs") {
                    ForEach(practices.practices) { practice in
                        NavigationLink {
                            DetailView(practice: practice)
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(practice.practiceTopic)
                                        .font(.headline)
                                    Text("Key: \(practice.practiceTopic != "Rhythm Exercises" ? practice.practiceKey : "N/A")")
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                Text(practice.practiceDate.formatted(.dateTime.day().month().year()))
                            }
                        }
                    }
                    // 'onDelete()' MODIFIER FOR 'ForEach' VIEW
                    // CALL 'removeLog' METHOD
                    .onDelete(perform: removeLog)

                }
                
            }
            // NAVIGATIONT TITLE
            .navigationTitle("KeyPractice")
            
            // ADD TOOLBAR
            .toolbar {
                // '+' BUTTON TO ADD ITEM TO LIST
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // TEST CODE
                        /*
                        let newPractice = PracticeItem(practiceTopic: "Test Topic", practiceKey: "C")
                        // INSERT NEW VALUES TO 'expenses' PROPERTY
                        practices.practices.append(newPractice)
                        */
                        
                         // CHANGE THE STATE OF 'showAddView' VIEW TO 'true'
                         // TRIGGERS 'sheet' VIEW
                         showAddView = true
                        
                    } label: {
                        Image(systemName: "plus.square.on.square")
                            .foregroundColor(.secondary)
                    }
                }
                
                // QUICK LIST EDIT/DELETE BUTTON
                ToolbarItem(placement: .destructiveAction) {
                    EditButton()
                        .foregroundColor(.red)
                }
                        
            }
            // 'sheet()' MODIFIER ON THE 'List' VIEW
            .sheet(isPresented: $showAddView) {
                // SHOW 'AddView' ON SHEET
                AddView(practices: practices)
            }
        }
    }
    
    // METHOD TO GET THE INDEX OF AN ITEM IN 'practices' ARRAY & REMOVE IT FROM THE COLLECTION VIEW
    public func removeLog(at offsets: IndexSet) {
        practices.practices.remove(atOffsets: offsets)
    }

}



struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
