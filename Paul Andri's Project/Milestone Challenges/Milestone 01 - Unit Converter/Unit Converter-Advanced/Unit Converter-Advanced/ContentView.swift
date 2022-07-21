//
//  ContentView.swift
//  Unit Converter-Advanced
//
//  Created by Paul Andri on 05/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    
    // Default selected 'unitTypes' Array Int Index#
    @State private var selectedUnitType = 0
    
    // Type Annotate 'Dimension' to allow 'var's to hold all subClasses from 'Dimension' class
    @State private var inputUnit: Dimension = UnitMass.grams
    @State private var outputUnit: Dimension = UnitMass.kilograms

    // Focus State for "Input Value" TextField
    @FocusState var inputValueFocus: Bool
    
    //An Array to list the available Unit Types for conversion
    let conversions = ["Mass", "Temperature", "Time", "Distance", "Speed", "Fuel Efficiency"]
    
    // a TWO DIMENSIONAL Array - Array Item in an Array that has its own unique set of Array & Items
    // The order of the Array has to correspond to the order in 'conversion' Array
    let unitTypes = [
        // Array for "Mass" unit type
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        // Array for "Temperature" unit type
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        // Array for "Time" unit type
        [UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours],
        // Array for "Distance" unit type
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],
        // Array for "Speed" unit type
        [UnitSpeed.kilometersPerHour, UnitSpeed.milesPerHour, UnitSpeed.knots],
        // Array for "Fuel Efficiency" unit type
        [UnitFuelEfficiency.litersPer100Kilometers, UnitFuelEfficiency.milesPerGallon, UnitFuelEfficiency.milesPerImperialGallon]
    ]
    
    
    // Handle Input & Input Unit
    
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
                
                
                // Conversion Type, FROM & TO Section Section
                Section {
                    Picker("Type:", selection: $selectedUnitType) {
                        // Counting Int up to the amount of Item in 'conversions' Array
                        ForEach(0..<conversions.count) {
                            Text(conversions[$0])
                        }
                    }
     
                    Picker("From:", selection: $inputUnit) {
                        ForEach(unitTypes[selectedUnitType], id: \.self) {
                            Text(unitFormatter.string(from: $0).capitalized)
                        }
                    }

                    Picker("To:", selection: $outputUnit) {
                        ForEach(unitTypes[selectedUnitType], id: \.self) {
                            Text(unitFormatter.string(from: $0).capitalized)
                        }
                    }
                } header: {
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
                // Modifier to select a default Unit Types for our From & To w/ its appropriate default Choices
                .onChange(of: selectedUnitType) { newSelectedUnit in
                    let units = unitTypes[newSelectedUnit]
                    inputUnit = units[0] // Choice the 1st position Item from the Array for each unitTypes
                    outputUnit = units[1] // Choice the 2nd position Item the Array for each unitTypes
                    
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
