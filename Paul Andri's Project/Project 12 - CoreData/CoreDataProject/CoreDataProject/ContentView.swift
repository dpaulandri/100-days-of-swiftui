//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/13/2022.
//

import CoreData
import SwiftUI

// DAY 57 MATERIALS:
/*
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
*/



// DAY 58 MATERIALS:
//
// FILTER '@FetchRequest' USING 'NSPredicate' & 'NSCompoundPredicate'
// 'NSCompoundPredicate' - BUILD A COMPOUND PREDICATE OUT OF SEVERAL SMALLER ONES
/*
// PART OF // DATA FILTERING W/ 'NSCompoundPredicate' EXAMPLE:
// 'NSPrecidate' PROPERTY INSTANCES
let containsLetterE = NSPredicate(format: "name CONTAINS[s] %@", "e") // NOT CASE-SENSITIVE
let beginWithCaptialE = NSPredicate(format: "name BEGINSWITH %@", "E") // CASE-SENSITIVE
let notBeginWithCaptialE = NSPredicate(format: "NOT name BEGINSWITH %@", "E") // CASE-SENSITIVE

// 'NSCompoundPredicate' PROPERTY INSTANCES
// "AND" 'NSCompoundPredicate' PROPERTY INSTANCE
let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [containsLetterE, notBeginWithCaptialE])
// "OR" 'NSCompoundPredicate' PROPERTY INSTANCE
let orPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [containsLetterE, notBeginWithCaptialE])
// "NOT" 'NSCompoundPredicate' PROPERTY INSTANCE
let notPredicate = NSCompoundPredicate(notPredicateWithSubpredicate: beginWithCaptialE)



// MAIN CONTENTVIEW STRUCT
struct ContentView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    // FETCHREQUEST PROPERTY - NO FILTERING ('predicate: nil')
    // @FetchRequest(sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>
    
    // EXAMPLES OF DATA FILTERING W/ 'NSPredicate':
    /*
    // FETCHREQUEST PROPERTY - W/ FILTERING
    // SHOW ONLY RESULTS W/ "Star Wars" AS ITS 'universe' ATTRIBUTE VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #1
    // SHOW ONLY RESULTS W/ "Star Wars" AS ITS 'universe' ATTRIBUTE VALUE
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // FILTERING CAN USE OTHER "COMPARISON OPERATORS" SUCH AS '>' '<' ETC
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #2
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE "BEGIN" W/ THE ALPHABET BEFORE THE LETTER "F" (NOT CASE-SENSITIVE)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // FILTERING CAN USE OTHER "COMPARISON OPERATORS" SUCH AS '>' '<' ETC
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name < %@", "f")) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #3
    // SHOW RESULTS WHERE ITS 'universe' ATTRIBUTE VALUE "MATCHES" W/ ONE OF THE PASSED-IN ARRAY'S ITEM VALUE
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #4A
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE "BEGINS" W/ THE CAPITAL LETTER "E" (CASE-SENSITIVE)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", "E")) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #4B
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE "BEGINS" W/ THE CAPITAL LETTER "E" (NOT CASE-SENSITIVE)
    // THE ADDED '[c]' SYNTAX MAKE THIS FETCHREQUEST "NOT CASE-SENSITIVE" (REF. EX #4A)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #5A
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE THAT "CONTAINS" THE LETTER "a" (CASE-SENSITIVE)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS %@", "a")) var ships: FetchedResults<Ship>
    
    // FETCHREQUEST PROPERTY - W/ FILTERING (BETTER SYNTAX) - EX #5B
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE THAT "CONTAINS" THE LETTER "a" (NOT CASE-SENSITIVE)
    // THE ADDED '[c]' SYNTAX MAKE THIS FETCHREQUEST "NOT CASE-SENSITIVE" (REF. EX #5A)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS[c] %@", "E")) var ships: FetchedResults<Ship>
     
    // FETCHREQUEST PROPERTY - W/ "INVERSE 'NSPredicate' FILTERING" EXAMPLE
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE "DO NOT CONTAINS" THE LETTER "a" (NOT CASE-SENSITIVE)
    // WORKS W/ 'BEGINSWITH', 'CONTAINS', 'IN' ETC
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT name CONTAINS[s] %@", "a")) var ships: FetchedResults<Ship>
    */
    
    
    // EXAMPLES OF DATA FILTERING W/ 'NSCompoundPredicate':
    // 'NSCompoundPredicate' - BUILD A COMPOUND PREDICATE OUT OF SEVERAL SMALLER ONES
    //
    // FETCHREQUEST PROPERTY - W/ 'NSCompoundPredicate' FILTERING - EX#1 (AND)
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE "CONTAINS" A LETTER "E" (NOT CASE SENSITIVE),
    // AND "DOES NOT BEGIN" W/ CAPITAL LETTER "E" (CASE SENSITIVE)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: andPredicate) var ships: FetchedResults<Ship>
    
    
    // FETCHREQUEST PROPERTY - W/ 'NSCompoundPredicate' FILTERING - EX#2 (OR)
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE "CONTAINS" A LETTER "E" (NOT CASE SENSITIVE),
    // OR "DOES NOT BEGIN" W/ CAPITAL LETTER "E" (CASE SENSITIVE)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    @FetchRequest(sortDescriptors: [], predicate: orPredicate) var ships: FetchedResults<Ship>
    
    
    // FETCHREQUEST PROPERTY - W/ 'NSCompoundPredicate' FILTERING - EX#2 (OR)
    // SHOW RESULTS WHERE ITS 'name' ATTRIBUTE VALUE THAT "DOES NOT BEGIN" W/ CAPITAL LETTER "E" (CASE SENSITIVE)
    // '%@' IS A PLACEHOLDER THAT LINKS TO THE REAL FILTERING VALUE
    // @FetchRequest(sortDescriptors: [], predicate: notPredicate) var ships: FetchedResults<Ship>
    
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
        VStack {
            // SYNAMIC LIST GENERATED FROM 'ships' FETCHREQUEST DATAS
            List(ships, id: \.self) { ship in
                VStack(alignment: .leading) {
                    Text(ship.name ?? "Unknown Ship Name")
                        .font(.headline)
                    
                    Text(ship.universe ?? "Unknown Universe")
                        .font(.subheadline)
                }
            }
            
            // BUTTON TO ADD NEW EXAMPLE 'Ship' DATA OBJECTS
            Button {
                
                // SHIP #1:
                // CREATE A NEW 'Ship' OBJECT IN 'managedObjectContext' "LIVE" DATA
                let ship1 = Ship(context: moc)
                
                // ASSIGN VALUES TO 'ship1's OBJECT ATTRIBUTES
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                
                // SHIP #2:
                // CREATE A NEW 'Ship' OBJECT IN 'managedObjectContext' "LIVE" DATA
                let ship2 = Ship(context: moc)
                
                // ASSIGN VALUES TO 'ship1's OBJECT ATTRIBUTES
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                
                // SHIP #3:
                // CREATE A NEW 'Ship' OBJECT IN 'managedObjectContext' "LIVE" DATA
                let ship3 = Ship(context: moc)
                
                // ASSIGN VALUES TO 'ship1's OBJECT ATTRIBUTES
                ship3.name = "Millenium Falcon"
                ship3.universe = "Star Wars"
                
                
                // SHIP #4:
                // CREATE A NEW 'Ship' OBJECT IN 'managedObjectContext' "LIVE" DATA
                let ship4 = Ship(context: moc)
                
                // ASSIGN VALUES TO 'ship1's OBJECT ATTRIBUTES
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                // TRY TO SAVE THE "LIVE" DATA FROM 'managedObjectContext' INTO PERSISTENT STORAGE
                try? moc.save()
                
            } label: {
                Label("Add Ships", systemImage: "gyroscope")
                    .labelStyle(.titleAndIcon)
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        Color.blue
                            .clipShape(Capsule())
                    }
            }
        }
    }
}
*/
 
 
 
