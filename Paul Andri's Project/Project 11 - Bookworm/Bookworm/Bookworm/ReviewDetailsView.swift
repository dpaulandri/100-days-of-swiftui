//
//  ReviewDetailsView.swift
//  Bookworm
//
//  Created by Paul Andri on 08/12/2022.
//
// VIEW THAT SHOW ALL THE BOOK REVIEW DETAILS
// LINKED FROM THE 'ContentView'S LIST NAVIGATION LINK

import SwiftUI

struct ReviewDetailsView: View {
    // A PROPERTY W/ 'Book' MODEL DATA TYPE
    let review: Book
    
    // GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
    // ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
    @Environment(\.managedObjectContext) var moc
    
    // ENVIRONMENT PROPERTY TO DISMISS 'ReviewDetailsView'
    @Environment(\.dismiss) var dismiss
    
    // STATE PROPERTY SHOW BOOK REVIEW DELETE CONFIRMATION ALERT WINDOW
    @State private var showDeleteAlert = false
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
            // SCROLL VIEW - SHOW BOOK GENRE IMAGE, AUTHOR NAME & USER REVIEW TEXTS
            ScrollView {
                // ZSTACK - SHOW THE REVIEW'S BOOK GENRE IMAGE & TEXT
                ZStack(alignment: .bottomTrailing) {
                    // SHOW AN IMAGE VIEW THAT CORRESPONDS TO THE CORRECT BOOK 'genre' IN THE REVIEW
                    Image(review.genre ?? "Others")
                        .resizable()
                        .scaledToFill()
                    
                    // TEXT VIEW W/ UPPERCASED 'genre' STRING VALUE
                    Text(review.genre?.uppercased() ?? "Others")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                    // CREATE A 75% OPACITY TRANSLUCENT BLACK BACKGROUND OVERLAY
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                    // OFFSET THE TEXT-VIEW TO THE BOTTOM RIGHT EDGE
                        .offset(x: -5, y: -5)
                }
                .padding(.bottom)
                                
                // SHOW BOOK AUTHOR'S NAME
                Text(review.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                // SHOW USER WRITTEN REVIEW TEXTS
                Text(review.review ?? " No review.")
                    .padding()
                
            }
            .navigationTitle(review.title ?? "Unknown Book")
            .navigationBarTitleDisplayMode(.inline)
        
            // BOOK REVIEW DELETE CONFIRMATION ALERT
            .alert("Delete Review", isPresented: $showDeleteAlert) {
                // BUTTON TO CONFIRM BOOK REVIEW DELETION, CALL 'deleteReview' METHOD
                Button("Delete", role: .destructive, action: deleteReview)
                // BUTTON TO CANCEL BOOK REVIEW DELETION & DISMISS THE ALERT WINDOW
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Are you sure?")
            }
        
            // TOOLBAR
            .toolbar {
                // BUTTON TO START THE BOOK REVIEW DELETION PROCESS
                Button {
                    // ASSIGN 'true' TO 'showDeleteAlert' BOOL STATE
                    showDeleteAlert = true
                } label: {
                    Label("Delete this book review", systemImage: "trash")
                }
            }
        
            Spacer()
            
        
            // SHOW 'StarRatingView' W/ CONSTANT BINDING FROM THE BOOK REVIEW'S 'rating' VALUE
            // USING "CONSTANT BINDING" PREVENTS UNWANTED 'StarRatingView' INTERACTION
            StarRatingView(rating: .constant(Int(review.rating)))
                .font(.largeTitle)
                .padding(.bottom)
        
    }
    
    
    // METHOD TO DELETE BOOK REVIEW FROM COREDATA PERSISTENT STORAGE & DISMISS 'ReviewDetailsView' BACK TO ITS PREVIOUS VIEW
    func deleteReview() {
        // STEP 1: DELETE THE CURRENT BOOK REVIEW SHOWN ON OUR 'managedObjectContext' "LIVE" DATA ON iDevice MEMORY
        moc.delete(review)
        
        // STEP 2: TRY TO WRITE/SAVE THE DELETE CHANGES TO 'COREDATA' PERSISTENT STORAGE
        //try? moc.save()
        
        // STEP 3: CALL DISMISS TO DISMISS THE CURRENT 'ReviewDetailsView'
        dismiss()
    }
}


// DEACTIVATE THE PREVIEW FOR THIS VIEW
/*
struct ReviewDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewDetailsView()
    }
}
*/
