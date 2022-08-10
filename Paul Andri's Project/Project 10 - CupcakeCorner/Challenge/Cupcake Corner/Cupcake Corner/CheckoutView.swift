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
    
    // ALERT WINDOW STAT PROPERTIES:
    // STATE PROPERTY TO STORE THE CONFIRMATION MESSAGE STRING VALUE
    @State private var confirmationMsg = ""
    // STATE PROPERTY TO STORE THE BOOL STATE  OF CONFIRMATION ALERT WINDOW
    @State private var showConfirmation = false
    // PART OF DAY 52 - CHALLENGE #2
    // STATE PROPERTY TO STORE THE BOOL STATE  OF NETWORK ERROR ALERT WINDOW
    @State private var showNetworkAlert = false
    
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
                        // CREATE 'Task' TO MAKE BUTTON VIEW SUPPORT CALLING ASYNC METHOD
                        Task {
                            // CALL 'placeOrder' ASYNC METHOD
                            await placeOrder()
                            // MARK 'await' TO INDICATE THE METHOD MAY SLEEP
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.green)
                            .frame(width: 250, height: 44)
                            .overlay(
                                HStack {
                                    Image(systemName: "bag")
                                        .foregroundColor(.white)
                                    Text("Place Order")
                                        .padding()
                                        .foregroundColor(.white)
                                        .font(.title2.bold())
                                }
                            )
                    }
                }
            }
            
            // ORDER CONFIRMATION ALERT WINDOW
            .alert("Thank you, \(order.name)!", isPresented: $showConfirmation) {
                Button("Ok") { }
            } message: {
                // ALERT WINDOW MESSAGE
                Text(confirmationMsg)
            }
            
            // PART OF DAY 52 - CHALLENGE #2
            // NETWORK ERROR ALERT WINDOW
            .alert("Network Error", isPresented: $showNetworkAlert) {
                Button("Ok") { }
                Button("Try Again") {
                    // CREATE 'Task' TO MAKE BUTTON VIEW SUPPORT CALLING ASYNC METHOD
                    Task {
                        // CALL 'placeOrder' ASYNC METHOD
                        await placeOrder()
                        // MARK 'await' TO INDICATE THE METHOD MAY SLEEP
                    }
                }
            } message: {
                // ALERT WINDOW MESSAGE
                Text("""
                Unable to place order.
                Please ensure network access is available.
                """)
            }
        }
    }
    
    // ASYNC METHOD TO HANDLE ORDER PLACEMENT
    func placeOrder() async {
        // TRY TO ENCODE 'order' DATA INTO A JSON DATA
        guard let encodedOrder = try? JSONEncoder().encode(order) else {
            // IF ENCODING FAILS
            print("Failed to encode Order data!")
            return
        }
        
        // DEFINE HOW THE 'encodedOrder' JSON DATA IS TO BE SENT
        // STEP 01: Define the Backend/Testing Server's URL address ('!' FORCE UNWRAP)
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        // STEP 02: Create a 'URLRequest' Object using 'url' URL address
        var request = URLRequest(url: url)
        // STEP 03: Define the Data Type we're sending over to the Backend Server
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // STEP 04: Define the HTTP Method of the ''URLRequest' Object
        // PART OF DAY 52 - CHALLENGE #2 - DISABLE 'httpMethod' TO TEST NETWORK ERROR ALERT WINDOW
        request.httpMethod = "POST"
        // 'POST' = SEND/UPLOAD, 'GET' = READ/DOWNLOAD
        
        
        // TRY MAKING NETWORK REQUEST (SENDING DATA) IN 'do' & 'catch' BLOCKS
        do {
            // PART OF DAY 52 - CHALLENGE #2
            // CREATE A NEW 'data' CONSTANT USING 'guard let'
            // '(data, _)' RETAIN ONLY THE REAL DATA & '_' OMIT OUT THE 'metadata'
            // TRY TO SEND/UPLOAD OUR 'encodedOrder' JSON DATA USING 'request' URLRequest Object
            // MARK 'await' TO EXPLICITLY STATE IT MIGHT GO TO "SLEEP"
            guard let (data, _) = try? await URLSession.shared.upload(for: request, from: encodedOrder) else {
                // IF UNABLE TO COMPLETE 'URLSession' UPLOAD FUNCTION:
                // SET 'showNetworkAlert' PROGRAM STATE TO TRIGGER ALERT WINDOW
                showNetworkAlert = true
                // EXIT THE DO BLOCK
                return
            }
            
            
            // ASSIGNING CUSTOMISED CONFIRMATION ALERT WINDOW MESSAGE:
            // STEP 1: DECODE THE JSON ENCODED 'Order' DATA from 'data' CONSTANT
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            // STEP 2: ASSIGN STRING INTERPOLATION VALUE USING 'decodedOrder' DATA VALUES
                confirmationMsg = """
                You've ordered:
                \(decodedOrder.quantity)x \(Order.flavors[decodedOrder.flavor]) \(decodedOrder.quantity > 1 ? "Cupcakes" : "Cupcake")
                            
                Your order is on its way!
            """
            
            // STEP 3: SET 'showConfirmation' PROGRAM STATE TO TRIGGER ALERT WINDOW
            showConfirmation = true
            
        } catch {
            // CATCH ANY ERROR THROWN
            print("Checkout failed!")
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
