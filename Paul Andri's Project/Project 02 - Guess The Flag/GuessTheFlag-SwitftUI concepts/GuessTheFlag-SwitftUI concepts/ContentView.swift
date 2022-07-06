//
//  ContentView.swift
//  GuessTheFlag-SwitftUI concepts
//
//  Created by Paul Andri on 06/07/22.
//

import SwiftUI

/*struct ContentView: View {
    
    // 'VStack' View
    /*var body: some View {
        // 'VStack' - stacking Views VERTICALLY (max. 10 children)
        VStack(alignment: .leading, spacing: 20) {
        // '(alignment: )' - VStack Views alignment
        // Available aligments: '.center', '.leading' (Left), '.trailing' (Right)
        // '(spacing: )' - give a Xpoint amount of spacing in between Views
            
            Spacer()
            Text("Hello, world!")
            Text("Hello, world! AGAIN!")
            Spacer()
            Spacer()
            // We could use 'Spacer()' within VStack
        }
    }*/
    
    
    /* 'HStack' View
    var body: some View {
        // 'HStack' - stacking Views side-by-side HORIZONTALLY (max. 10 children)
        HStack(spacing: 20) {
            Spacer()
            Text("Hello, world!")
            Text("Hello, world! AGAIN!")
            Spacer()
            Spacer()
            // We could use 'Spacer()' within HStack
        }
    }*/
    
    
    // 'ZStack' View
    /*var body: some View {
        // 'HStack' - stacking Views by DEPTH/Overlap (max. 10 children)
        ZStack {
            // 'ZStack' draws its View from the top to bottom, the sequence matters!
            Text("Hello, world!") // This View will be the "Back" View
            Text("Hello, world! AGAIN!") // This View will be the "Front" View
        }
    }*/
    
    
    // Combining 'VStack' & 'HStack' Views to create a 3x3 grid
    /*var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Text("1")
                Text("2")
                Text("3")
            }
            
            HStack(spacing: 20) {
                Text("4")
                Text("5")
                Text("6")
            }
            
            HStack(spacing: 20) {
                Text("7")
                Text("8")
                Text("9")
            }
        }
    }*/
    
    
    
    
    
    // SwiftUI's 'Color' View
    /*var body: some View {
        ZStack {
            
            // 'Color' is a 'View'
            Color.blue // Fills the entire 'View' w/ colour Blue (NOT incl. OUTSIDE safe areas)
                // '.frame()' // View Modifier for 'Color'
                .frame(minHeight: 200, maxHeight: 600) // Specify min & max Height of 'Color' View
                // Many more Parameters that could be set with '.frame' View Modifier
            
            Text("Content")
        }
        //.background(.red) // Fills only the background of 'ZStack' w/ colour Red
    }*/
    
    
    // Using custom RGB colour value for 'Color' View
    /*var body: some View {
            Color(red: 0 , green: 5, blue: 5)
    }*/
    
    
    // '.ignoresSafeArea()' - View Modifier to IGNORE SAFE AREA
    // WARNING: DO NOT PUT IMPORTANT ELEMENTS OUTSIDE THE SAFE AREA
    /*var body: some View {
        ZStack {
            Color.cyan
            Text("Content")
        }
        .ignoresSafeArea() // This Modifier let our ZStack View fills the entire iDevice screen
    }*/
    
    
    
    
    
    // Using 'Material'to " prettify" our Views
    /*var body: some View {
        ZStack {
            VStack(spacing: 0) { // Added '(spacing: 0)' to ensure NO spacing between the VStack Views
                Color.yellow
                Color.purple
            }
            
            // 'Text' & its View Modifiers
            Text("Content")
                .foregroundStyle(.secondary) // '.secondary' reacts to iDevice's Light/Dark Mode
                // Subtle difference from '.foregroundColor'
                // '.foregroundStyle' allows its back layer in ZStack to subtlely shown through
            
                .padding(50)
            
                // Using '.ultraThinMaterial' as View's background - reacts to iDevice's Light/Dark Mode
                .background(.ultraThinMaterial) // Many more 'Material' available
        }
        .ignoresSafeArea() // This Modifier let our ZStack View fills the entire iDevice screen
    }*/
    
    
    
    
    
    // SwiftUI's Three different GRADIENT Tool Views
    // 1. LINEAR GRADIENT - 'LinearGradient'
    /*var body: some View {
        // Simple 'LinearGradient' (Soft Gradient)
        /*LinearGradient(
            gradient: Gradient(colors: [.red, .white]),
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )*/
        
        // 'LinearGradient' with custom Gradient Points (Sharper Gradient)
        LinearGradient(gradient: Gradient(stops: [
            .init(color: .red, location: 0.45), // '0.45' starts from 45%
            .init(color: .white, location: 0.55) // '0.55' starts from 55%
            ]), startPoint: .topTrailing, endPoint: .bottomLeading
        )
        .ignoresSafeArea()
    }*/
    
    
    // 2. RADIAL GRADIENT - 'RadialGradient'
    // Creates a soft Circle-shaped Gradient
    /*var body: some View {
     RadialGradient(
     gradient: Gradient(colors: [.red, .white]),
     center: .topTrailing, startRadius: 20, endRadius: 500
     // 'center' = the center Position of the Radial Gradient
     // 'startRadius' & 'endRadius' = the size/scope of the Radial Gradient
     )
     }*/
    
    
    // 3. ANGULAR GRADIENT - 'AngularGradient'
    // Creates a Gradient that is encircled by a selection of colours
    /*var body: some View {
        AngularGradient(
            gradient: Gradient(colors: [.blue, .purple, . orange, .yellow]),
            center: .center
        )
        .ignoresSafeArea()
    }*/
    
    
    
    
    
    // SwiftUI's BUTTON - 'Button'
    
    // 'Button' with assigned 'role' & 'action' Parameters
    /*var body: some View {
        Button("Delete",
               // Assign a 'role' to the Button, great for screen reader / Accesibility
               // 'destructive' will delete / destruct item(s)
               // Will cause the 'Button' text to become Red in colour
               role: .destructive,
               action: deleteItem // 'action' - do this when 'Button' is pressed
        )
    }
    
    func deleteItem() {
        print("Item Deleted!")
    }*/
     
    
    // 'Button's with different kind of '.buttonStyle()'
    /*var body: some View {
        VStack {
            // 'Button' with '.buttonStyle(.bordered)'
            Button("Button 1") { }
                .buttonStyle(.bordered)
            
            // 'destructive' 'Button' with '.buttonStyle(.bordered)'
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
                .tint(.yellow) // Change the Button text & border colour
            
            // 'Button' with '.buttonStyle(.borderedProminent)'
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.orange) // Change the border colour
            
            // 'destructive' 'Button' with '.buttonStyle(.borderedProminent)'
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            
            // NOTE: Use 'borderedProminent' sparingly to ONLY certain important 'Button's
        }
    }*/
     
    
    // Customising 'Button' appearance with Trailing Closures
    /*var body: some View {
        Button {
            print("Tapped!")
        } label: {
            Text("Tap Here!")
                .padding()
                .foregroundColor(.white) // colour for the Button's Text Label
                .background(.red) // colour for the Button itself
        }
    }*/
    
     
     
    
    
    // Three Main ways to handle Images in Swift - 'Image'
    /*var body: some View {
        
        // 1. Syntax: 'Image("imageName")'
        // Load an image called “imageName” that have been added to the project's asset.
        // Screen Reader will read out the "imageName" to the users who have enabled it.
        
        // 2. Syntax: 'Image(decorative: "imageName")'
        // Load the image as before, BUT won’t read it out for users who have enabled the Screen Reader.
        // Useful for images that DON'T convey additional important information.
        
        // 3. Syntax: 'Image(systemName: "eyes")'
        // Load the "eyes" icon that is built into iOS. This uses Apple’s SF Symbols icon collection
        Image(systemName: "eyes")
    }*/
     
    
    // Using an Image in a 'Button's Label
    /*var body: some View {
        VStack(spacing: 50) {
            // Using 'Image(systemName: )' as a Button's label
            Button {
                print("Ouch!")
            } label: {
                Image(systemName: "eyes")
            }
            
            // Using 'Label()' to allow both Text String & 'systemImage' as a Button's label
            Button {
                print("Settings Tap!")
            } label: {
                Label("Settings", systemImage: "gear")
                // 'systemImage' is similar to 'Image(systemName: )' in this context
            }
            // Use '.renderingMode(.original)' here to force SwiftUI to show the original Image without colouring it Blue. !ONLY APPLICABLE FOR NON-SYSTEM IMAGES!
        }
    }*/
}*/





