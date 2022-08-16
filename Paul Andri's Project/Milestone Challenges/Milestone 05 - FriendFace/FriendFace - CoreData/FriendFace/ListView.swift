//
//  ListView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//
// 'Friend' LIST VIEW

import SwiftUI

struct ListView: View {
    // ACCESS SWIFTUI ENVIRONMENT'S COREDATA 'managedObjectContext'
    @Environment(\.managedObjectContext) var moc
    
    // STATE PROPERTY TO STORE THE BOOL STATE OF USER LIST SORTING ORDER
    @State private var ascendingSort = true
    
    // STATE PROPERTY TO STORE THE BOOL STATE OF NETWORK ERROR ALERT WINDOW
    @State private var showNetworkAlert = false
    
    
    // MAIN BDOY VIEW PROPERTY
    var body: some View {
        // SHOW 'SortedListView'
        // USER NAME SORTING DEPENDS ON 'ascendingSort' BOOL VALUE
        SortedListView(descriptor: [NSSortDescriptor(keyPath: \CachedUser.name, ascending: ascendingSort)]) { (user: CachedUser) in
            // NAVIGATION LINK TO THE CORRESPONDING 'UserDetailsView'
            NavigationLink {
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
                            Text(user.wrappedName)
                                .font(.headline)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Text(user.wrappedCompany)
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
        // NAVIGATION TOOLBAR ITEMS
        .toolbar {
            // NAME SORTING TOOLBAR ITEM
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    withAnimation {
                        ascendingSort.toggle()
                    }
                        
                } label: {
                    Label("Name List Sorting", systemImage: "arrow.up.arrow.down")
                        .labelsHidden()
                }
            }
            
            // DATABASE REFRESH TOOLBAR ITAM
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await loadUserData()
                    }
                } label: {
                    Label("Refresh User Database", systemImage: "arrow.clockwise")
                }
            }
        }
        
        
        // TASK MODIFIER TO CALL 'loadUserData' METHOD IF 'users' STATE PROPERTY ARRAY IS EMPTY
        .task {
            // Call 'loadUserData()' Method
            // 'await' - Explicitly acknowledging that a sleep might happen
            await loadUserData()
        }
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
            
            // ATTEMPT TO UPDATE PERSISTANT STORAGE CACHE USING 'updateCache' METHOD
            // QUEUE THE CACHE UPDATE USING 'MainActor'
            await MainActor.run {
                updateCache(with: decodedUserData)
            }
            
        } catch {
            // CATCH ERROR
            print("Invalid Data URL!")
        }
    }
    
    // METHOD TO UPDATE USER DATABASE CACHE W/ THE DOWNLOADED DATA FROM 'loadUserData' METHOD
    func updateCache(with updateData: [User]) {
        // DO BLOCK TO ATTEMPT UPDATING DATABASE IN PRESISTENT STORAGE
        do {
            // FOR LOOP ITERATING ALL ITEM in 'updateData'
            for user in updateData {
                // CREATE 'CachedUser' OBJECT IN MOC
                let cachedUser = CachedUser(context: moc)
                
                // ASSGIN CORRESPONDING PROPERTY VALUES
                cachedUser.id = user.id
                cachedUser.isActive = user.isActive
                cachedUser.name = user.name
                cachedUser.age = Int16(user.age)
                cachedUser.company = user.company
                cachedUser.email = user.email
                cachedUser.address = user.address
                cachedUser.about = user.about
                cachedUser.registered = user.registered
                cachedUser.tags = user.tags.joined(separator: ",")
                
                // FOR LOOP ITERATING ALL ITEM in 'user.friends'
                for friend in user.friends {
                    // CREATE 'CachedFriend' OBJECT IN MOC
                    let cachedFriend = CachedFriend(context: moc)
                    
                    // ASSGIN CORRESPONDING PROPERTY VALUES
                    cachedFriend.id = friend.id
                    cachedFriend.name = friend.name
                    cachedUser.addToFriends(cachedFriend)
                }
            }
            
            // TRY
            // TRY TO SAVE UPDATE OBJECTS IN MOC TO PERSISTANT STORAGE
            try? moc.save()

        } catch {
            print("Failed to update Local User Database!")
        }
    }

}



// PREVIEW
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
