//
//  AddEntryView.swift
//  iExpense
//
//  Created by Paul Andri on 07/29/2022.
//

// SwiftUI VIEW FOR ADDING NEW EXPENSE ENTRY

import SwiftUI

struct AddEntryView: View {
    // PART OF DAY 38 CHALLENGE #3
    // 'ObservedObject' PROPERTY TO STORE AN 'Expenses' OBJECT
    @ObservedObject var personalExpenses: PersonalExpenses
    @ObservedObject var businessExpenses: BusinessExpenses
    
    
    // '@Environment' PROPERTY TO DISMISS VIEW UPON TAPPING "ADD BUTTON"
    @Environment(\.dismiss) var dismiss
    
    // STATE PROPERTIES
    @State private var expenseName = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    // ARRAY CONTAINING EXPENSE TYPES
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Expense Name:", text: $expenseName)
                }
                
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    // PART OF DAY 38 CHALLENGE #1
                    TextField("Amount:", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Expense")
            
            // '.toolbar' MODIFIER ON THE 'Form' VIEW
            .toolbar {
                // ADD BUTTON TO SAVE THE USER INPUT VALUE AS A NEW 'ExpenseItem()' STRUCT ITEM
                Button {
                    let item = ExpenseItem(
                        expenseName: expenseName,
                        type: type, amount: amount
                    )
                    
                    // PART OF DAY 38 CHALLENGE #3
                    // APPEND THE 'item' VALUE AS A NEW ITEM TO THE APPROPRIATE @ObservedObject Property
                    type == "Personal" ? personalExpenses.items.append(item) : businessExpenses.items.append(item)
                    
                    // TRIGGERS THE '@Environment' 'dismiss' PROPERTY
                    dismiss()
                    
                } label: {
                    Image(systemName: "plus.app")
                }
            }
            
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        // WE NEED TO PASS ON A DUMMY VALUE IN ORDER FOR THIS VIEW TO COMPILE
        // PART OF DAY 38 CHALLENGE #3
        AddEntryView(personalExpenses: PersonalExpenses(), businessExpenses: BusinessExpenses())
    }
}