// Showing ALERT messages to the user with SwiftUI
// A Pop-up window containing a Title, a Message & CTA Button(s)
struct ContentView: View {
    // Showing an Alert window is a Program State
    @State private var showAlert = false // default value is set to 'false'
    // This will change to 'true' whenever the Button is tapped; which will trigger the '.alert' Button Modifier to show Alert window
    // NOTE: SwiftUI will ALWAYS set 'showAlert' value back to 'false' each time the Alert window is dismissed
    
    var body: some View {
        Button { // Tap this Button to show the Alert message
            showAlert = true // 'showAlert' value to 'true' everytime the Button is tapped
        } label: {
            Label("Show Alert!", systemImage: "exclamationmark.shield.fill")
        }
        // '.alert()' - An Alert Modifier that is attached to a Button
        .alert("WARNING", isPresented: $showAlert) { // bind to 'showAlert' program state
            // Create a 'DELETE' button w/ 'destructive' role to dismiss the alert window
            Button("CANCEL", role: .destructive) { }
            // Create a 'CANCEL' button w/ 'cancel' role to dismiss the alert window
            Button("OK", role: .cancel) { }
        }
        // Add body text to Alert window
        message: {
            Text("Unable to execute your request!")
        }
    }
     
      
    /*
     var body: some View {
        Text("")
     }
     
     var body: some View {
        Text("")
     }
     
     var body: some View {
        Text("")
     }
     */
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
