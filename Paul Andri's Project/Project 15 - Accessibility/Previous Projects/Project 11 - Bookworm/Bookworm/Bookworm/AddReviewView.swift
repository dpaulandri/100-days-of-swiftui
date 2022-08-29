//
//  AddReviewView.swift
//  Bookworm
//
//  Created by Paul Andri on 08/11/2022.
//
// VIEW TO SHOW ON 'sheet' VIEW WHEN THE USER TAP '+' ADD REVIEW BUTTON ON MAIN 'ContentView'

import SwiftUI

struct AddReviewView: View {
    // GET ACCESS TO 'managedObjectContext' IN SWIFTUI'S ENVIRONMENT
    // ENVIRONMENT PROPERTY TO STORE 'managedObjectContext' "LIVE" DATA IN SWIFTUI'S ENVIRONMENT
    @Environment(\.managedObjectContext) var moc
    
    // ENVIRONMENT PROPERTY TO DISMISS 'AddReviewView' AFTER THE USER PRESSED THE 'Save' BUTTON
    @Environment(\.dismiss) var dismiss
    
    // STATE PROPERTIES TO STORE USER INPUT BOOK REVIEW DATAS
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = ""
    @State private var review = ""
    // PART OF CODE FOR DAY 56 - CHALLENGE #3
    @State private var date = Date.now
    
    // ARRAY CONTAINING AVAILABLE GENRE OPTIONS FOR 'genre' STATE PROPERTY
    let genres = [
        "Action-Adventure",
        "Biographies",
        "Classics",
        "Cookbooks",
        "Mystery",
        "Fantasy",
        "Fiction",
        "Graphic Novel",
        "History",
        "Horror",
        "Kids",
        "Poetry",
        "Romance",
        "Sci-Fi",
        "Self-Help",
        "Thriller",
        "Others"
    ]
    

    // VIEW BODY PROPERTY
    var body: some View {
        NavigationView {
            Form {
                // BOOK DETAILS SECTION
                Section {
                    TextField("Book Title", text: $title)
                        // AUTO-CAPITALIZE EVERY WORDS
                        .textInputAutocapitalization(.words)
                    
                    TextField("Author's Name", text: $author)
                        // AUTO-CAPITALIZE EVERY WORDS
                        .textInputAutocapitalization(.words)
                        // DISABLE AUTO-CORRECT
                        .disableAutocorrection(true)
                    
                    // PICKER INPUT FOR BOOK GENRE
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Book Details")
                }
                
                // USER REVIEW SECTION
                Section {
                    TextEditor(text: $review)
                        // AUTO-CAPITALIZE EVERY SENTENCES
                        .textInputAutocapitalization(.sentences)
                    
                    // HSTACK FOR CUSTOM 'RatingScoreView' VIEW
                    HStack {
                        Spacer()
                        
                        // CUSTOM RATING SCORE VIEW BOUNDED TO THE 'rating' STATE PROPERTY
                        StarRatingView(rating: $rating)
                        
                        Spacer()
                    }
                    
                } header: {
                    Text("Write a Review")
                }
                
            }
            .navigationTitle("Add Review")
            
            // ADD TOOLBAR TO FORM VIEW
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    // BUTTON TO SAVE USER INPUT BOOK REVIEW DATAS
                    Button {
                        // CREATE A NEW 'Book' DATA MODEL INSTANCE TO STORE NEW BOOK REVIEW DATA
                        // ASSIGN SWIFTUI ENVIRONMENT'S MOC "LIVE" DATA AS THE CONTEXT FOR THE DATA MODEL
                        let newReview = Book(context: moc)
                        
                        // ASSIGN DATA VALUES TO 'newReview' FROM THE CROSSEPONDING STATE PROPERTIES
                        // ASSIGN UUID TO 'newReview's 'id'
                        newReview.id = UUID()
                        newReview.title = title
                        newReview.author = author
                        // CONVERT STATE PROPERTY 'rating' FROM 'Int' to 'Int16' DATA TYPE
                        newReview.rating = Int16(rating)
                        newReview.genre = genre
                        newReview.review = review
                        // PART OF CODE FOR DAY 56 - CHALLENGE #3
                        newReview.date = date
                        
                        // TRY TO SAVE THE "LIVE" DATA STORED FROM SWIFTUI ENVIRONMENT'S MOC INTO COREDATA'S PERSISTENT STORAGE
                        try? moc.save()
                        
                        // CALL ENVIRONMENT 'dismiss' PROPERTY
                        dismiss()
                        
                    } label: {
                        Label("Save", systemImage: "books.vertical")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(.white)
                            .padding(10)
                            .background {
                                Capsule()
                                    .fill(.green)
                                    .frame(minWidth: 200)
                            }
                    }
                    // PART OF CODE FOR DAY 56 - CHALLENGE #1
                    // DISABLE "SAVE" BUTTON IF THE COMPUTED VALUE OF 'reviewDetailComplete' IS 'false'
                    .disabled(reviewDetailComplete == false)
                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    // BUTTON TO DISMISS 'AddReviewView'
                    Button {
                        // CALL ENVIRONMENT 'dismiss' PROPERTY
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.down.forward.and.arrow.up.backward")
                    }
                }
            }
        }
    }
    
    
    // PART OF CODE FOR DAY 56 - CHALLENGE #1
    // A COMPUTED TO DISABLE "SAVE" BUTTON, COMPUTED VALUE IS A 'Bool' TYPE
    var reviewDetailComplete: Bool {
        // CHECK IF ANY OF THE BOOK REVIEW DETAIL PROPERTY IS EMPTY / 0
        if title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty || rating == 0 {
            // IF ANY OF THE BOOK REVIEW DETAIL PROPERTY IS EMPTY:
            // reviewDetailComplete = false
            return false
        }

        // CHECK IF ANY THE LISTED STRING-TYPE PROPERTY CONTAINS ONLY A WHITESPACE " "
        if title == " " || author == " " || genre == " " || review == " " {
            // IF ANY THE LISTED STRING-TYPE PROPERTY CONTAINS ONLY A WHITESPACE " "
            // reviewDetailComplete = false
            return false
        }
        
        // IF ALL BOOK REVIEW DETAIL PROPERTIES IS NOT EMPTY / 0 / CONTAINS ONLY A WHITESPACE " ":
        // reviewDetailComplete = true
        return true
    }
    
}



struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView()
    }
}
