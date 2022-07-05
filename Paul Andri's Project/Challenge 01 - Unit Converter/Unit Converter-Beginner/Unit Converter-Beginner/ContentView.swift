//
//  ContentView.swift
//  Unit Converter-Beginner
//
//  Created by Paul Andri on 05/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var convertFrom = "m"
    @State private var convertTo = "km"
    
    // Focus State for "Input Value" TextField
    @FocusState var inputValueFocus: Bool
    
    // An Array of unit types available
    let unitType = ["ft", "km", "m", "mile", "yd"]
 
 
    // Unit Conversion Properties
    var result: String {
        let inputToMeterX: Double
        let metersToResultX: Double
        
        switch convertFrom {
        case "ft":
            inputToMeterX = 0.3048
        case "km":
            inputToMeterX = 1000
        case "mile":
            inputToMeterX = 1609.34
        case "yd":
            inputToMeterX = 0.9144
        default: // Meter to Meter
            inputToMeterX = 1
        }
        
        switch convertTo {
        case "ft":
            metersToResultX = 3.2808
        case "km":
            metersToResultX = 0.001
        case "mile":
            metersToResultX = 0.000621371
        case "yd":
            metersToResultX = 1.09361
        default: // Meter to Meter
            metersToResultX = 1
        }
        
        let inputInMeters = inputValue * inputToMeterX
        let outputValue = inputInMeters * metersToResultX
        
        let formattedValue = outputValue.formatted()
        
        return "\(formattedValue) \(convertTo)"
    }
    
    var body: some View {
        NavigationView {
            Form {
                // User Input Section
                Section {
                    // Input Value
                    TextField("Input Value:", value: $inputValue, format: .number)
                    
                    .keyboardType(.decimalPad)
                    .focused($inputValueFocus)
                    
                } header: {
                    Text("Value to convert")
                }
                
                
                // Convert FROM Section
                Section {
                    Picker("Convert FROM:", selection: $convertFrom) {
                        ForEach(unitType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert FROM:")
                }
                
                
                
                // Convert TO Section
                Section {
                    Picker("Convert TO:", selection: $convertTo) {
                        ForEach(unitType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert TO:")
                }
                
                
                // Conversion Output Section
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
                
                .navigationTitle("Unit Converter")
                
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("OK") {
                            inputValueFocus = false
                        }
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
