//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Paul Andri on 08/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    // CREATE A NEW '@StateObject' PROPERTY OF 'Order' CLASS INSTANCE
    // THIS PROPERTY WILL STORE ALL THE ORDER DATA ON THE APP
    @StateObject var order = Order()
    
    // BODY VIEW
    var body: some View {
        // MAIN NAVIGATION VIEW
        NavigationView {
            // FORM VIEW
            Form {
                // USER ORDER INPUT SECTION
                Section {
                    // PICKER TO SELECT CUPCAKE FLAVOUR
                    Picker("Flavor", selection: $order.flavor) {
                        // FOREACH LOOP TO ITERATE EACH ARRAY ITEM IN 'flavors' PUBLISHED PROPERTY
                        // 'indices' GO UP THE ARRAY INDEX IN ASCENDING ORDER
                        ForEach(Order.flavors.indices) {
                            Text(Order.flavors[$0])
                        }
                    }
                    
                    // STEPPER TO INPUT QTY OF CUPCAKE
                    Stepper(
                        "Quantity: \(order.quantity)",
                        value: $order.quantity,
                        in: 1...12 // VALID INPUT RANGE FROM 1 - 12
                    )
                }
                
                // SPECIAL ORDER REQUEST SECTION
                Section {
                    // TOGGLE INPUT TO TOGGLE 'specialRequest' PROPERTY VALUE
                    // '.animation()' ADD ANIMATION WHEN THE PROPERTY VALUE CHANGES ON 'specialRequest'
                    Toggle("Special Request", isOn: $order.specialRequest.animation())
                    
                    // CONDITIONAL EXTRA TOGGLE INPUTS
                    // SHOW ONLY IF 'specialRequest' PROPERTY VALUE IS 'true'
                    if order.specialRequest {
                        // TOGGLE INPUT TO TOGGLE 'extraFrosting' PROPERTY VALUE
                        Toggle("Extra Frosting", isOn: $order.extraFrosting)
                        
                        // TOGGLE INPUT TO TOGGLE 'chocoShavings' PROPERTY VALUE
                        Toggle("Chocolate Shavings", isOn: $order.chocoShavings)
                        
                        // TOGGLE INPUT TO TOGGLE 'addSprinkles' PROPERTY VALUE
                        Toggle("Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                // ADD DELIVERY ADDRESS VIEW SECTION
                Section {
                    NavigationLink {
                        // NAVIGATE TO 'AddressView'
                        AddressView(order: order)
                    } label: {
                        Label("Delivery details", systemImage: "shippingbox")
                            .foregroundColor(.primary)
                    }
                }
            }
            // FORM VIEW MODIFIER
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
