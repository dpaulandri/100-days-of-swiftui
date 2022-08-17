//
//  UserDetailsView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//
// USER DETAILS VIEW

import SwiftUI

struct UserDetailsView: View {
    // USER PROPERTY
    let user: CachedUser
    
    
    var body: some View {
        VStack {
            // GEOMETRYREADER VIEW TO POPULATE THE USER DETAIL VIEW
            GeometryReader { geo in
                ScrollView {
                    // VSTACK VIEW FOR USER IMAGE, NAME, COMPANY & ONLINE STATUS
                    VStack(spacing: 3) {
                        // PLACEHOLDER USER IMAGE
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(user.isActive ? .blue : .gray)
                            .opacity(user.isActive ? 1 : 0.3)
                            .frame(maxWidth: geo.size.width * 0.45)
                        
                        Spacer()
                        
                        Group {
                            Text(user.wrappedName)
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            // HSTACK FOR ONLINE/OFFLINE STATUS INDICATOR
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(user.isActive ? .green : .red)
                                    .font(.subheadline)
                                Text(user.isActive ? "Online" : "Offline")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .frame(maxHeight: geo.size.height * 0.5)
                    .padding(.top)
                    .navigationTitle(user.firstName)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    Spacer()
                    Spacer()
                    
                    
                    // VSTACK FOR USER DETAILS
                    VStack(spacing: 5) {
                        // AGE
                        HStack {
                            Text("Age")
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(user.age)")
                        }
                        
                        // COMPANY
                        HStack {
                            Text("Company")
                                .fontWeight(.bold)
                            Spacer()
                            Text(user.wrappedCompany)
                        }
                        
                        // EMAIL
                        HStack {
                            Text("Email")
                                .fontWeight(.bold)
                            Spacer()
                            Text(user.wrappedEmail)
                        }
                        
                        // ADDRESS
                        HStack(alignment: .firstTextBaseline) {
                            Text("Address")
                                .fontWeight(.bold)
                            Spacer()
                            Text(user.wrappedAddress)
                                .lineLimit(3)
                                .truncationMode(.tail)
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: geo.size.width * 0.45, alignment: .trailing)
                        }
                        
                        // ACCOUNT CREATION DATE
                        HStack(alignment: .firstTextBaseline) {
                            Text("Created on")
                                .fontWeight(.bold)
                            Spacer()
                            Text(user.registeredDate)
                                .lineLimit(3)
                                .truncationMode(.tail)
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: geo.size.width * 0.45, alignment: .trailing)
                        }
                        
                    }
                    .padding()
                    
                    Spacer()
                    Spacer()
                    
                    // USER FRIEND LIST SECTION VIEW
                    Section {
                        if user.friendsArray.isEmpty {
                            VStack(spacing: 20) {
                                Text("-")
                            }
                            .padding()
                            
                        } else {
                            // HORIZONTAL USER'S FRIEND LIST SCROLL VIEW
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 30) {
                                    ForEach(user.friendsArray) { friend in
                                        VStack(spacing: 5) {
                                            Image(systemName: "person.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(user.isActive ? .blue : .gray)
                                                .frame(height: geo.size.height * 0.1)
                                            
                                            Text(friend.firstName)
                                                .font(.subheadline)
                                                .truncationMode(.tail)
                                        }
                                        .frame(height: geo.size.height * 0.2)
                                    }
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                    } header: {
                        Text("\(user.firstName)'s Friends")
                            .fontWeight(.bold)
                    }
                    
                }
            }
            .padding(.bottom)
            
            Spacer()
            
            // BUTTON VIEW
            ButtonView(user: user)
                .frame(maxHeight: 44)
                .padding(.bottom)
        }
    }
    
    // CUSTOM INITIALIZER FOR 'UserDetailsView' STRUCT
    init(user: CachedUser) {
        // ASSIGN PASSED-IN 'user' PARAM VALUE AS STRUCT'S 'user' PROPERTY VALUE
        self.user = user
    }
    
}



// PREVIEW
struct UserDetailsView_Previews: PreviewProvider {
    // PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
    static let user = CachedUser()
    
    static var previews: some View {
        UserDetailsView(user: user)
    }
}
