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
    var body: some View {
        HStack {
            // CALL BUTTON
            Button {
                // CALLING METHOD
            } label: {
                Label("Call", systemImage: "phone.fill")
                    .labelStyle(.titleAndIcon)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        Color.green
                            .clipShape(Capsule())
                    }
            }
            
            // SEND MESSAGE BUTTON
            Button {
                // MESSAGING METHOD
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
        .padding()
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
