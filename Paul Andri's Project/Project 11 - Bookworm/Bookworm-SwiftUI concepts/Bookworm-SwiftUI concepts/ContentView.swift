//
//  ContentView.swift
//  Bookworm-SwiftUI concepts
//
//  Created by Paul Andri on 08/10/2022.
//

import SwiftUI


// CREATE CUSTOM COMPONENT W/ @'Binding' PROPERTY WRAPPER
// '@Binding' - Allow sharing of a local '@State' Property Data w/ another View
/*
// PUSHBUTTON VIEW STRUCT
struct PushButton: View {
    // BUTTON TITLE PROPERTY
    let title: String
    // "BINDING" PROPERTY
    @Binding var isOn: Bool
    
    // COLOUR ARRAYS FOR USE AS GRADIENT COLOURS
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)] // SHADES OF GRAY
    
    // MAIN BODY VIEW
    var body: some View {
        // BUTTON INPUT VIEW
        Button(title) {
            // TOGGLE 'isOn' STATE PPROPERTY BOOL VALUE
            isOn.toggle()
        }
        // BUTTON VIEW MODIFIERS
        .padding()
        .background(
            LinearGradient(
                // TERNARY CONDITIONAL OPERATOR FOR BUTTON'S GRADIENT COLOURS
                colors: isOn ? onColors : offColors,
                startPoint: .topTrailing, endPoint: .bottomLeading
            )
        )
        .foregroundColor(.white)
        .clipShape(Capsule())
        // TERNARY CONDITIONAL OPERATOR FOR FOR SHADOW RADIUS AMOUNT
        .shadow(radius: isOn ? 0 : 5)
    }
}

// MAIN CONTENT VIEW STRUCT
struct ContentView: View {
    // STATE PROPERTY TO STORE TOGGLE INPUT BOOL VALUE
    // 'rememberMe' IS BOUND TO THE 'isOn' BINDING PROPERTY INSIDE 'PushButton' VIEW STRUCT
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            
            // SHOW 'PushButton' VIEW
            // 'isOn' BINDING PROPERTY VALUE IS BOUND TO CONTENTVIEW'S 'rememberMe' STATE PROPERTY
            PushButton(title: "Remember Me", isOn: $rememberMe)
            
            // TERNARY CONDITIONAL OPERATOR FOR TEXT STRING VALUE
            Text(rememberMe ? "ON" : "OFF")
            
        }
    }
}
*/



// MULTI-LINE TEXT INPUT W/ 'TextEditor' INPUT VIEW
/*
struct ContentView: View {
    // 'AppStorage' PROPERTY
    /* '@AppStorage' Property Wrapper:
     - Stores & Reflects a value from 'UserDefaults'
     - NOT designed to store sensitive/private Data
     - Invalidate a View whenever the Value is changed */
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            // TEXTEDITOR INPUT VIEW BOUND TO THE TEXT VALUE OF 'notes' APPSTORAGE PROPERTY
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}
*/



// 'CoreData' FRAMEWORK
/*
 - Define Objects and its Properties and R/W them from permanent storage
 - No limit to the amount of Data that can be stored
 - Advanced functionalities
 
 'CoreData' needs to know what all our Data Types look like, what it contains, and how it relates to each other.
 There are contained in a file type called 'Data Model' / “xcdatamodeld”
*/
//
struct ContentView: View {
    // @'Environment' PROPERTY TO ACCESS THE 'managedObjectContext' IN OUT SWIFTUI ENVIRONMENT
    @Environment(\.managedObjectContext) var moc // 'moc' "managedObjectContext"
    // 'managedObjectContext' - THE "LIVE" VERSION OF OUR DATA
    /* When you load objects and change them,
     those changes only exist in memory until you specifically save them back to the PERSISTENT STORES */
    
    // 'FetchRequest' PROPERTY:
    /*
     - Retrieve Data from 'CoreData'
     - Describe what Data we want, the Results sorting, and the Results filter
     - Ensure retrieved Data Results stay up-to-date & sync w/ UI View(s)
     - Takes at least one parameter for Result sorting
     - Returns an Optional Value
    */
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student> // 'Student' Data Model Entity
    // 'FetchRequest' PROPERTY SYNTAX LOGIC:
    /*
     1. MAKE A NEW FETCH REQUEST W/ NO SORTING SORTING
     2. PUT THE FETCHED RESULT DATA INTO A NEW VAR PROPERTY CALLED 'students'
     3. 'students' PROPERTY HAVE THE DATA TYPE OF FetchedResults<Student>
    */
    
    
    var body: some View {
        VStack {
            // MAKING USE OF 'students' 'FetchRequest' PROPERTY DATA IN A DYNAMIC LIST VIEW
            List(students) { student in // PASS-IN 'student' DATA VALUE
                Text(student.name ?? "Unknown") // USE '??' TO PROVIDE DEFAULT VALUE TO FALLBACK
            }
            
            // BUTTON VIEW TO WRITE STUDENT DATA TO COREDATA PERSISTENT STORE
            Button("Add Student") {
                // FIRST NAME ARRAY PROPERTY
                let firstNames = ["Ivar", "Sofiya", "Veronika", "Luna", "Roy"]
                // LAST NAME ARRAY PROPERTY
                let lastNames = ["Irving", "Tove", "Walterson", "Maëlle", "Mårtensson", "Ozzie"]
                
                // GENERATE RANDOM FIRST & LAST NAME FROM ITS RESPECTIVE PROPERTIES
                let chosenFirstName = firstNames.randomElement()!   // '!' FORCE UNWRAP
                let chosenLastName = lastNames.randomElement()!     // '!' FORCE UNWRAP
                
                
                // CREATE A NEW 'Student' NSManagedObject INSTANCE
                // IN THE 'context' OF 'moc' ENVIRONMENT PROPERTY
                let student = Student(context: moc)
                
                // ASSIGN VALUES TO 'student' PROPERTY
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                
                // TRY TO SAVED/WRITE 'student' PROPERTY VALUE INTO COREDATA PERSISTENT STORE
                // IN THEORY THIS STEP MIGHT FAIL
                try? moc.save()
            }
        }
    }
}
//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
