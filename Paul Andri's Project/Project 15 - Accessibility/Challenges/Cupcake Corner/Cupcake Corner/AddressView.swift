//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Paul Andri on 08/09/2022.
//
// ADD ADDRESS VIEW

import SwiftUI

struct AddressView: View {
    // OBSERVED OBJECT TO READ THE DATA FROM 'ContentView's 'order' STATE OBJECT PROPERTY
    @ObservedObject var order: Order
    
    var body: some View {
        //FORM VIEW
        Form {
            // USER ADDRESS INPUT SECTION
            Section {
                // RECIPIENT NAME INPUT
                TextField("Name", text: $order.name)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
					.accessibilityElement()
					.accessibilityValue(order.name.isEmpty ? "Recepient Name Input Textfield (Required)" : "Recepient Name: \(order.name)")
                // DELIVERY ADDRESS INPUT
                TextField("Address", text: $order.address)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
					.accessibilityElement()
					.accessibilityValue(order.address.isEmpty ? "Delivery Address Input Textfield (Required)" : "Delivery Address: \(order.address)")
                // DELIVERY ADDRESS' CITY NAME INPUT
                TextField("City", text: $order.city)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
					.accessibilityElement()
					.accessibilityValue(order.city.isEmpty ? "Delivery Address City Name Input Textfield (Required)" : "Delivery Address City Name: \(order.city)")
                // DELIVERY ADDRESS' ZIP CODE INPUT
                TextField("Zip", text: $order.zip)
                    .autocapitalization(.allCharacters)
                    .disableAutocorrection(true)
					.accessibilityElement()
					.accessibilityValue(order.zip.isEmpty ? "Delivery Address Zip Code Input Textfield (Required)" : "Delivery Address Zip Code: \(order.zip)")
            }
            
            // CHECKOUT VIEW SECTION
            Section {
                NavigationLink {
                    // NAVIGATE TO 'CheckoutView'
                    CheckoutView(order: order)
                } label: {
                    Label("Checkout", systemImage: "cart")
                        .foregroundColor(.primary)
                }
            }
            // DISABLE CHECKOUT VIEW SECTION IF 'hasValidAddress' VALUE IS 'false'
            .disabled(order.hasValidAddress == false)
            // IF DISABLED, USER WON'T BE ABLE ADVANCE TO 'CheckoutView'
        }
        // FORM VIEW MODIFIER
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        // PREVIEW 'AddressView' IN THE CONTEXT OF 'NavigationView'
        NavigationView {
            // PASS IN AN EMPTY 'Order' CLASS DATA
            AddressView(order: Order())
        }
    }
}
