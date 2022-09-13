//
//  Order.swift
//  Cupcake Corner
//
//  Created by Paul Andri on 08/09/2022.
//

import SwiftUI

// 'Order' CLASS TO STORE ALL OUR APP ORDER DATAS
// CLASS CONFORMS TO 'ObservableObject' & 'Codable' PROTOCOLS
// ALLOWS CLASS DATA WILL BE PASSED TO EVERY VIEWS
class Order: ObservableObject, Codable {
    // 3 STEPS TO MAKE 'Order' CLASS' '@Published' PROPERTIES CONFORM TO 'Codable' PROTOCOL:
    // STEP 01: CREATE AN ENUM W/ ALL REQUIRED '@Published' PROPERTIES AS ITS CASES
    enum CodingKeys: CodingKey {
        case flavor, quantity, extraFrosting, chocoShavings, addSprinkles, name, address, city, zip
    }
    
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
    // CONTAINS CODE FOR DAY 52 - CHALLENGE #1
    var hasValidAddress: Bool {
        // CHECK IF ANY OF THE DELIVERY ADDRESS PROPERTY VALUES IS EMPTY
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty {
            // IF ANY OF THE ADDRESS PROPERTIES IS EMPTY:
            // hasValidAddress = false
            return false
        }
        
        // CODE FOR DAY 52 - CHALLENGE #1
        // CHECK IF ANY OF THE DELIVERY ADDRESS PROPERTY VALUES CONTAINS ONLY A WHITESPACE " "
        if name == " " || address == " " || city == " " || zip == " " {
            // IF ANY OF THE ADDRESS PROPERTIES CONTAINS ONLY A WHITESPACE " ":
            // hasValidAddress = false
            return false
        }
        
        // IF ALL ADDRESS PROPERTIES IS NOT EMPTY / CONTAINS ONLY A WHITESPACE " ":
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
    
    
    // CREATE A CUSTOM INITIALIZER TO CREATE AN EMPTY 'Order' CLASS INSTANCE
    init() {
        // DO NOTHING
    }
    
    
    // 3 STEPS TO MAKE 'Order' CLASS' '@Published' PROPERTIES CONFORM TO 'Codable' PROTOCOL:
    // STEP 02: CREATE A METHOD TO ENCODE THE '@Published' PROPERTIES USING THE 'CodingKeys' ENUM CASES AS THE CODING KEY
    func encode(to encoder: Encoder) throws {
        // CREATE AN ENCODING CONTAINER W/ ITS CORRESPONDING CODING KEY
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // LIST OUT ALL '@Published' PROPERTY & ITS CODING KEY TO ENCODE
        try container.encode(flavor, forKey: .flavor)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(chocoShavings, forKey: .chocoShavings)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    // 3 STEPS TO MAKE 'Order' CLASS' '@Published' PROPERTIES CONFORM TO 'Codable' PROTOCOL:
    // STEP 03: CREATE A CUSTOM INITIALIZER TO DECODE A CLASS INSTANCE OF 'Order' USING THE 'CodingKeys' ENUM CASES AS THE CODING KEY
    required init(from decoder: Decoder) throws {
        // CREATE A DECODING CONTAINER & TRY TO DECODE THE CLASS INSTANCE W/ ITS CORRESPONDING CODING KEY
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // TRY ASSIGNINING THE DECODED VALUE TO ITS CORRESPONDING '@Published' PROPERTY & ITS DATA TYPE
        flavor = try container.decode(Int.self, forKey: .flavor)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        chocoShavings = try container.decode(Bool.self, forKey: .chocoShavings)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
              
    }

}
