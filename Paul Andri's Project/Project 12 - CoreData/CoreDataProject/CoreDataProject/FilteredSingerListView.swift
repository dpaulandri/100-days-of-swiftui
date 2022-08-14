//
//  FilteredSingerListView.swift
//  CoreDataProject
//
//  Created by Paul Andri on 08/14/2022.
//
// PART OF DAY 58: DYNAMIC '@FetchRequest' FILTERING W/ SWIFTUI
// FILTERED "SINGER" LIST VIEW W/ CUSTOM FETCHREQUEST INITIALIZER FOR STATIC SORTING
// THIS VIEW WILL HANDLE THE CUSTOM FETCHREQUEST FOR 'Singer' OBJECT DATA FROM COREDATA
// INJECTION OF 'managedObjectContext' IS NOT NEEDED IN THIS VIEW BECAUSE THIS VIEW WILL BE SHOWN INSIDE 'ContentView', WHICH ALREADY HAS 'managedObjectContext' INJECTED INTO ITS VIEW ENVIRONMENT

import SwiftUI

struct FilteredSingerListView: View {
    // FETCHREQUEST PROPERTY FOR 'Singer' DATA MODEL
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    var body: some View {
        // DYNAMICALLY GENERATED FILTERED LIST VIEW FROM 'fetchRequest' 'Singer' OBJECT DATAS
        List(fetchRequest, id: \.self) { singer in
            // SHOW TEXT VIEW OF SINGER'S FIRST & LAST NAME
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    // CUSTOM INITIALIZER FOR 'fetchRequest'' PROPERTY
    // ACCEPT 'String' VALUE AS 'NSPredicate' FILTER ARGUMENT
    init(filter: String) {
        // STATIC 'NSPredicate' SORTING:
        // '_fetchRequest' PASSES A NEW 'FetchRequest' FILTERED OBJECT DIRECTLY FOR 'fetchRequest' TO USE
        // SORT THE FETCHREQUEST DATA USING THE PASSED-IN INITIALIZER 'filter' VALUE W/ 'NSPredicate'
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
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
