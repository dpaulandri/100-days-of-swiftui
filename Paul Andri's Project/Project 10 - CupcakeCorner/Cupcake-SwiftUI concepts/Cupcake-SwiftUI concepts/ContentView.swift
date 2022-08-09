//
//  ContentView.swift
//  Cupcake-SwiftUI concepts
//
//  Created by Paul Andri on 08/08/2022.
//

import SwiftUI

// 'Codable' CONFORMANCE FOR '@Published' PROPERTIES
/*
// CLASS THAT CONFORMS TO 'ObservableObject' & 'Codable' PROTOCOLS
class User: ObservableObject, Codable {
    
    // 3 STEPS TO MAKE '@Published' PROPERTIES TO CONFORM TO 'Codable' PROTOCOLS
    // STEP 01: Create an 'enum' that conforms to 'CodingKey' Protocol
    enum CodingKeys: CodingKey {
        // List all the Properties to Archive & Unarchive as 'case's
        case name
    }
    
    // '@Published' PROPERTIES
    // DO NOT AUTOMATICALLY COMFROM TO 'Codable'('Encodable' & 'Decodable') PROTOCOL OUT OF THE BOX
    @Published var name = "Paul Andri"
    
    
    // STEP 02: Create a custom Initializer that accept a general 'Decoder' Type Param value
    // READ/DECODE PUBLISHED PROPERTY VALUE(S)
    // 'required' - any Object that subClassed this 'User' Class MUST OVERRIDE this initializer with a custom implementation to make sure they add their own Values
    // NOTE: 'required' KEYWORD IS NOT REQUIRED IF 'User' IS A 'final' CLASS
    required init(from decoder: Decoder) throws {
        // Give some sort of Container, and use that to READ/DECODE values for all our Properties
        // '(keyedBy: CodingKeys.self) - using our 'CodingKeys' Enum cases as the Decoding Keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Will throw an Error if the Keys DID NOT EXIST
        
        // Try to DECODE the 'String' Value from the Decoding Key 'name' ('name' case in 'CodingKeys' Enum)
        // IF SUCCESSFUL: the decoded 'String' value is assigned to the PUBLISHED PROPERTY 'name'
        name = try container.decode(String.self, forKey: .name)
    }
    
    // STEP 03: Create a Method to WRITE/ENCODE PUBLISHED PROPERTY VALUE(S)
    func encode(to encoder: Encoder) throws {
        // Give some sort of Container, and use that to WRITE/ENCODE values for all our Properties
        // '(keyedBy: CodingKeys.self) - using our 'CodingKeys' Enum cases as the Encoding Keys
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Try to ENCODE the PUBLISHED PROPERTY 'name' Value from the Encoding Key 'name' ('name' case in 'CodingKeys' Enum)
        try container.encode(name, forKey: .name)
    }
    
}
*/



