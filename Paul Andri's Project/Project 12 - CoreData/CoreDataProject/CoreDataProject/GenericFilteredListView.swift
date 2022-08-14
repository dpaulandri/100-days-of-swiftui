//
//  GenericFilteredListView.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/14/2022.
//
// PART OF DAY 58: DYNAMIC '@FetchRequest' FILTERING W/ SWIFTUI
// REUSABLE FILTERED LIST VIEW W/ CUSTOM FETCHREQUEST INITIALIZER W/ GENERIC SORTING
// THIS VIEW CAN HANDLE THE CUSTOM FETCHREQUEST FOR ANY KIND OF 'NSManagedObject' DATA
// INJECTION OF 'managedObjectContext' IS NOT NEEDED IN THIS VIEW BECAUSE THIS VIEW WILL BE SHOWN INSIDE 'ContentView', WHICH ALREADY HAS 'managedObjectContext' INJECTED INTO ITS VIEW ENVIRONMENT

// IMPORT COREDATA FRAMEWORK
import CoreData
import SwiftUI

// STRUCT IS SOME KIND OF "GENERIC" 'NSManagedObject' & ITS "CONTENT" IS SOMEKIND OF SWIFTUI 'View'
struct GenericFilteredListView<T: NSManagedObject, Content: View>: View {
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
    // ACCEPT TWO 'String' VALUES AS ITS 'NSPredicate' FILTER SYNTAX ARGUMENTS
    // AND AN "ESCAPING" CONTENT CLOSURE "VIEWBUILDER" THAT ACCEPT A "GENERIC" OBJECT & RETURNS A 'Content'
    // '@ViewBuilder' - LET THE CONTAINING 'View' SEND IN MULTIPLE 'View's IF NEEDED
    // '@escaping' - MARK THE CLOSURE WILL BE STORE AWAY & BE USED LATER
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        // "GENERIC" 'NSPredicate' SORTING:
        // '_fetchRequest' PASSES A NEW 'FetchRequest' FILTERED OBJECT DIRECTLY FOR 'fetchRequest' TO USE
        // SORT THE FETCHREQUEST DATA USING THE PASSED-IN INITIALIZER 'filter' VALUE AGAINST 'keyName' W/ 'NSPredicate'
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
         //SYNTAX EXPLANATION:
        /*
         - '%K' IS PLACEHOLDER SYNTAX FOR THE "KEY NAME" TO BE CHECK BY 'NSPredicate
         - '%@' IS PLACEHOLDER SYNTAX FOR THE VALUE TO BE CHECK AGAINST THE "KEY NAME"
        */
        
        // ASSIGN 'content' CLOSURE PROPERTY AS THE 'content' PARAMETER VALUE
        self.content = content
    }
}



// DISABLE PREVIEW
/*
struct FilteredSingerListView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredSingerListView()
    }
}
*/
