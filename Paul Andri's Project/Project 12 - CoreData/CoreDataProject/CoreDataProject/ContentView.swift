//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/13/2022.
//

import SwiftUI


// WHY '\.self' WORKS AS AN INDENTIFIER IN 'ForEach' LOOP
//
// SIMPLE LIST W/ '\.self' IDENTIFIER
/*
struct ContentView: View {
    var body: some View {
        List {
            // HOW '\.self' IDENTIFIER WORK:
            /*
             Swift computes the fixed-size hash value of the Object, then uses that hash as its unique Identifier
            
             '\.self' CAN ALSO BE USED W/ COREDATA:
             Xcode generates a Class that conforms to the 'Hashable' Protocol for our Managed Object,
             so we can use '\.self' as the Identifier.
             
             'String' & 'Int' Data Types are also conforming to the 'Hashable' Protocols
             Making '\.self' usable for their unique Identifier.
             */
            ForEach([2, 4, 6, 8, 10], id: \.self) {
                Text("\($0) is an even number")
            }
        }
    }
}
*/



// '\.self' AS IDENTIFIER FOR ANY DATA THAT CONFORMING TO THE 'Hashable' PROTOCOL
/*
// A DATA TYPE STRUCT THAT CONFORMS TO 'Hashable' PROTOCOL
struct Student: Hashable {
    // 'String' Data Type itself conforms to the 'Hashable' Protocols
    // Making '\.self' usable for their unique Identifier.
    let name: String
}

struct ContentView: View {
    // PROPERTY THAT STORES AN ARRAY OF 'Student' DATA TYPE STRUCT INSTANCES (HASHABLE DATA)
    let students = [
        Student(name: "Harry Potter"),
        Student(name: "Hermione Granger")
    ]
    
    var body: some View {
        // DYNAMICALLY GENERATED LIST USING 'students' HASHABLE DATA
        // '\.self' IDENTIFIER WORKS WITH ANY "HASHSABLE" DATA
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}
*/



// CONDITIONAL DATA SAVING TO COREDATA
/*
struct ContentView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button {
            // CONDITONAL DATA SAVING TO 'managedObjectContext':
            // '.hasCHanges' - CHECK WHETHER THERE'RE DATA CHANGES FROM 'managedObjectContext'
            if moc.hasChanges {
                // IF THERE'RE DATA CHANGES:
                // TRY SAVING "LIVE" DATA TO 'managedObjectContext'
                try? moc.save()
            }
        } label: {
            Label("Save", systemImage: "sdcard.fill")
                .foregroundColor(.white)
                .labelStyle(.titleAndIcon)
                .padding()
                .background {
                    Color.green
                        .clipShape(Capsule())
                }
        }
    }
}
*/



// ENSURE COREDATA OBJECT UNIQUENESS BY USING "CONSTRAINTS"
// Make an Attribute "constrained" so that it MUST always be unique
/*
struct ContentView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    // FETCHREQUEST PROPERTY W/ 'Wizard' TYPE DATA
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            // DYNAMIC LIST GENERATED FROM 'wizards' DATA
            List(wizards, id: \.self) { wizard in
                // TEXT VIEW SHOWING 'name' VALUE / DEFAULT VALUE
                Text(wizard.name ?? "Unknown")
            }
            
            
            // 'Wizard' OBJECT CONSTRAINT: 'name' VALUE MUST BE UNIQUE/ NO DUPLICATE
            // TESTING OUR OBJECT CONSTRAINT:
            
            // STEP 1: CREATE 'Wizard' OBJECTS W/ DUPLICATE 'name' VALUE
            // BUTTON TO ADD NEW 'Wizard' OBJECT INSTANCE IN 'managedObjectContext'
            // MAKE NEW 'Wizard' OBJECT ON EACH TAP
            // BUT THE 'name' VALUE IS ALWAYS THE SAME/DUPLICATE
            Button {
                // CREATE A 'Wizard' OBJECT IN 'managedObjectContext'
                let wizard = Wizard(context: moc)
                
                // ASSIGN THE SAME 'Harry Potter' VALUE TO 'name' EACH TIME THE BUTTON IS PRESSED
                wizard.name = "Harry Potter"
                
            } label: {
                Label("Add", systemImage: "wand.and.stars")
                    .foregroundColor(.white)
                    .padding()
                    .labelStyle(.titleAndIcon)
                    .background {
                        Color.purple
                            .clipShape(Capsule())
                    }
            }
            
            // STEP 2: TRY TO SAVE THE 'Wizard' OBJECT W/ DUPLICATE 'name' VALUES INTO COREDATA
            // BUTTON TO SAVE DATA CHANGES TO 'managedObjectContext'
            Button {
                // DO BLOCK TO TRY SAVING "LIVE" DATA INTO 'managedObjectContext'
                // RESULT: WON'T SAVE & SHOULD RETURN AN ERROR MESSAGE:
                // 'The operation couldn’t be completed. (Cocoa error 133021.)'
                do {
                    try moc.save()
                } catch {
                    // CATCH ANY ERROR W/ LOCALISED DESCRIPTION
                    print(error.localizedDescription)
                }
            } label: {
                Label("Save", systemImage: "sdcard.fill")
                    .foregroundColor(.white)
                    .padding()
                    .labelStyle(.titleAndIcon)
                    .background {
                        Color.green
                            .clipShape(Capsule())
                    }
            }
        }
    }
}
*/



//
//
struct ContentView: View {
    var body: some View {
        Text("")
    }
}
//
 
 
 
/*
//
struct ContentView: View {
    var body: some View {
        Text("")
    }
}
//

 
 
//
//
struct ContentView: View {
    var body: some View {
        Text("")
    }
}
*/



// PREVIEW CANVAS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
