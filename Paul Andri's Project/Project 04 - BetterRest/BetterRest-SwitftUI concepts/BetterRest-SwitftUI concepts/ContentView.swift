//
//  ContentView.swift
//  BetterRest-SwitftUI concepts
//
//  Created by Paul Andri on 07/11/2022.
//

import SwiftUI


/*
// 'Stepper' User Input Method - Input a number value using '+' and '-' Buttons
struct ContentView: View {
    // Program State Property to store the amount of sleep hour
    @State private var sleepAmount = 8.0
    
    var body: some View {
        
        // 'Stepper' User Input Method
        Stepper("\(sleepAmount.formatted()) hours",
                // Bind the value of 'Stepper' to Property 'sleepAmount'
                value: $sleepAmount,
 
                // 'in:' defines the valid value range
                in: 4...12,
 
                // 'step:' defines the increase & decrease step-value for each button tapped
                step: 0.25
        )
    }
}
*/



/*
// 'DatePicker' User Input Method - Input Date & Time by selection
struct ContentView: View {
    // Program State Property to store the date & time for 'wakeUp'
    // 'Date.now' current system Date & Time
    @State private var wakeUp = Date.now
    
    // 'addingTimeInterval()' - Add X amount of seconds
    let tomorrow = Date.now.addingTimeInterval(86400)   // One Day = 86400secs
    
    var body: some View {
        
        // Setting "Time" using 'DatePicker' User Input Method
        DatePicker("Enter Wakeup Time:",
                   // Bind the value of 'DatePicker' to Property 'wakeUp'
                   selection: $wakeUp,
                   
                   // 'in:' defines the valid value range
                   // Below is a 'one-sided Range' that defines only the START of the range
                   in: Date.now...,
                   
                   // 'displayedComponents' - customise which element(s) of 'DatePicker' to show
                   // '.hourAndMinute' - show picker for "Hour" & "Minute" only
                   displayedComponents: .hourAndMinute
        )
        // '.labelsHidden()' - Hide the Label text on screen
        .labelsHidden() // Screen reader will still be able to read the Label
        
        
        
        // Setting "Date" using 'DatePicker' User Input Method
        DatePicker("Select Date:",
                   // Bind the value of 'DatePicker' to Property 'wakeUp'
                   selection: $wakeUp,
                   
                   // 'in:' defines the valid value range
                   // Below is a 'one-sided Range' that defines only the START of the range
                   // The valid & choosable range starts from 'Date.now' value
                   in: Date.now...,
                   
                   // 'displayedComponents' - customise which element(s) of 'DatePicker' to show
                   // '.hourAndMinute' - show picker for "Hour" & "Minute" only
                   displayedComponents: .date
        )
        // '.labelsHidden()' - Hide the Label text on screen
        .labelsHidden() // Screen reader will still be able to read the Label
        
    }
}
*/



// WORKING WITH DATES/TIME
struct ContentView: View {
    
    var body: some View {
        
        // DATE/TIME FORMATTING
        
        // 'formatted' Date/Time formatting
        Text(
            // Show current system Date/Time
            Date.now
                // '.formatted()' will adjust to device's Localisation format
                // 'date' is 'long' formatted, 'time is 'shortened' formatted
                .formatted(date: .long, time: .shortened)
        )
        
        // 'format:' Date/Time formatting
        Text(
            // Show current system Date/Time
            Date.now,
            
            // Format 'dateTime' as: 'hour' & 'minute'
            // 'format' will adjust to device's Localisation format
            format: .dateTime.hour().minute()
        )
        
        // 'format:' Date/Time formatting
        Text(
            // Show current system Date/Time
            Date.now,
            
            // Format 'dateTime' as: 'day', 'month' & 'year'
            // 'format' will adjust to device's Localisation format
            format: .dateTime.day().month().year()
        )
        
    }
    
    // Using Swift's 'DateComponents()'
    func trivialExample1() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        
        // This Property will always return an Optional 'Date?' value
        // We have to use Nil Coalescing '??' to provide a default 'Date' value
        let date = Calendar.current.date(from: components) ?? Date.now
    }
    
    // Specific what Components to return using 'dateComponents()'
    func trivialExample2() {
        // 'dateComponents()' to return the '.hour' & '.minute' components from current system Date/Time
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        
        // Use the '.hour' component Opt 'Int?' value from 'components' Property
        // Use '??' to provide default 'Int' value
        let hour = components.hour
        
        // Use the '.minute' component Opt 'Int?' value from 'components' Property
        // Use '??' to provide default 'Int' value
        let minute = components.minute ?? 0
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
