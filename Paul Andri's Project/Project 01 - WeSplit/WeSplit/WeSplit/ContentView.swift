//
//  ContentView.swift
//  WeSplit
//
//  Created by Paul Andri on 01/07/22.
//

import SwiftUI  // Import SwiftUI Framework

// 'ContentView' conforms to SwiftUI's 'View' Protocol
struct ContentView: View {
    // '@State' is a Property Wrapper for 'current Program State'
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    // '@FocusState' is a Property Wrapper to determine whether a 'TextField' is in focus
    @FocusState private var checkAmountFocus: Bool
    
    // The selectable options for tip 'tipPercentage' Property
    let tipPercentages = [10, 15, 20, 25, 30, 0]
    
    // Code for #100DaysOfSwiftUI Day 18 Extra Challenge #4
    // Currency Code Property
    var currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    // Computed Property for the Amount to Pay per Pax
    var amountPerPerson: Double {
        // Convert Properties Type to 'Double' for Calculation
        let realPeopleCount = Double(numberOfPeople + 2) // Reconcile value diff.
        let tipSelected = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelected
        let grandTotal = checkAmount + tipValue
        let splitAmount = grandTotal / realPeopleCount
        
        return splitAmount
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                // Value Input Section for 'checkAmount' & $numberOfPeople'
                Section {
                    // Textfield to enter a value to 'checkAmount'
                    TextField("Amount:", value: $checkAmount, format: currencyCode)
                    // 'Locale' is an built-in Struct in iOS
                    // Handle user device's local/regional settings
                    
                    // '.keyboardType()' - a 'TextField' Modifier to specify an iOS device keyboard type to use when entering a value to 'TextField'
                        .keyboardType(.decimalPad)
                    // '.decimalPad' - Numberpad Keyboard WITH '.'
                    // Many more types & options available
                    
                        // 'focused()' to determine whether our 'TextField' is currently in Focus
                        .focused($checkAmountFocus)
                        // Bounded to 'checkAmountFocus' Property w/ a '@FocusState' Property Wrapper
                    
                
                    // 'Picker' to pick a value for 'numberOfPeople' Property
                    // The Syntax below is an example of using CLOSURE in SwiftUI
                    Picker("Pax:", selection: $numberOfPeople) {
                        ForEach(2..<100) { // 2 - 99 pax
                            Text("\($0) pax")
                        }
                    }
                } header: { // Add a Heading Title to Section
                    Text("Enter Values")
                }
                
                
                
                // Segmented Control Picker Input Section for 'tipPercentage'
                Section {
                    
                    // Picker' to pick a value from 'tipPercentages' Array for 'tipPercentage' Property
                    Picker("Tip Percentage:", selection: $tipPercentage) {
                        // '.self': each Item in 'tipPercentages' is its unique ID
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    // Add "Segmented Control" Picker for 'tipPercentage' value
                    // Shows a handfuls of options in a Horizontal space
                    
                    /* Code for #100DaysOfSwiftUI Day 18 Challenger #3
                    Picker("Tip Percentage:", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)%")
                        }
                    }
                    */
                    
                    
                } header: { // Add a Heading Title to Section
                    Text("Tip Percentage")
                }
                
                
                
                // Input Values Display Section
                Section {
                    // Display the Tip Percentage selected in 'tipPercentage'
                    Text("Bill Value: \(checkAmount, format: currencyCode)")
                    
                    // Display the Tip Amount selected in 'tipPercentage'
                    Text("Tip Value: \(checkAmount / 100 * Double(tipPercentage), format: currencyCode)")
                    
                    // Code for #100DaysOfSwiftUI Day 18 Challenger #2
                    // Display the Amount entered into 'checkAmount'
                    Text("Grand Total: \(checkAmount / 100 * Double(tipPercentage) + checkAmount, format: currencyCode)")
                    
                    // Display the Number of Pax selected in 'numberOfPeople'
                    Text("Split for: \(numberOfPeople + 2)pax")
                    
                    
                    
                } header: { // Add a Heading Title to Section
                    Text("Breakdown")
                }
                
                
                
                // 'amountPerPerson' Computed Property Values Display Section
                Section {
                    // Display the Computed Property value in 'amountPerPerson'
                    Text(amountPerPerson, format: currencyCode)
                    

                } header: { // Add a Heading Title to Section
                    Text("Amount due per Person")
                } // Code for #100DaysOfSwiftUI Day 18 Challenger #1
                
                
                
                // Give a Title to the NavBar on top
                .navigationBarTitle("WeSplit") // Place inside the 'Form' Body
                
                // Add a "Done' Button on top of iOS keyboard
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        // 'Spacer()' pushes our Button all the way to the RIGHT side of Toolbar
                        Spacer()
                        
                        Button("OK") {
                            // CHANGE the 'checkAmountFocus' Property value to 'false'
                            checkAmountFocus = false // Run this code when the Button is pressed
                        }
                    }
                }
                
                
            }

        }
    }
}



// 'ContentView_Previews' conforms to 'PreviewProvider' Protocol
// ONLY FOR TESTING, DEBUGGING, DESIGNING & PREVIEWING PURPOSES
// WILL NOT BE SHIP IN THE FINAL APP PRODUCT
// OPT ⌥ + CMD ⌘ + P to resume paused Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
