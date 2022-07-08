//
//  ContentView.swift
//  Views and Modifiers
//
//  Created by Paul Andri on 07/08/2022.
//

import SwiftUI

/*
struct ContentView: View {
    
    // 'some' - OPAQUE Return Type
    // 'some View' - will return some value Type that CONFORMS to the View Protocol
    // SwiftUI will find out what kind it is automatically
    var body: some View {
        
        /*
        // VIEW MODIFIER works by create a copy the original View, then apply the defined change(s)
        Text("Hello, world!")
            // Copy the Text View abover and apply this 'frame' Modifier
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // 'maxWidth' & 'maxHeight' = Maximum possible Width & Height. NOT absolute H & W!
         
            // Copy the 'frame' View above and apply the 'background' Modifier
            .background(.red)   // Define red background for the Text View above
         */
        
        
        /*
        // THE ORDER OF VIEW MODIFIER stack MATTERS!
        Button("I'm a Button") {
            print(type(of: self.body)) // Prints out what type(s) our this 'self' View is/are
            // 'type(of:)' Method prints the exact Type(s) of any value we defined
        }
        /* MAKE THE BACKGROUND RED, THEN CREATE A FRAME
        .background(.red)
        .frame(width: 200, height: 200)
         */
        // VS
        // CREATE A FRAME, THEN MAKE ITS BACKGROUND RED
        .frame(width: 200, height: 200)
        .background(.red)
        */
        
        
        /*
        // APPLYING THE SAME MODIFIER MULTIPLE TIMES TO A VIEW
        Text("Hello World!")
            .padding()
            .background(.red)
            .padding()
            .background(.blue)
            .padding()
            .background(.white)
            .padding()
            .background(.black)
         */
        
        
        
        //  'TUPLE' VIEW TYPE - HOLDS & HANDLE 2 - 10 DIFFERENT VIEWS IN ONE PLACE
        // THE REASON SWIFTUI HAVE A MAX. 10-CHILD VIEWS LIMITATION
        // NOTE: 'ForEach()' Loop Method DO NOT USE 'TUPLE' VIEW TYPE
        
        /*
        // This VStack holds a 'TUPLE' View, which holds exactly 4 different Text Views
        VStack {
            Text("Hello")
            Text("World")
            Text("Goodbye")
            Text("World")
        }
         */
        
        
        /*
        // '@ViewBuilder' on multiple different Views
        // Swift silently applies a special attribute to the 'body' Property called '@ViewBuilder'
        // Syntax: '@ViewBuilder var body: Self.Body { get }'
        // This silently wrap multiple 'Views' in one 'Tuple View' containers
        // Even though it looks like we’re sending back multiple 'Views', they get combined into one 'Tuple View'.
        // What it looks like:
        var body: some View {
         Text("Hello")
         Text("World")
         Text("Goodbye")
         Text("World")
        }
         
        // What really happened behind the scene
        @ViewBuilder var body: Self.Body { get
         Text("Hello")
         Text("World")
         Text("Goodbye")
         Text("World")
        }
        */
        
        
        
    }
}
 */



/*
// CONDITIONAL MODIFIERS
// TERNARY CONDITIONAL OPERATOR is the PREFERRED WAY to use for CONDTIONAL MODIFIERS in SwiftUI
 
struct ContentView: View {
    @State private var useRedText = false   // Program State Property
    
    var body: some View {
        Button("Hello") {
            // 'toggle()' - toggles the value of 'useRedText' between 'true' or 'false'
            useRedText.toggle()
        }
        // CONDITIONAL MODIFIER that uses Ternary Conditional Operator
        .foregroundColor(useRedText ? .red : .blue)
        
        /*
        // The conventional (LONGER) 'if-else' Statement version would be:
        if useRedText {
            Button("Hello") {
                useRedText.toggle()
            }
            .foregroundColor(.red)
        } else {
            Button("Hello") {
                useRedText.toggle()
            }
            .foregroundColor(.blue)
        }
        */
        
    }
}
*/