// DYNAMIC '@FetchRequest' FILTERING W/ SWIFTUI
/*
struct ContentView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    // STATE PROPERTY TO STORE LAST NAME FILTER STRING VALUE
    // SHOW ONLY THE SINGER W/ LAST NAME THAT STARTS W/ THE LETTER "A"
    @State private var lastNameFilter = "A"
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
        NavigationView {
            VStack {
                // SHOW 'FilteredSingerListView' USING 'lastNameFilter' PROPERTY AS ITS FETCHREQUEST FILTER ARGUMENT
                //FilteredSingerListView(filter: lastNameFilter)
                
                // SHOW 'GenericFilteredListView' BY PASSING IN THE CORRECT PARAMETER VALUES AS ITS FETCHREQUEST FILTER ARGUMENT
                GenericFilteredListView(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                    // TRAILING CLOSURE BODY TO TELL SWIFTUI WHAT 'Content' TO SHOW:
                    // TEXT VIEW FROM THE PASSED-IN 'singer' OBJECT THAT IS OF 'Singer' DATA MODEL
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                
                
                // HSTACK VIEW FOR SORTING BUTTONS
                HStack {
                    // BUTTON TO SHOW ONLY ARTIST W/ LAST NAME THAT STARTS W/ THE LETTER "A"
                    Button {
                        lastNameFilter = "A"
                    } label: {
                        Label("Show A", systemImage: "doc.text.magnifyingglass")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.blue
                                    .clipShape(Capsule())
                            }
                    }
                    
                    
                    // BUTTON TO SHOW ONLY ARTIST W/ LAST NAME THAT STARTS W/ THE LETTER "L
                    Button {
                        lastNameFilter = "L"
                    } label: {
                        Label("Show L", systemImage: "doc.text.magnifyingglass")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.blue
                                    .clipShape(Capsule())
                            }
                    }
                    
                    
                    // BUTTON TO SHOW ONLY ARTIST W/ LAST NAME THAT STARTS W/ THE LETTER "S"
                    Button {
                        lastNameFilter = "S"
                    } label: {
                        Label("Show S", systemImage: "doc.text.magnifyingglass")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.blue
                                    .clipShape(Capsule())
                            }
                    }
                    
                }
                
            }
            .navigationTitle("Singer List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // BUTTON TO ADD EXAMPLE 'Singer' DATA OBJECTS
                    Button {
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer1 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer1.firstName = "Dua"
                        singer1.lastName = "Lipa"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer2 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer2.firstName = "Ed"
                        singer2.lastName = "Sheeran"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer3 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer3.firstName = "Adele"
                        singer3.lastName = "Adkins"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer4 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer4.firstName = "Sam"
                        singer4.lastName = "Smith"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer5 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer5.firstName = "Taylor"
                        singer5.lastName = "Swift"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer6 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer6.firstName = "Frank"
                        singer6.lastName = "Sinatra"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer7 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer7.firstName = "Jennifer"
                        singer7.lastName = "Lopez"
                        
                        // CREATE A NEW 'Singer' OBJECT IN 'managedObjectContext' "LIVE" DATA
                        let singer8 = Singer(context: moc)
                        // ASSGIN VALUES TO ITS ATTRIBUTES
                        singer8.firstName = "Christina"
                        singer8.lastName = "Aguilera"
                        
                        // TRY TO SAVE THE "LIVE" DATA FROM 'managedObjectContext' INTO PERSISTENT STORAGE
                        try? moc.save()
                        
                    } label: {
                        Label("Add Singers", systemImage: "person.crop.circle.badge.plus")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}
*/

 
 
