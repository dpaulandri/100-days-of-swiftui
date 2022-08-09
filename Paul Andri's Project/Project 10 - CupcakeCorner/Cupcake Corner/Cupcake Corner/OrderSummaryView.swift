//
//  OrderSummaryView.swift
//  Cupcake Corner
//
//  Created by Paul Andri on 08/09/2022.
//
// ORDER SUMMARY VIEW (SHOWN IN 'CheckoutView')

import SwiftUI

struct OrderSummaryView: View {
    // OBSERVED OBJECT TO READ THE DATA FROM 'ContentView's 'order' STATE OBJECT PROPERTY
    @ObservedObject var order: Order
    
    var body: some View {
        // MAIN VSTACK VIEW
        VStack {
            // CUSTOMER SECTION
            Section {
                Spacer()
                
                VStack {
                    Text(order.name)
                        .font(.title3)
                        .bold()
                    Text("\(order.city), \(order.zip)")
                }
                .font(.callout)
                
                Spacer()
                Spacer()
            }
            
            // ORDER SUMMARY SECTION
            Section {
                Text("Order Summary")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                VStack {
                    // CUPCAKE FLAVOUR HSTACK
                    HStack {
                        Text("Cupcake Flavor:")
                            .font(.headline)
                        Spacer()
                        Text(Order.flavors[order.flavor])
                    }
                    
                    // CUPCAKE PRICE HSTACK
                    HStack {
                        Text("Price:")
                            .font(.headline)
                        Spacer()
                        Text("\(2 + (Double(order.flavor) / 2), format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    }
                    
                    // CUPCAKE QUANTITY HSTACK
                    HStack {
                        Text("Quantity:")
                            .font(.headline)
                        Spacer()
                        Text("\(order.quantity)")
                    }
                }
            }
            
            Spacer()
            
            // SUBTOTAL SECTION
            Section {
                HStack {
                    Spacer()
                    Text("Sub Total:  \((2 * Double(order.quantity) + ((Double(order.flavor) / 2) * Double(order.quantity))), format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                        .font(.title2)
                        .bold()
                }
            }
            
            
            // SPECIAL REQUEST DETAIL SECTION (CONDITIONAL)
            if order.specialRequest {
                Section{
                    Spacer()
                    Spacer()
                    
                    VStack {
                        HStack {
                        Text("Special Request:")
                                .font(.headline)
                        Spacer()
                        }
                        
                        if order.extraFrosting {
                            HStack {
                                Text("- Extra Frosting")
                                Spacer()
                                Text("+ \((1.0 * Double(order.quantity)), format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                            }
                        }
                        if order.chocoShavings {
                            HStack {
                                Text("- Chocolate Shavings")
                                Spacer()
                                Text("+ \((1.0 * Double(order.quantity)), format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                            }
                        }
                        if order.addSprinkles {
                            HStack {
                                Text("- Add Sprinkles")
                                Spacer()
                                Text("+ \((0.5 * Double(order.quantity)), format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                            }
                        }
                    }
                    .font(.subheadline)
                }
            }
            else {
                Section {
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Text("Special Request:")
                            .font(.headline)
                        Spacer()
                        Text("+ \((0.0), format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                    }
                }
            }
            
            Spacer()
            Spacer()
            
            // GRAND TOTAL SECTION
            Section {
                HStack {
                    Spacer()
                    Text("Grand Total:  \(order.grandTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))")
                        .font(.title)
                        .bold()
                }
            }
            
        }
        // VSTACK VIEW MODIFIERS
        .padding(.horizontal, 50)
        .padding(.bottom)
        .frame(maxWidth: 500)
    }
}


struct OrderSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummaryView(order: Order())
    }
}
