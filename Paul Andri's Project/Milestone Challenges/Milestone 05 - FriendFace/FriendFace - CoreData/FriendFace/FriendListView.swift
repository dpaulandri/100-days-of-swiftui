//
//  FriendListView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/18/2022.
//
// USER'S FRIEND LIST HORIZONTAL SCROLLING VIEW
// SHOWN WITHIN THE 'UsersDetailView'

import SwiftUI

struct FriendListView: View {
    // USER PROPERTY
    let user: CachedUser
    
    // FETCHREQUEST PROPERTY FOR 'CacheUser' OBJECT DATA
    // USED W/ 'getFriendUserObject' TO GET USER FRIEND'S 'CachedUser' OBJECT DATA
    @FetchRequest(sortDescriptors: []) var userDatabase: FetchedResults<CachedUser>
    
    
    var body: some View {
        if user.friendsArray.isEmpty {
            VStack(spacing: 20) {
                Text("-")
            }
            .padding()
            
        } else {
            HStack(spacing: 30) {
                ForEach(user.friendsArray) { friend in
                    // GET FRIEND'S 'CachedUser' OBJECT DATA FROM
                    let userFriend = getFriendUserObject(id: friend.idUUID)
                    // NAVIGATION LINK TO NAVIGATE TO THE CORRESPONDING 'UserDetailsView'
                    NavigationLink {
                        UserDetailsView(user: userFriend)
                    } label: {
                        VStack(spacing: 5) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(userFriend.isActive ? .blue : .gray)
                                .opacity(userFriend.isActive ? 1 : 0.3)
                                .overlay(alignment: .topTrailing) {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundColor(userFriend.isActive ? .green : .red)
                                        .frame(width: 10, height: 10)
                                        .clipShape(Circle())
                                }
                                .frame(minHeight: 60)
                            
                            Text(userFriend.firstName)
                                .font(.subheadline)
                                .truncationMode(.tail)
                                .foregroundColor(userFriend.isActive ? .primary : .secondary)
                        }
                    }
                }
            }
        }
    }
    
    
    // METHOD TO GET USER FRIEND'S 'CacheUser' OBJECT DATA
    func getFriendUserObject(id: UUID) -> CachedUser {
        // TRY TO FIND 'user' OBJECT DATA IN 'userDatabase'
        guard let user = userDatabase.first(where: { user in
            // WHERE THE PASSED IN 'user' OBJECT HAS THE MATCHING 'id' UUID VALUE
            user.id == id
        }) else {
            print("Did not found \(user.firstName) in the User Database!")
            // RETURN EMPTY 'CachedUser' OBJECT
            return CachedUser()
        }
        // RETURN 'user' 'CacheUser' OBJECT DATA TO FUNCTION
        return user
    }
}



// PREVIEW
struct FriendListView_Previews: PreviewProvider {
    // PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
    static let user = CachedUser()
    
    static var previews: some View {
        FriendListView(user: user)
    }
}
