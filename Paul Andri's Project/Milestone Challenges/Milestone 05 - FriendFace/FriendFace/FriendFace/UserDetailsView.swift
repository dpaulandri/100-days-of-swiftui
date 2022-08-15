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
    let user: User
    
    
    var body: some View {
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
                        Text(user.company)
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
                .navigationTitle(user.name)
                .navigationBarTitleDisplayMode(.inline)
                
                Spacer()
                Spacer()
                
                // VSTACK FOR USER DETAILS
                VStack(spacing: 10) {
                    // AGE
                    HStack {
                        Text("Age")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(user.age)")
                    }
                    
                    // EMAIL
                    HStack {
                        Text("Email")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.email)
                    }
                    
                    // ADDRESS
                    HStack(alignment: .firstTextBaseline) {
                        Text("Address")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.address)
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
                .padding(30)
                
                
                // 'FriendScrollView'
                
            }
        }
        
        // BUTTON VIEW
        ButtonView()
    }
    
    
    // CUSTOM INITIALIZER FOR 'MissionView' STRUCT
    init(user: User) {
        // ASSIGN PASSED-IN 'user' PARAM VALUE AS STRUCT'S 'user' PROPERTY VALUE
        self.user = user
    }
    
}



// PREVIEW
struct UserDetailsView_Previews: PreviewProvider {
    // PASS ON DUMMY DATAS IN ORDER FOR PREVIEW TO WORK
    static let user = User(id: "", isActive: true, name: "", age: 0, company: "", email: "", address: "", about: "", registered: Date.now, tags: [], friends: [Friend]())
    
    static var previews: some View {
        UserDetailsView(user: user)
    }
}
