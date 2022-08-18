//
//  ButtonView.swift
//  FriendFace
//
//  Created by Paul Andri on 08/15/2022.
//
// CALL & MESSAGE BUTTON VIEW
// SHOWN AT THE BUTTOM OF 'UserDetails' VIEW

import SwiftUI

struct ButtonView: View {
    // USER PROPERTY
    let user: CachedUser
    
    var body: some View {
        HStack {
            // CALL BUTTON
            Button {
                // CALLING METHOD
                print("Calling...")
            } label: {
                Label("Call", systemImage: "phone.fill")
                    .labelStyle(.titleAndIcon)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(user.isActive ? Color.green : Color.gray)
                    .opacity(user.isActive ? 1 : 0.5)
                    .clipShape(Capsule())
            }
            .disabled(!user.isActive)
            
            // SEND MESSAGE BUTTON
            Button {
                // MESSAGING METHOD
                print("Messaging...")
            } label: {
                Label("Message", systemImage: "text.bubble.fill")
                    .labelStyle(.titleAndIcon)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.green
                            .clipShape(Capsule())
                    }
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    // DUMMY DATA
    static let user = CachedUser()
    
    static var previews: some View {
        ButtonView(user: user)
    }
}
