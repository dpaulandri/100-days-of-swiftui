//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/14/2022.
//
// CONTAINS CODE FOR DAY 59 - CHALLENGE #1, #2, AND #3

import CoreData
import SwiftUI

 
// DYNAMIC '@FetchRequest' FILTERING W/ SWIFTUI
struct ContentView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    // STATE PROPERTY TO STORE LAST NAME FILTER STRING VALUE
    // SHOW ONLY THE SINGER W/ LAST NAME THAT STARTS W/ THE LETTER "A"
    @State private var lastNameFilter = "A"
    
    // PART OF DAY 59 - CHALLENGE #2:
    // MODIFY 'NSPredicate' STRING PARAMETER TO BE ENUM CASES
    // PREDICATE TYPE ENUMS
    enum Predicates {
        case beginsWith, containsCS, containsNCS
    }
    
    // PART OF DAY 59 - CHALLENGE #2:
    // STATE PROPERTY THAT STORE THE PREDICATE TYPE FROM 'Predicates' ENUM
    @State private var predicateType = Predicates.containsNCS
    
    // PART OF DAY 59 - CHALLENGE #2:
    // COMPUTED PROPERTY TO DETERMINE PREDICATE STRING ARGUMENT BASED ON 'predicateType' STATE PROPERTY VALUE
    var predicateString: String {
        switch predicateType {
        case .containsCS:
            return "CONTAINS"
        case .containsNCS:
            return "CONTAINS[c]"
        default:
            return "BEGINSWITH"
        }
    }
    
    
    // PART OF DAY 59 - CHALLENGE #3:
    // PROPERTY TO STORE A 'SortDescriptor' OBJECT ARRAY OF 'Singer' ENTITY TYPE
    // TO BE USED W/ 'FilteredChallengeView' FETCHREQUEST'S CUSTOM INITIALIZER 'sortDescriptor' PARAMATER VALUE
    // STORES AN EMPTY 'SortDescriptor' TYPE ARRAY
    var descriptorArray = [SortDescriptor<Singer>]()
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
        NavigationView {
            VStack {
                    
                // PART OF DAY 59 - CHALLENGE #1: ACCEPT 'String' PARAMETER TO CONTROL WHICH 'NSPredicate' TO APPLY
                /*
                // SHOW 'FilteredChallenge1View' BY PASSING IN THE CORRECT PARAMETER VALUES AS ITS FETCHREQUEST FILTER ARGUMENT
                // SINGER'S 'lastName' ATTRIBUTE THAT "CONTAINS" 'lastNameFilter' String Value (NOT CASE-SENSITIVE)
                FilteredChallengeView(filterKey: "lastName", filterValue: lastNameFilter, predicate: "CONTAINS[c]") { (singer: Singer) in
                    // TRAILING CLOSURE BODY TO TELL SWIFTUI WHAT 'Content' TO SHOW:
                    // TEXT VIEW FROM THE PASSED-IN 'singer' OBJECT THAT IS OF 'Singer' DATA MODEL
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                */
                
                
                // PART OF DAY 59 - CHALLENGE #2:
                // MAKE 'Predicates' ENUM CASES GET RESOLVED TO A 'String' INSIDE THE 'FilteredChallenge1View' CUSTOM INITIALIZER
                /*
                // SHOW 'FilteredChallengeView' BY PASSING IN THE CORRECT PARAMETER VALUES AS ITS FETCHREQUEST FILTER ARGUMENT
                // SINGER'S 'lastName' ATTRIBUTE FILTERED DEPENDING ON 'predicateType' ENUM CASES THAT AFFECTS THE 'predicateString' STRING VALUE
                FilteredChallengeView(filterKey: "lastName", filterValue: lastNameFilter, predicate: predicateString) { (singer: Singer) in
                    // TRAILING CLOSURE BODY TO TELL SWIFTUI WHAT 'Content' TO SHOW:
                    // TEXT VIEW FROM THE PASSED-IN 'singer' OBJECT THAT IS OF 'Singer' DATA MODEL
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                */
                
                
                // PART OF DAY 59 - CHALLENGE #3:
                // ACCEPT A "GENERIC" ARRAY OF 'SortDescriptor' OBJECT FOR 'sortDescriptor' PARAMATER VALUE
                // SHOW 'FilteredChallengeView' BY PASSING IN THE CORRECT PARAMETER VALUES AS ITS FETCHREQUEST FILTER ARGUMENT
                // SINGER'S 'lastName' ATTRIBUTE FILTERED DEPENDING ON 'predicateType' ENUM CASES THAT AFFECTS THE 'predicateString' STRING VALUE
                FilteredChallengeView(filterKey: "lastName", filterValue: lastNameFilter, predicate: predicateString, descriptor: descriptorArray) { (singer: Singer) in
                    // TRAILING CLOSURE BODY TO TELL SWIFTUI WHAT 'Content' TO SHOW:
                    // TEXT VIEW FROM THE PASSED-IN 'singer' OBJECT THAT IS OF 'Singer' DATA MODEL
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
                                
                
                // HSTACK VIEW FOR SORTING BUTTONS
                HStack {
                    // BUTTON TO SHOW ONLY ARTIST W/ LAST NAME THAT CONTAINS/BEGINS W/ THE LETTER "A"
                    Button {
                        lastNameFilter = "A"
                    } label: {
                        Label("A Sort", systemImage: "doc.text.magnifyingglass")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.blue
                                    .clipShape(Capsule())
                            }
                    }
                    
                    
                    // BUTTON TO SHOW ONLY ARTIST W/ LAST NAME THAT CONTAINS/BEGINS W/ THE LETTER "L
                    Button {
                        lastNameFilter = "L"
                    } label: {
                        Label("L Sort", systemImage: "doc.text.magnifyingglass")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                Color.blue
                                    .clipShape(Capsule())
                            }
                    }
                    
                    
                    // BUTTON TO SHOW ONLY ARTIST W/ LAST NAME THAT CONTAINS/BEGINS W/ THE LETTER "S"
                    Button {
                        lastNameFilter = "S"
                    } label: {
                        Label("S Sort", systemImage: "doc.text.magnifyingglass")
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



// PREVIEW CANVAS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
