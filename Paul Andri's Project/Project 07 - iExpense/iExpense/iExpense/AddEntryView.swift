//
//  AddEntryView.swift
//  iExpense
//
//  Created by Paul Andri on 07/29/2022.
//

// SwiftUI VIEW FOR ADDING NEW EXPENSE ENTRY

import SwiftUI

struct AddEntryView: View {
    // 'ObservedObject' PROPERTY TO STORE AN 'Expenses' OBJECT
    @ObservedObject var expenses: Expenses
    
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
                    TextField("Amount:", value: $amount, format: .currency(code: "USD"))
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
                    
                    // APPEND THE 'item' VALUE AS A NEW ITEM TO 'expenses' @ObservedObject Property
                    expenses.items.append(item)
                    
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
        // WE NEED TO PASS ON A DUMMY VALUE '(expenses: Expenses())' IN ORDER FOR THIS VIEW TO COMPILE
        AddEntryView(expenses: Expenses())
    }
}