// "ONE-TO-MANY" DATA RELATIONSHIP IN COREDATA
//
struct ContentView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    // FETCHREQUEST PROPERTY FOR 'Country' DATA MODEL OBJECT (LINKED TO 'Candy' DATA MODEL OBJECT)
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
        NavigationView {
            VStack {
                // LIST VIEW OF COUNTRY NAMES & ITS ASSOCIATED CANDY NAMES
                // DYNAMICALLY GENERATED USING 'countries' DATA OBJECT
                List(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedCandyName)
                        }
                    }
                }
                    
            }
            .navigationTitle("Candy List")
            .navigationBarTitleDisplayMode(.inline)
            // ADD TOOLBAR ITEM
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    // BUTTON TO ADD EXAMPLE DATAS
                    Button {
                        // CREATE A NEW 'Candy' OBJECT DATA IN 'managedObjectContext' "LIVE" DATA
                        let candy1 = Candy(context: moc)
                        
                        // ASSIGN VALUES TO ATTRIBUTES
                        candy1.name = "Mars"
                        // CREATE A NEW 'Country' OBJECT DATA IN 'managedObjectContext' as 'origin' ATTRIBUTE'S VALUE
                        candy1.origin = Country(context: moc)
                        candy1.origin?.shortName = "UK"
                        candy1.origin?.fullName = "United Kingdom"
                        // THE ABOVE 'shortName' ATTRIBUTE VALUE IS NOT UNIQUE ALTHOUGH WE SPECIFIED A CONSTRAINT
                        // THAT'S WHERE THE 'DataController'S INITIALIZER "MERGE POLICY" COMES INTO PLAY
                        // REF 'DataController.swift'S CUSTOM INITIALIZER BODY CODE
                        
                        
                        // CREATE A NEW 'Candy' OBJECT DATA IN 'managedObjectContext' "LIVE" DATA
                        let candy2 = Candy(context: moc)
                        
                        // ASSIGN VALUES TO ATTRIBUTES
                        candy2.name = "KitKat"
                        // CREATE A NEW 'Country' OBJECT DATA IN 'managedObjectContext' as 'origin' ATTRIBUTE'S VALUE
                        candy2.origin = Country(context: moc)
                        candy2.origin?.shortName = "UK"
                        candy2.origin?.fullName = "United Kingdom"
                        // THE ABOVE 'shortName' ATTRIBUTE VALUE IS NOT UNIQUE ALTHOUGH WE SPECIFIED A CONSTRAINT
                        // THAT'S WHERE THE 'DataController'S INITIALIZER "MERGE POLICY" COMES INTO PLAY
                        // REF 'DataController.swift'S CUSTOM INITIALIZER BODY CODE
                        
                        
                        // CREATE A NEW 'Candy' OBJECT DATA IN 'managedObjectContext' "LIVE" DATA
                        let candy3 = Candy(context: moc)
                        
                        // ASSIGN VALUES TO ATTRIBUTES
                        candy3.name = "Twix"
                        // CREATE A NEW 'Country' OBJECT DATA IN 'managedObjectContext' as 'origin' ATTRIBUTE'S VALUE
                        candy3.origin = Country(context: moc)
                        candy3.origin?.shortName = "UK"
                        candy3.origin?.fullName = "United Kingdom"
                        // THE ABOVE 'shortName' ATTRIBUTE VALUE IS NOT UNIQUE ALTHOUGH WE SPECIFIED A CONSTRAINT
                        // THAT'S WHERE THE 'DataController'S INITIALIZER "MERGE POLICY" COMES INTO PLAY
                        // REF 'DataController.swift'S CUSTOM INITIALIZER BODY CODE
                        
                        
                        // CREATE A NEW 'Candy' OBJECT DATA IN 'managedObjectContext' "LIVE" DATA
                        let candy4 = Candy(context: moc)
                        
                        // ASSIGN VALUES TO ATTRIBUTES
                        candy4.name = "Toblerone"
                        // CREATE A NEW 'Country' OBJECT DATA IN 'managedObjectContext' as 'origin' ATTRIBUTE'S VALUE
                        candy4.origin = Country(context: moc)
                        candy4.origin?.shortName = "CH"
                        candy4.origin?.fullName = "Switzerland"
                        
                        
                        // TRY TO SAVE THE "LIVE" DATA FROM 'managedObjectContext' INTO PERSISTENT STORAGE
                        try? moc.save()
                        
                        
                    } label: {
                        Label("Add Candies", systemImage: "rectangle.stack.badge.plus")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.orange
                                    .clipShape(Capsule())
                            }
                    }
                }
            }
        }
        
        
    }
}
//
//



// PREVIEW CANVAS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
