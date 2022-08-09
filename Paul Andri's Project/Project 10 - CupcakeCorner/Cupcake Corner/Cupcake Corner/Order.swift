//
//  Order.swift
//  Cupcake Corner
//
//  Created by Paul Andri on 08/09/2022.
//

import SwiftUI

// 'Order' CLASS TO STORE ALL OUR APP ORDER DATAS
// CLASS CONFORMS TO 'ObservableObject' PROTOCOL
// ALLOWS CLASS DATA WILL BE PASSED TO EVERY VIEWS
class Order: ObservableObject {
    // STATIC ARRAY TO STORE THE AVAILABLE CUPCAKE FLAVOURS
    static let flavors = ["Vanilla", "Chocolate", "Cream Cheese", "Salted Caramel", "Rainbow"]
    
    
    // PUBLISHED PROPERTIES - BROADCAST CHANGE MESSAGE TO ALL OBSERVED PROPERTIES THAT ARE WATCHING THESE OBJECTS
    
    // USER CUPCAKE ORDER DETAIL PUBLISHED PROPERTY SECTION
    // STORE THE CHOSEN 'flavor' PROPERTY'S ARRAY INDEX #
    @Published var flavor = 0
    // PUBLISHED PROPERTY TO STORE THE USER INPUT ORDER QUANTITY
    @Published var quantity = 1
    
    
    // SPECIAL REQUEST PUBLISHED PROPERTY SECTION
    // PUBLISHED PROPERTY TO STORE BOOL VALUE OF WHETHER USER HAS ENABLED SPECIAL REQUEST FEATURE
    @Published var specialRequest = false {
        // ADD PROPERTY OBSERVER TO ENSURE CORRECT SPECIAL REQUEST ORDER DATA
        // DISABLE 'extraFrosting' & 'extraSprinkles' WHEN 'specialRequest' VALUE IS 'false'
        
        // RUN THIS BODY OF CODE WHENEVER 'specialRequest' PROPERTY VALUE IS CHANGED
        didSet {
            if specialRequest == false {
                extraFrosting = false
                chocoShavings = false
                addSprinkles = false
            }
        }
    }
    // PUBLISHED PROPERTY TO STORE BOOL VALUE OF WHETHER USER WANT XTRA CUPCAKE FROSTING
    @Published var extraFrosting = false
    // PUBLISHED PROPERTY TO STORE BOOL VALUE OF WHETHER USER WANT TO ADD CHOCOLATE SHAVINGS ON THE CUPCAKE
    @Published var chocoShavings = false
    // PUBLISHED PROPERTY TO STORE BOOL VALUE OF WHETHER USER WANT TO ADD SPRINKLES ON THE CUPCAKE
    @Published var addSprinkles = false
    
    
    // USER INPUT DELIVERY ADDRESS PUBLISHED PROPERTY SECTION
    // PUBLISHED PROPERTY TO STORE ORDER RECIPIENT NAME
    @Published var name = ""
    // PUBLISHED PROPERTY TO STORE DELIVERY ADDRESS
    @Published var address = ""
    // PUBLISHED PROPERTY TO STORE DELIVERY ADDRESS' CITY NAME
    @Published var city = ""
    // PUBLISHED PROPERTY TO STORE DELIVERY ADDRESS' ZIP CODE
    @Published var zip = ""
    
    
    // COMPUTED PROPERTY TO VALIDATE USER INPUT DELIVERY ADDRESS PROPERTY VALUES
    var hasValidAddress: Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty {
            // IF ANY OF THE ADDRESS PROPERTIES IS EMPTY:
            // hasValidAddress = false
            return false
        }
        
        // IF ALL ADDRESS PROPERTIES IS NOT EMPTY:
        // hasValidAddress = true
        return true
    }
    
    
    
    // PROPERTIES FOR CUPCAKE PRICING CALCULATIONS
    
    // COMPUTED PROPERTY FOR CUPCAKE GRAND TOTAL
    var grandTotal: Double {
        // BASE COST OF $2/CUPCAKE
        var price = Double(quantity) * 2
        
        // VARIABLE ADD-ON COSTS DEPENDING ON THE CHOSEN CUPCAKE FLAVOUR
        price += (Double(flavor) / 2) * Double(quantity)
        
        // OPTIONAL $1 ADD-ON COST FOR EXTRA CUPCAKE FROSTING
        if extraFrosting {
            price += Double(quantity)
        }
        
        // OPTIONAL $1 ADD-ON COST FOR ADDING CHOCOLATE SHAVINGS
        if chocoShavings {
            price += Double(quantity)
        }
        
        // OPTIONAL $0.50 ADD-ON COST FOR ADDING CUPCAKE SPRINKLES
        if addSprinkles {
            price += Double(quantity) / 2
        }
        
        // RETURN THE FINAL 'price' VALUE
        return price
    }
    
}