// SEND/RECEIVE 'Codeable' DATA W/ 'URLSession'
/*
// 'Result' DATA TYPE STRUCT, CONFORMS TO 'Result' PROTOCOL
struct Result: Codable {
    // PROPERTY THAT STORES A 'Int' TYPE MUSIC TRACK ID
    var trackId: Int
    // PROPERTY THAT STORES A 'String' TYPE MUSIC TRACK NAME
    var trackName: String
    // PROPERTY THAT STORES A 'String' TYPE MUSIC TRACK'S ALBUM NAME
    var collectionName: String
}

// 'Response' DATA TYPE STRUCT, CONFORMS TO 'Codeable' PROTOCOL
struct Response: Codable {
    // PROPERTY THAT HOLDS A 'Result' DATA TYPE ARRAY
    var results: [Result]
}




// MAIN CONTENT VIEW
struct ContentView: View {
    // STATE PROPERTY TO STORE AN INTIAL EMPTY 'Result' TYPE ARRAY
    @State private var results = [Result]()
    
    var body: some View {
        
        // LIST VIEW
        // DYNAMICALLY GENERATE THE LIST VIEW FROM 'results' STATE PROPERTY'S ARRAY
        List(results, id: \.trackId) { item in
            // VSTACK VIEW
            VStack(alignment: .leading) {
                
                Text(item.trackName)
                    .font(.headline.bold())
                
                Text(item.collectionName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            
            }
            
        }
        // LIST VIEW MODIFIER
        // 'task()' MODIFIER - Execute Task(s) when this View in shown
        // Similar to 'onAppear()', BUT ABLE TO HANDLE TASK w/ 'await' SLEEPING FUNCTION
        .task {
            // Call 'loadData()' Method
            // 'await' - Explicitly acknowledging that a sleep might happen
            await loadData()
            // IF SUCCESFUL, WILL ASSIGN DECODED DATA FROM iTUNES SEARCH API TO 'results' STATE PROPERTY
        }
    }
    
    
    // METHOD TO LOAD DATA FROM APPLE's iTUNES SEARCH API
    // 'async' - Asynchronous Function:
    // Leave code running in background w/o freezing the main App code
    func loadData() async {
        // STEP 1: CREATE THE 'URL' TO READ
        // URL STRING SEARCHES FOR SONGS FROM "dua+lipa" IN ITUNES
        // IF SUCCESSFUL: URL value will be assign to the Property 'url'
        guard let url = URL(string: "https://itunes.apple.com/search?term=dua+lipa&entity=song") else {
            // DO THIS IF THE URL STRING IS INVALID:
            print("Invalid Search URL!")
            // EXIT
            return
        }
        
        // STEP 2: FETCH DATA FROM THE 'URL'
        // THIS STEP IS LIKELY WHERE A "SLEEP" MIGHT HAPPEN
        // 'do' & 'catch' BLOCK
        do {
            // 'data(from: url)' - Returns a 'Tuple' containing 'Data' object from 'url' & some metadata describing how the request went
            // '(data, _)' -  We create a new local Constant for the 'data', and toss the metadata away
            let (data, _) = try await URLSession.shared.data(from: url)
            // 'await' - Explicitly acknowledging that a sleep might happen
            // 'try await' - Correct SYNTAX when using both 'try' and 'await' at the same time
            
            // 'URLSession' is a configurable CLASS
            // 'URLSession.shared' instance comes with sensible defaults
        
            
            // IF DATA IS SUCCESFULLY FETCHED FROM 'url'
            // STEP 3: DECODE THE FETCHED DATA INTO A 'Reponse' DATA STRUCT
            // TRY TO DECODE JSON DATA W/ 'Response' DATA TYPE FROM 'data'
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                // IF DECODE IS SUCCESSFUL:
                // ASSIGN 'decodedResponse's 'results' PROPERTY VALUE TO 'results' STATE PROPERTY
                results = decodedResponse.results
            }
            
            
        } catch {
            // CATCH ERROR
            // IF STEP 2 AND/OR 3 FAILS :
            print("Invalid Data URL!")
        }
        
    }
}
*/