/*
// ENVIRONMENT MODIFIERS - Modifiers applied to a Container (ie. 'VStack' etc)
// A Child View can OVERRIDE its Environment Modifiers
// A Child View's Modifier is PRIORITIZED OVER ITS ENVIRONMENT MODIFIERS
// NOTE: NOT ALL MODIFIERS IS AN ENVIRONMENT MODIFIER
// TIP: Look out for Keyword 'environment' & 'override' in Quick Help window to know if a Modifier is also an Enviroment Modifier
 
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Alpha")
                // This Child View's Modifier OVERRIDEs its Enviromental Modifiers
                .font(.largeTitle)
            
            Text("Beta")
            Text("Gamma")
            Text("Delta")
        }
        // This is an ENVIROMENTAL MODIFIERS
        // Applied to all Child Views in the 'VStack' Container
        .font(.title)
    }
}
*/



/*
// MAKE COMPLEX VIEW HIERARCHY BY USING VIEWS AS PROPERTIES
// Helpful for keeping complex codes out of the 'body' Property

struct ContentView: View {
    // a Stored Property
    let motto1 = Text("Bla Bla Bla")
    
    // a Computed Property
    var motto2: some View {
        Text("Bla Bla Bla ") + motto1
    }
    
    // Send back multiple Views in a Property using a 'Stack' View
    var motto3: some View {
        VStack {
            Text("Lorem")
            Text("Ipsum")
        }
    }
    
    // Send back multiple Views in a Property using 'Group' View
    // The arrangement of a 'Group' View stack is determined by how/where they're used
    // Ex: Vertically inside a 'VStack', Horizontally inside a 'HStack'
    var motto4: some View {
        Group {
            Text("I'm Text 1")
            Text("I'm Text 2")
        }
    }
    
    // PREFERRED WAY - MIMICS THE BEHAVIOUR OF MULTIPLE VIEWS HANDLING from 'body' PROPERTY
    // '@ViewBuilder' - Manually wrap Views within the Property into a 'Tuple' View
    @ViewBuilder var tupleView: some View {
        Text("Hello!")
        Text("Please wrap me!")
    }
    
    
    var body: some View {
        VStack {
            // Using Properties as Views
            motto1
            motto2
                // Add Modifier to the Property View
                .foregroundColor(.red)
        }
    }
}
*/



/*
// VIEW COMPOSITION
// BREAKDOWN BIG COMPLEX VIEW INTO MANY SMALLER VIEWS

// Create new Struct that CONFORMS to 'View' Protocol
struct CapsuleText: View {
    var text: String    // an Empty String Property
    
    var body: some View {
        Text(text)  // 'Text' View + its set of View Modifiers
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            // Create new Views out of the 'CapsuleText' Struct w/ its sets of Modifiers
            CapsuleText(text: "Hello!")
                .foregroundColor(.white)    // Add extra View Modifier
            CapsuleText(text: "It's me!")
                .foregroundColor(.yellow)     // Add extra View Modifier
        }
    }
}
*/




// CUSTOM VIEW MODIFIER

// CREATE A CUSTOM VIEW MODIFIER
// Create new Struct that CONFORMS to 'ViewModifier' Protocol
struct Title: ViewModifier {
    // The only requirements is to create a Method called 'body' that accept a 'Content'
    // Will return an OPAQUE Type 'View'
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// Wrap our CUSTOM VIEW MODIFIER Struct as an Extension for 'View' Protocol
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

// Create new Struct that CONFORMS to 'ViewModifier' Protocol
struct Watermark: ViewModifier {
    var text: String    // custom Stored Property
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.primary)
                .padding(5)
                .background(.thinMaterial)
        }
    }
}

// Wrap our CUSTOM VIEW MODIFIER Struct as an Extension for 'View' Protocol
extension View {
    func addWatermark(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}


struct ContentView: View {
 
    var body: some View {
        ZStack {
            Color.black
                .frame(width: 300, height: 200)
                .addWatermark(with: "© Paul Andri")
            
            Text("I'm a Text!")
                // Apply a Custom View Modifier as an Extension of 'View' Protocol
                .titleStyle()
        }
    }
}




/*
// CUSTOM CONTAINERS

// ADVANCED SWIFT
// '<Content: >' Swift Generics - pass whatever 'Content' but it must CONFORM to a certain Protocol
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    
    // A Closure that defines a Function that must accept 2 Int values
    // WIll return some kind of 'Content' View
    // Added '@ViewBuilder' to automatically warp multiple Views into a 'Tuple' View
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
 

struct ContentView: View {
    var body: some View {
        // Use the Custom Container Struct
        GridStack(rows: 4, columns: 4) { row, col in
            // Special syntax to calculate & represent the result inside a circle shape
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}
*/



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
