//
//  ListView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//
// 'Friend' LIST VIEW

import SwiftUI

struct ListView: View {
    // STATE PROPERTY TO STORE AN INTIAL EMPTY 'User' TYPE ARRAY
    @State private var userDatabase = [User]()
    
    // STATE PROPERTY TO STORE THE BOOL STATE  OF NETWORK ERROR ALERT WINDOW
    @State private var showNetworkAlert = false
    
    
    // MAIN BDOY VIEW PROPERTY
    var body: some View {
            // DYNAMICALLY GENERATED LIST USING 'users' 'USER' DATA TYPE ARRAY ITEMS
            List(userDatabase, id: \.id) { user in
                // NAVIGATION LINK TO CORRESPONDING 'UserDetailsView'
                NavigationLink {
                    // NAVIGATE TO 'UserDetailsView
                    UserDetailsView(user: user)
                } label: {
                    HStack {
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(user.isActive ? .blue : .gray)
                                .opacity(user.isActive ? 1 : 0.3)
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                
                                Text(user.company)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                }
            }
            // TASK MODIFIER TO CALL 'loadUserData' METHOD IF 'users' STATE PROPERTY ARRAY IS EMPTY
            .task {
                if userDatabase.count == 0 {
                    // Call 'loadUserData()' Method
                    // 'await' - Explicitly acknowledging that a sleep might happen
                    await loadUserData()
                    // IF SUCCESFUL, WILL ASSIGN DECODED DATA TO 'users' STATE PROPERTY
                }
            }
            
            //.navigationBarTitle("FriendFace")
            // NETWORK ERROR ALERT WINDOW
            .alert("Network Error", isPresented: $showNetworkAlert) {
                Button("Dismiss", role: .cancel) { }
                Button("Try Again") {
                    // CREATE 'Task' TO MAKE BUTTON VIEW SUPPORT CALLING ASYNC METHOD
                    Task {
                        // CALL 'loadUserData' ASYNC METHOD
                        await loadUserData()
                        // MARK 'await' TO INDICATE THE METHOD MAY SLEEP
                    }
                }
            } message: {
                // ALERT WINDOW MESSAGE
                Text("""
                Unable to update User List.
                Ensure network access is available.
                """)
            }
    }
    
    
    // METHOD TO FETCH 'User' DATA FROM REMOTE JSON DATA
    // 'async' - Asynchronous Function:
    // Leave code running in background w/o freezing the main App code
    func loadUserData() async {
        // STEP 1: CREATE THE 'URL' TO READ
        // URL STRING TO GET USER JSON DATA
        // IF SUCCESSFUL: URL value will be assign to the Property 'url'
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            // DO THIS IF THE URL STRING IS INVALID:
            print("Invalid User Database URL!")
            // EXIT
            return
        }
        
        // STEP 2: FETCH DATA FROM THE 'URL'
        // THIS STEP IS LIKELY WHERE A "SLEEP" MIGHT HAPPEN
        // 'do' & 'catch' BLOCK
        do {
            // 'data(from: url)' - Returns a 'Tuple' containing 'Data' object from 'url' & some metadata describing how the request went
            // '(data, _)' -  We create a new local Constant for the 'data', and toss the metadata away
            // 'await' - Explicitly acknowledging that a sleep might happen
            guard let (data, _) = try? await URLSession.shared.data(from: url) else {
                // IF UNABLE TO COMPLETE 'URLSession' DOWNLOAD FUNCTION:
                // SET 'showNetworkAlert' PROGRAM STATE TO TRIGGER ALERT WINDOW
                showNetworkAlert = true
                // EXIT THE DO BLOCK
                return
            }
            
            
            // IF DATA IS SUCCESFULLY FETCHED FROM 'url'
            // STEP 3: DECODE THE FETCHED JSON DATA INTO A 'User' ARRAY DATA TYPE STRUCT
            let decoder = JSONDecoder()
            // ADD DATE-DECODING STRATEGY FROM 'ISO-8601' DATE FORMAT TO SWIFT'S 'Date' FORMAT
            decoder.dateDecodingStrategy = .iso8601
            
            // TRY TO DECODE JSON DATA W/ 'FetchedUserData' DATA TYPE FROM 'data'
            guard let decodedUserData = try? decoder.decode([User].self, from: data) else {
                print("Can't decode JSON Data!")
                return
            }
            
            // ASSIGN 'decodedUserData' [User]' DATA TO 'userData' STATE PROPERTY
            userDatabase = decodedUserData
            
        } catch {
            // CATCH ERROR
            print("Invalid Data URL!")
        }
        
    }
}



// PREVIEW
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
