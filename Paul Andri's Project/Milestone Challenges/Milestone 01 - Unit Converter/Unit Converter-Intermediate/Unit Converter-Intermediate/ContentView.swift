//
//  ContentView.swift
//  Unit Converter-Intermediate
//
//  Created by Paul Andri on 05/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
        
    // Focus State for "Input Value" TextField
    @FocusState var inputValueFocus: Bool
    
 
    // An Array of unit types available using 'UnitLength' Data Type
    let unitType: [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]
    
    // Add custom Formatter to use for our Unit Types
    let unitFormatter: MeasurementFormatter
    
    
    // Unit Conversion Properties
    var result: String {
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit)
        let resultMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return unitFormatter.string(from: resultMeasurement)
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
                
                
                // Convert FROM & TO Section
                Section {
                    Picker("From:", selection: $inputUnit) {
                        ForEach(unitType, id: \.self) {
                            Text(unitFormatter.string(from: $0))
                        }
                    }

                    Picker("To:", selection: $outputUnit) {
                        ForEach(unitType, id: \.self) {
                            Text(unitFormatter.string(from: $0))
                        }
                    }
                }  header: {
                    Text("Conversion")
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
    
    // Create an Custom Initializer to config our custom 'unitFormatter' OUTSIDE the 'body' Variable
    init() {
        unitFormatter = MeasurementFormatter()
        unitFormatter.unitOptions = .providedUnit // Use the provided Unit instead of the default ones
        unitFormatter.unitStyle = .long // Use the long unit name (ie. 'feet' instead of 'ft'
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