// 'AsyncImage' LOAD IMAGE FROM REMOTE SERVER
/*
struct ContentView: View {
    var body: some View {
        
        // 'AsyncImage' - NO CUSTOMISATION
        /*
        AsyncImage(url:
            URL(string: "https://www.dualipa.com/wp-content/uploads/2021/02/DUA_LIPA_THE_MOONLIGHT_EDITION_ARTWORK-1.jpg")
        )
        */
        
        // 'AsyncImage' W/ 'scale' PARAMETER
        /*
        AsyncImage(url:
            URL(string: "https://www.dualipa.com/wp-content/uploads/2021/02/DUA_LIPA_THE_MOONLIGHT_EDITION_ARTWORK-1.jpg"),
                // TELL SWIFTUI THE IMAGE SHOULD BE SHOWN IN 4x SCALE
                scale: 4
        )
        */
        
        // 'AsyncImage' W/ PLACEHOLDER VIEW + TRAILING CLOSURE MODIFIERS
        /*
        AsyncImage(url:
            URL(string: "https://www.dualipa.com/wp-content/uploads/2021/02/DUA_LIPA_THE_MOONLIGHT_EDITION_ARTWORK-1.jpg")
        ) { image in
            // 'AsyncImage' VIEW'S TRAILING CLOSURES FOR ADVANCED CUSTOMISATION
            // 'image' - THE DOWNLOADED IMAGE
            image
                // USING COMMON 'Image' VIEW MODIFIER
                .resizable()
                .scaledToFit()
        } placeholder: {
            // PLACEHOLDER VIEW FOR 'AsyncImage' VIEW
            // SHOWN WHILE THE IMAGE IS BEING DOWNLOADED IN THE BACKGROUND
            // CAN BE OF ANY VIEW
            
            // COLOR VIEW
            //Color.red
            
            // 'ProgressView()' - Spinner progress/loading activity indicator
            ProgressView()
        }
        // 'AsyncImage' VIEW MODIFIER
        .frame(width: 300, height: 200)
        */
    
        // 'AsyncImage' W/ TRAILING CLOSURE FOR IMAGE LOADING VIEW PHASES
        AsyncImage(url:
            // IMAGE URL DOES NOT EXIST
            URL(string: "https://www.susweb.com/pingpong.jpg")
        ) { phase in
            // TRAILING CLOSURE FOR IMAGE LOADING PHASES
            
            // LOADING PHASES
            if let image = phase.image {
                // IF IMAGE DOWNLOAD IS SUCCESSFUL:
                // SHOW THE DOWNLOADED IMAGE (RESIZABLE & SCALE TO FIT)
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                // IF UNABLE TO DOWNLOAD IMAGE
                // PRINT THIS:
                Text("Failed to load image!")
            } else {
                // IF THE IMAGE IS STILL BEING DOWNLOAD:
                // SHOW PROGRESS VIEW
                ProgressView()
            }
        }
        // 'AsyncImage' VIEW MODIFIER
        .frame(width: 300, height: 200)
    }
}
*/



// VALIDATING & DISABLING 'Form' VIEW W/ 'disabled()' MODIFIER
// Validate a condition, if the condition is true: whatever it’s attached to won’t respond to user input
//
struct ContentView: View {
    // STATE PROPERTY TO STORE USER NAME
    @State private var username = ""
    // STATE PROPERTY TO STORE EMAIL ADDRESS
    @State private var email = ""
    
    var body: some View {
        
        NavigationView {
            // FORM VIEW
            Form {
                Section("Enter Details") {
                    TextField("Username", text: $username)
                        // INPUT AUTO-CAPITALIZATION FOR EVERY WORD ON 'username' TEXTFIELD INPUT
                        .autocapitalization(.words)
                        // DISABLE INPUT AUTO-CORRECT ON 'username' TEXTFIELD INPUT
                        .disableAutocorrection(true)
                    TextField("Email", text: $email)
                        // DISABLE INPUT AUTO-CAPITALIZATION ON 'email' TEXTFIELD INPUT
                        .autocapitalization(.none)
                        // DISABLE INPUT AUTO-CORRECT ON 'email' TEXTFIELD INPUT
                        .disableAutocorrection(true)
                }
            }
            .navigationTitle("Create Account")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Submit") {
                        print("Creating account...")
                    }
                    // 'disabled()' MODIFIER
                    // SIMPLE CONDITIONAL CHECKING
                    /* DISABLE THE BUTTON INPUT IF 'username' OR 'email' PROPERTY IS EMPTY
                    .disabled(username.isEmpty || email.isEmpty)
                     */
                    
                    // 'disabled()' MODIFIER
                    // CONDITIONAL CHECKING BY CALLING A COMPUTED PROPERTY
                    .disabled(disableSubmit)
                }
            }
        }
        
    }
    
    // A COMPUTED DISABLE SUBMIT PROPERTY, COMPUTED VALUE IS A 'Bool' TYPE
    var disableSubmit: Bool {
        // 'username' OR 'email' STATE PROPERTY COUNT IS LESS THAN 5
        // 'email' DOES NOT CONTAIN '@'
        username.count < 5 || email.count < 5 || !email.contains("@")
    }
}
//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
