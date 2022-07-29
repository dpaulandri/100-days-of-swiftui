//
//  ContentView.swift
//  iExpense
//
//  Created by Paul Andri on 07/29/2022.
//

import SwiftUI

// MAIN 'ContentView' STRUCT
struct ContentView: View {
    // '@StateObject' - WATCH FOR ANY '@Published' PROPERTY CHANGE ANNOUNCEMENTS & REFRESHES ANY VIEWS THAT USES THE OBJECT
    // '@StateObject' IS ONLY USED WHEN CREATING NEW CLASS INSTANCE, USE 'ObservedObject' FOR OTHER OBJECT
    // CREATE "Expenses" CLASS INSTANCES
    // PART OF DAY 38 CHALLENGE #3
    @StateObject var personalExpenses = PersonalExpenses()
    @StateObject var businessExpenses = BusinessExpenses()
    
    
    // PROGRAM STATE PROPERTY OF WHETHER THE "AddEntryView" Sheet View is shown
    @State private var showAddEntry = false
    
    var body: some View {
        NavigationView {
            List {
                // PART OF DAY 38 CHALLENGE #3
                // BUSINESS EXPENSE SECTION
                Section("Business Expenses") {
                    // USE 'ForEach' BECAUSE WE WANT TO HAVE THE 'onDelete' MODIFIER ON OUR DYNAMIC LIST'
                    // WE DON'T NEED TO SPECIFY 'id:' IN OUR 'ForEach' LOOP
                    // BECAUSE 'ExpenseItem' STRUCT IS CONFORMED TO 'Indentifiable' PROTOCOL
                    ForEach(businessExpenses.items) {item in
                        HStack {
                            Text(item.expenseName)
                            // PART OF DAY 38 CHALLENGE #2
                                .font(.headline.weight(item.amount > 99 ? .heavy : .regular))
                                .foregroundColor(
                                    item.amount > 99 ? .red : (item.amount > 25 ? .black : .blue)
                                )
                            
                            Spacer()
                            
                            // PART OF DAY 38 CHALLENGE #1
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            // PART OF DAY 38 CHALLENGE #2
                                .foregroundColor(
                                    item.amount > 99 ? .red : (item.amount > 25 ? .black : .blue)
                                )
                                .font(.body.weight(item.amount > 99 ? .heavy : .regular))
                        }
                    }
                    // 'onDelete()' MODIFIER FOR 'ForEach' VIEW
                    // CALL 'removeBusiness' METHOD
                    // PART OF DAY 38 CHALLENGE #3
                    .onDelete(perform: removeBusiness)
                }
                
                // PART OF DAY 38 CHALLENGE #3
                // PERSONAL EXPENSE SECTION
                Section("Personal Expenses") {
                    // USE 'ForEach' BECAUSE WE WANT TO HAVE THE 'onDelete' MODIFIER ON OUR DYNAMIC LIST'
                    // WE DON'T NEED TO SPECIFY 'id:' IN OUR 'ForEach' LOOP
                    // BECAUSE 'ExpenseItem' STRUCT IS CONFORMED TO 'Indentifiable' PROTOCOL
                    ForEach(personalExpenses.items) {item in
                        HStack {
                            Text(item.expenseName)
                            // PART OF DAY 38 CHALLENGE #2
                                .font(.headline.weight(item.amount > 99 ? .heavy : .regular))
                                .foregroundColor(
                                    item.amount > 99 ? .red : (item.amount > 25 ? .black : .blue)
                                )
                            
                            Spacer()
                            
                            // PART OF DAY 38 CHALLENGE #1
                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            // PART OF DAY 38 CHALLENGE #2
                                .foregroundColor(
                                    item.amount > 99 ? .red : (item.amount > 25 ? .black : .blue)
                                )
                                .font(.body.weight(item.amount > 99 ? .heavy : .regular))
                        }
                    }
                    // 'onDelete()' MODIFIER FOR 'ForEach' VIEW
                    // CALL 'removePersonal' METHOD
                    // PART OF DAY 38 CHALLENGE #3
                    .onDelete(perform: removePersonal)
                }
            }
            .navigationTitle("iExpense 💵")
            
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
                // PART OF DAY 38 CHALLENGE #3
                AddEntryView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
                
            }
        }
    }
    
    
    // PART OF DAY 38 CHALLENGE #3
    // METHOD TO GET THE INDEX OF AN ITEM IN 'personalExpenses' ARRAY & REMOVE IT FROM THE COLLECTION VIEW
    func removePersonal(at offsets: IndexSet) {
        personalExpenses.items.remove(atOffsets: offsets)
    }
    
    // PART OF DAY 38 CHALLENGE #3
    // METHOD TO GET THE INDEX OF AN ITEM IN 'businessExpenses' ARRAY & REMOVE IT FROM THE COLLECTION VIEW
    func removeBusiness(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
