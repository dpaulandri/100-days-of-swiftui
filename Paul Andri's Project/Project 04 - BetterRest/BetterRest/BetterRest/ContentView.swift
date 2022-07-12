//
//  ContentView.swift
//  BetterRest
//
//  Created by Paul Andri on 07/11/2022.
//

// import CoreML Machine Learning framework into our App
import CoreML
import SwiftUI

struct ContentView: View {
    // Program State Property to store the desired wakeUpTime
    @State private var wakeUpTime = defaultWakeUpTime
    
    // Program State Property to store the desired duration for sleep
    @State private var sleepDuration = 8.0
    
    // Program State Property to store the amount of coffee serving drank
    // OG CODE: '@State private var coffeeIntake = 1'
    // INITIAL VALUE ADJUSTED FOR CHALLENGE #2 'Picker View'
    @State private var coffeeIntake = 0


    // ALERT WINDOW PROGRAM STATE PROPERTIES
    // Program State Properties to store the title String for Alert window
    @State private var alertTitle = ""
    
    // Program State Properties to store the Message String for Alert window
    @State private var alertMsg = ""
    
    // Program State Properties to store Bool value of whether the Alert window is currently shown
    @State private var showAlert = false
    
    
    // A 'static' COMPUTED PROPERTY TO USE AS THE APPROPRIATE DEFAULT VALUE for 'wakeUpTime'
    static var defaultWakeUpTime: Date {
        // Create a 'var' with 'DateComponents()' Method as its value
        var components = DateComponents()
        // Set the value for 'hour' component
        components.hour = 7
        // Set the value for 'hour' component
        components.minute = 0
        
        // return a 'Date' Data Type from 'components'
        return Calendar.current.date(from: components) ?? Date.now  // Use '??' to provide default value
    }
    
    
    // PART OF CHALLENGE #3 CODE
    // A COMPUTED 'String' PROPERTY USING 'CoreML'
    var idealBedtime: String {
        do {
            // SETTING BASE DATA MODEL & ML CONFIGs
            // This Instance is when some obscure ML config options are needed
            let config = MLModelConfiguration()

            // This Instance tries to read our 'SleepModel' ML model datas & return a prediction
            // In theory, it is possible for fail in making prediction and throw an Error
            let model = try SleepModel(configuration: config)
            
            
            // PREPARING OUR USER INPUT DATAs TO FEED INTO 'CoreML'
            // Create a Property that stores current Hour & Minute components from our State Program Property 'wakeupTime' value
            let components = Calendar.current.dateComponents([.hour, .minute],from: wakeUpTime)
            
            // Create 'hour' & 'minute' Properties with values from 'components'
            // Both would return Optional 'Int?', so we provide default value using '??'
            let hour = (components.hour ?? 0) * 60 * 60 // Convert to seconds
            let minute = (components.minute ?? 0) * 60 // Convert to seconds
            
            
            // FEEDING OUR PREPARED DATAs INTO 'CoreML' FOR PREDICTION
            // 'prediction' = actual amount of sleep needed predicted with ML datas from 'SleepModel'
            let prediction = try model.prediction(
                // Convert 'Int' into 'Double'
                wake: Double(hour + minute),
                
                // 'sleepDuration' is already a 'Double' Data type
                estimatedSleep: sleepDuration,
                
                // Convert 'Int' into 'Double'
                coffee: Double(coffeeIntake)
            )
            
            
            // CREATE A COMPUTED PROPERTY USING THE RESULT OF 'actualSleep' VALUE FROM 'prediction'
            // Using 'actualSleep' value from 'prediction' result to calculate the "Best Time to Sleep"
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {   // Create 'catch' block to catch any possible Error thrown
            
            // IF AN ERROR IS THROWN
            return "Oops! Unable to calculate your bedtime."
            
        }
        
    }
    
    
    
    var body: some View {
        
        // Add Navigation View
        NavigationView {
            
            // Add 'Form' View
            Form {
                
                // PART OF CHALLENGE #1 CODE
                // Wakeup Time Section
                Section("Wake-Up Time") {
                    
                    HStack {
                        
                        // Add "sun.max.fill" SF symbol to represent "Wake-Up Time"
                        Image(systemName: "sun.max.fill")
                        
                        Spacer()
                        
                        // 'DatePicker' for picking the desired Wake Up TIme
                        DatePicker(
                            "Select Time",
                            selection: $wakeUpTime, // binded to 'WakeUpTime' Program State Property
                            displayedComponents: .hourAndMinute  // display only Hour & Minute components
                        )
                        
                    }
                    
                }
                
                
                // PART OF CHALLENGE #1 CODE
                // Desired Amount of Sleep Section
                Section("Sleep Duration") {
                    
                    HStack {
                        
                        // Add "bed.double.fill" SF symbol to represent "Sleep Duration"
                        Image(systemName: "bed.double.fill")
                        
                        // 'Stepper' to input the desired amount of Sleep
                        Stepper(
                            "\(sleepDuration.formatted()) hours",
                            value: $sleepDuration,  // binded to '$sleepDuration' Program State Property
                            in: 4...12, // Valid range from 4-12
                            step: 0.25  // Increase/Decrease value by 0.25/step
                        )
                        
                    }
                    
                }
                
                
                // PART OF CHALLENGE #1 CODE
                // Coffee Intake Section
                Section("Coffee Intake") {
                    
                    HStack {
                        
                        // Add "cup.and.saucer.fill" SF symbol to represent "Coffee Intake"
                        Image(systemName: "cup.and.saucer.fill")
                        
                        
                        /*
                         // 'Stepper' to input the amount of coffee intake
                         Stepper(
                         "\(coffeeIntake) \(coffeeIntake > 1 ? "cups" : "cup")",
                         value: $coffeeIntake,
                         in: 1...20
                         )
                         */
                        
                        // PART OF CHALLENGE #2 CODE
                        Picker("Today's Intake", selection: $coffeeIntake) {
                            // Coffee Intake range from 0 - 20 cups
                            ForEach(0..<21) {
                                Text("\($0) \($0 > 1 ? "cups" : "cup")")
                            }
                        }
                        // !!! BUG ALERT !!!
                        // LABEL IS NOT HIDDEN ON THE PICKER VIEW on Xcode Ver. 13.4.1 (13F100)
                        .labelsHidden()
                        
                    }
                    
                }
                
                
                // PART OF CHALLENGE #3 CODE
                Section("Ideal Bedtime") {
                    
                    HStack {
                        
                        // Add "cup.and.saucer.fill" SF symbol to represent "Coffee Intake"
                        Image(systemName: "powersleep")
                        
                        Text(idealBedtime)
                            .font(.largeTitle)
                        
                    }
                    // Aligning HStack View to the center
                    .frame(maxWidth: .infinity,alignment: .center)
                    
                }
                // Aligning Section View to the center
                .frame(maxWidth: .infinity,alignment: .center)
                
            }
            // Add Navigation View Title to 'Form''
            .navigationTitle("BetterRest")
            
            
            /* MADE REDUNDANT BY CHALLENGE #3
             // Add Toolbar Modifier to 'Form''
             .toolbar {
             // Add a "Calculate" Button to the top right corner
             // Triggers 'calculateBedtime' Method
             Button("Calculate", action: calculateBedtime)
             }
             
             // ALERT WINDOW MODIFIERS
             // Binded to 'showAlert' Program State
             .alert(alertTitle, isPresented: $showAlert) {
             // Button does nothing, only to dismiss Alert window
             Button("OK") { }
             } message: {
             // Show 'alertMsg' String value as the Alert window message
             Text(alertMsg)
             }
             */
            
        }
    }
    
    
    /* MADE REDUNDANT BY CHALLENGE #3
    // METHOD: CALCULATING THE BEST TIME TO SLEEP W/ 'CoreML'
    // Triggered by tapping "Calculate" Button on the Top Right
    func calculateBedtime() {
        
        // Create 'do' block
        do {
            // SETTING BASE DATA MODEL & ML CONFIGs
            // This Instance is when some obscure ML config options are needed
            let config = MLModelConfiguration()

            // This Instance tries to read our 'SleepModel' ML model datas & return a prediction
            // In theory, it is possible for fail in making prediction and throw an Error
            let model = try SleepModel(configuration: config)
            
            
            // PREPARING OUR USER INPUT DATAs TO FEED INTO 'CoreML'
            // Create a Property that stores current Hour & Minute components from our State Program Property 'wakeupTime' value
            let components = Calendar.current.dateComponents([.hour, .minute],from: wakeUpTime)
            
            // Create 'hour' & 'minute' Properties with values from 'components'
            // Both would return Optional 'Int?', so we provide default value using '??'
            let hour = (components.hour ?? 0) * 60 * 60 // Convert to seconds
            let minute = (components.minute ?? 0) * 60 // Convert to seconds
            
            
            // FEEDING OUR PREPARED DATAs INTO 'CoreML' FOR PREDICTION
            // 'prediction' = actual amount of sleep needed predicted with ML datas from 'SleepModel'
            let prediction = try model.prediction(
                // Convert 'Int' into 'Double'
                wake: Double(hour + minute),
     
                // 'sleepDuration' is already a 'Double' Data type
                estimatedSleep: sleepDuration,
                
                // Convert 'Int' into 'Double'
                coffee: Double(coffeeIntake)
            )
            
            
            // CREATE A COMPUTED PROPERTY USING THE RESULT OF 'actualSleep' VALUE FROM 'prediction'
            // Using 'actualSleep' value from 'prediction' result to calculate the "Best Time to Sleep"
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            
            // PROPERTIES & VALUES TO SET FOR ALERT WINDOW IF 'prediction' is SUCCESSFUL
            alertTitle = "Ideal Bedtime"
            // 'sleepTime' value is formatted to show only 'shortened' format of 'time' component
            alertMsg = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {   // Create 'catch' block to catch any possible Error thrown
            
            // IF AN ERROR IS THROWN
            // Set these values to its Properties
            alertTitle = "Error"
            alertMsg = "Oops! Unable to calculate your bedtime."
            
        }
        
        // SHOW ALERT WINDOW TO USER REGARDLESS WHETHER THE 'CoreML' PREDITION IS SUCCESSFUL OR NOT
        // Change 'showAlert' Program State to 'true'
        showAlert = true
        
    }
    */
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
