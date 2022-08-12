//
//  ContentView.swift
//  Bookworm
//
//  Created by Paul Andri on 08/11/2022.
//

import SwiftUI

struct ContentView: View {
    // GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
    // ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
    @Environment(\.managedObjectContext) var moc
    
    
    // READ ANY EXISTING REVIEW DATA ENTRY INSIDE THE 'Book' DATA MODEL
    // FETCH REQUEST PROPERTY THAT HAVE A 'Book' DATA MODEL RESULT 'FetchedResults' DATA TYPE
    @FetchRequest(sortDescriptors:[
        // SORT THE 'FetchedResults' DATA USING ITS 'title' ATTRIBUTE
            SortDescriptor(\.title)
        // 'SortDescriptor(\.title, order: .reverse)' USE THIS TO REVERSE THE SORTING ORDER
    ]) var reviews: FetchedResults<Book>
    
    
    // STATE PROPERTY TO STORE WHETHER 'AddReviewView' IS SHOWN ON SHEET
    @State private var showAddReviewSheet = false
    
    
    var body: some View {
        NavigationView {
            // LIST VIEW TO SHOW SAVED BOOK REVIEWS & ITS CORRESPONDING DATAS
            List {
                // FOREACH VIEW USING 'books' FETCHREQUEST PROPERTY'S FETCHEDRESULTS DATA
                ForEach(reviews) { book in
                    // EACH 'book' LIST ENTRY NAVIGATES TO ITS CORRESPONDING SAVED REVIEW DATA VIEW
                    NavigationLink {
                        ReviewDetailsView(review: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            // VSTACK CONTAINING BOOK TITLE & AUTHOR
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            // ALLOW TEXT VIEWS TO BE TRUNCATED AT THE TAIL
                            .lineLimit(1)
                            .truncationMode(.tail)
                        }
                    }
                }
                // ATTACH 'onDelete' TO THE FOREACH VIEW
                // CALLS 'deleteReview' METHOD
                .onDelete(perform: deleteReview)
                
            }
            .navigationTitle("Bookworm")
            // TOOLBAR
            .toolbar {
                // QUICK EDIT/DELETE BUTTON
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                // BUTTON TO SHOW 'AddReviewView' ON SHEET
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // TOGGLE 'showAddReviewSheet' BOOL VALUE
                        showAddReviewSheet.toggle()
                    } label: {
                        Label("Add Review", systemImage: "plus")
                    }
                }
                
                /*
                ToolbarItem(placement: .navigationBarLeading) {
                    // BUTTON TO CHANGE BOOK TITLE SORTING ORDER
                    Button {
                        // TOGGLE 'reverseTitleSort' BOOL VALUE
                        reverseTitleSort.toggle()
                    } label: {
                        Label(!reverseTitleSort ? "Z-A" : "A-Z", systemImage: "arrow.up.arrow.down")
                    }
                }
                */
            }
            // ATTACH 'sheet' MODIFIER
            // BOUND TO 'showAddReviewSheet' BOOL VALUE
            .sheet(isPresented: $showAddReviewSheet) {
                // SHOW 'AddReviewView' ON SHEET
                AddReviewView()
            }
        }
    }
    
    
    // METHOD TO DELETE BOOK REVIEW DATA FROM COREDATA 'FetchRequest'
    func deleteReview(at offsets: IndexSet) {
        
        // STEP 1: FIND THE BOOK REVIEW INDEX & DELETE THE "LIVE" DATA FROM 'managedObjectContext' ON iDevice MEMORY
        // FOR LOOP TO LOOP OVER EVERY DATA INDEX FROM THE PASSED-IN 'offsets' COLLECTION
        for offset in offsets {
            
            // STEP 1A:
            // FIND THE BOOK REVIEW INDEX USING THE 'offset' INDEXSET ON 'reviews' 'FetchRequest' PROPERTY DATA
            // DEFINE IT AS THE 'review' OBJECT
            let review = reviews[offset]
            
            // STEP 1B:
            // DELETE THAT REVIEW ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
            moc.delete(review)
        }
        
        // STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
        //try? moc.save()
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
