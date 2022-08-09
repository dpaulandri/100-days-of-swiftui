//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Paul Andri on 08/09/2022.
//
// ORDER CHECKOUT VIEW

import SwiftUI

struct CheckoutView: View {
    // OBSERVED OBJECT TO READ THE DATA FROM 'ContentView's 'order' STATE OBJECT PROPERTY
    @ObservedObject var order: Order
    
    var body: some View {
        // MAIN SCROLL VIEW
        ScrollView {
            // MAIN VSTACK VIEW
            VStack {
                // LOAD REMOTE CUPCAKE IMAGE
                AsyncImage(url:
                            URL(string: "https://img.okezone.com/content/2015/08/21/298/1200385/cupcakes-paling-enak-di-jakarta-cEBxPu2nf6.jpg")
                           // SCALED TO @3x VIEW
                           // scale: 3
                ) { image in
                    // TRAILING CLOSURE FOR 'AsyncImage' VIEW CUSTOMISATION
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    // PROGRESS VIEW PLACEHOLDER IMAGE
                    ProgressView()
                }
                // ASYNCIMAGE FRAME MODIFIER
                .frame(height: 250)
                
                
                // ORDER SUMMARY SECTION
                OrderSummaryView(order: order)
            }
            // VSTACK VIEW MODIFIERS
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            
            // ADD TOOLBAR
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    // BUTTON TO PLACE USER ORDER
                    Button {
                        //
                    } label: {
                        HStack {
                            Image(systemName: "bag")
                            Text("Place Order")
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        // PREVIEW 'CheckoutView' IN THE CONTEXT OF 'NavigationView'
        NavigationView {
            // PASS IN AN EMPTY 'Order' CLASS DATA
            CheckoutView(order: Order())
        }
    }
}
