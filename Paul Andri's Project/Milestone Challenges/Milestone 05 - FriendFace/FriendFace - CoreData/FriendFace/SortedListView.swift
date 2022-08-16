//
//  SortedListView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/16/2022.
//
// REUSABLE FILTERED LIST VIEW W/ CUSTOM FETCHREQUEST INITIALIZER W/ GENERIC SORTING
// THIS VIEW CAN HANDLE THE CUSTOM FETCHREQUEST FOR ANY KIND OF 'NSManagedObject' DATA
// INJECTION OF 'managedObjectContext' IS NOT NEEDED IN THIS VIEW BECAUSE THIS VIEW WILL BE SHOWN INSIDE 'ContentView', WHICH ALREADY HAS 'managedObjectContext' INJECTED INTO ITS VIEW ENVIRONMENT

// IMPORT COREDATA FRAMEWORK
import CoreData
import SwiftUI

// STRUCT IS SOME KIND OF "GENERIC" 'NSManagedObject' & ITS "CONTENT" IS SOMEKIND OF SWIFTUI 'View'
struct SortedListView<T: NSManagedObject, Content: View>: View {
    // FETCHREQUEST PROPERTY FOR "GENERIC" DATA MODEL
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    // CONTENT CLOSURE PROPERTY THAT ACCEPT A "GENERIC" DATA & RETURNS SOME KIND OF "CONTENT"
    let content: (T) -> Content
    
    var body: some View {
        // DYNAMICALLY GENERATED FILTERED LIST VIEW FROM 'fetchRequest' "GENERIC" OBJECT DATAS
        List(fetchRequest, id: \.self) { item in
            // CALL 'content' CLOSURE W/ THE PASSED-IN "GENERIC" 'item' DATA
            // WILL RETURN SOME KIND OF 'Content'
            self.content(item)
        }
    }
    
    // CUSTOM INITIALIZER FOR 'fetchRequest'' PROPERTY
    // ACCEPT AN ARRAY OF 'NSSortDescriptor' OBJECT FOR 'sortDescriptor' PARAMATER VALUE,
    // AN "ESCAPING" CONTENT CLOSURE "VIEWBUILDER" THAT ACCEPT A "GENERIC" OBJECT & RETURNS A 'Content'
    // '@ViewBuilder' - LET THE CONTAINING 'View' SEND IN MULTIPLE 'View's IF NEEDED
    // '@escaping' - MARK THE CLOSURE WILL BE STORE AWAY & BE USED LATER
    init(descriptor: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        // '_fetchRequest' PASSES A NEW 'FetchRequest' FILTERED OBJECT DIRECTLY FOR 'fetchRequest' TO USE
        _fetchRequest = FetchRequest<T>(sortDescriptors: descriptor)

        // ASSIGN 'content' CLOSURE PROPERTY AS THE 'content' PARAMETER VALUE
        self.content = content
    }
}


// DISABLE PREVIEW
/*
struct FilteredListView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredListView()
    }
}
*/
