//
//  ContentView.swift
//  iExpense
//
//  Created by Paul Andri on 07/29/2022.
//

import SwiftUI

struct ContentView: View {
    // '@StateObject' - WATCH FOR ANY '@Published' PROPERTY CHANGE ANNOUNCEMENTS & REFRESHES ANY VIEWS THAT USES THE OBJECT
    // '@StateObject' IS ONLY USED WHEN CREATING NEW CLASS INSTANCE, USE 'ObservedObject' FOR OTHER OBJECT
    // CREATE AN INSTANCE OF 'Expenses' CLASS
    @StateObject var expenses = Expenses()
    
    // PROGRAM STATE PROPERTY OF WHETHER THE "AddEntryView" Sheet View is shown
    @State private var showAddEntry = false
    
    var body: some View {
        NavigationView {
            List {
                // USE 'ForEach' BECAUSE WE WANT TO HAVE THE 'onDelete' MODIFIER ON OUR DYNAMIC LIST'
                // WE DON'T NEED TO SPECIFY 'id:' IN OUR 'ForEach' LOOP
                // BECAUSE 'ExpenseItem' STRUCT IS CONFORMED TO 'Indentifiable' PROTOCOL
                ForEach(expenses.items) {item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.expenseName)
                                .font(.headline)
                            Text(item.type)
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                // 'onDelete()' MODIFIER FOR 'ForEach' VIEW
                // CALL 'removeEntry' METHOD
                .onDelete(perform: removeEntry)
            }
            .navigationTitle("iExpense")
            
            // ADD A TOOLBAR MODIFIER ON THE 'List' VIEW
            .toolbar {
                // ADD A '+' BUTTON TO THE TOOLBAR TO ADD ITEM TO LIST
                Button {
                    // TEST CODE
                    //let newExpense = ExpenseItem(expenseName: "Test", type: "Personal", amount: 5)
                    // INSERT NEW VALUES TO 'expenses' PROPERTY
                    //expenses.items.append(newExpense)
                    
                    // CHANGE THE STATE OF 'showAddEntry' VIEW TO 'true'
                    // TRIGGERS 'sheet' VIEW
                    showAddEntry = true

                    
                } label: {
                    Image(systemName: "plus.square.on.square")
                }
            }
            // 'sheet()' MODIFIER ON THE 'List' VIEW
            .sheet(isPresented: $showAddEntry) {
                // SHOW 'AddEntryView' HERE
                AddEntryView(expenses: expenses)
            }
        }
    }
    
    // METHOD TO GET THE INDEX NUMBER OF A CERTAIN ITEM FROM 'IndexSet' & REMOVE IT FROM A COLLECTION VIEW
    func removeEntry(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
