//
//  ContentView.swift
//  iExpense-SwiftUI concepts
//
//  Created by Paul Andri on 07/24/2022.
//

import SwiftUI


/*
// '@State' STATE PROPERTY WRAPPER

// A STRUCT (VALUE TYPE) THAT SAVES A USER FIRST & LAST NAME
// 'struct' (VALUE TYPE) CAN'T BE USED TO SHARE DATA ACROSS MULTIPLE VIEWS
class User {
    var firstName = "Bruce"
    var lastName = "Wayne"
}

struct ContentView: View {
    // STATE PROPERTY THAT IS A 'User' STRUCT INSTANCE
    // UNIQUE COPY OF THE 'User()' STURCT W/ ITS OWN DATA (NO SHARED DATA)
    // '@State' watches a local Property for changes & SwiftUI re-invoke 'body' View when it does
    // Works well w/ 'struct' Instances, BUT NOT w/ 'class' Instances
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            // TEXT FIELDS BINDED TO STATE PROPERTIES
            // COULD OVERWRITE THE 'user' PROPERTY VALUES
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}
*/



/*
// '@Published' & '@StateObject' PROPERTY WRAPPERS

// A CLASS (REFERENCE TYPE) THAT SAVES A USER FIRST & LAST NAME
// USE 'class' (REFERENCE TYPE) TO SHARE DATA ACROSS MULTIPLE VIEWS
// 'struct' (VALUE TYPE) CAN'T BE USED TO SHARE DATA ACROSS MULTIPLE VIEWS
// 'class' MUST CONFORM TO 'ObservedObject' PROTOCOL TO BE USED W/ '@StateObject' WRAPPER
class User: ObservableObject {
    // '@Published' STATE PROPERTY WRAPPERS
    // Notify any Views that are watching the 'class' that a change has happened
    @Published var firstName = "Bruce"
    @Published var lastName = "Wayne"
}

struct ContentView: View {
    // '@StateObject' PROPERTY
    // CREATE A 'class' INSTANCE THAT WATCHES FOR ANY CHANGE ANNOUNCEMENTS TO THE CLASS
    // RE-INVOKE 'body' VIEW IF SWIFT ANNOUNCED A CHANGE TO THE OBSERVED 'class' HAS HAPPENED
    // COPY OF THE 'User()' CLASS W/ SHARED DATA
    // We do not use 'private' because we're no longer sharing only within the scope of the 'struct' only
    @StateObject var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            // TEXT FIELDS BINDED TO STATE PROPERTIES
            // COULD OVERWRITE THE SHARED PROPERTY VALUES IN 'User' CLASS
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
}
*/



/*
// SHOW/HIDE VIEWS USING 'sheet()' + '@Environment' PROPERTY WRAPPER

// STEP 1: CREATE SECONDARY VIEW STRUCT
// MUST CONFORM TO 'View' PROTOCOL
struct SecondView: View {
    
    // '@Environment' PROPERTY TO DISMISS THE SECONDARY VIEW
    @Environment(\.dismiss) var back
    
    // STRUCT PROPERTY
    let name: String
    
    var body: some View {
        Spacer()
        
        Text("Hello,")
            .font(.subheadline.weight(.regular))
        
        Text(name)
            .font(.title.weight(.bold))
        
        Spacer()
        Spacer()
        
        // BUTTON TO DISMISS THE SECONDARY VIEW
        // OPTIONAL: 'sheet()' VIEW COULD BE DISMISSED BY SWIPING DOWN THE VIEW
        Button("BACK") {
            // CALL ON THE 'back' ENVIRONMENT PROPERTY
            back()
        }
        .frame(maxWidth: 200, maxHeight: 50)
        .font(.headline.weight(.bold))
        .background(.red)
        .foregroundColor(.white)
        .padding(20)
        
        Spacer()
    }
}

// MAIN 'CContentView' VIEW STRUCT
struct ContentView: View {
    // STEP 2: CREATE STATE PROPERTY
    // STATE PROPERTY OF WHETHER THE SECONDARY IS CURRENTLY SHOWN
    @State private var showSecondary = false
    
    var body: some View {
        
        Spacer()
        
        Text("Who am I?")
            .font(.title.weight(.bold))
        
        Spacer()
        Spacer()
        
        Button("SHOW") {
            // TOGGLE THE PROGRAM STATE OF 'showSecondary' ON EACH BUTTON TAP
            showSecondary.toggle()
        }
        .frame(maxWidth: 200, maxHeight: 50)
        .font(.headline.weight(.bold))
        .background(.blue)
        .foregroundColor(.white)
        .padding(20)
        
        // STEP 3: ATTACH 'sheet()' TO OUR MAIN VIEW HIERARCHY
        // BIND TO 'showSecondary' PROGRAM STATE
        .sheet(isPresented: $showSecondary) {
            // STEP 4: WHAT SHOULD BE SHOWN IN THE 'sheet()
            SecondView(name: "Bruce Wayne") // Pass-in Parameter value
        }
        
        Spacer()
    }
}
*/



/*
// DELETING ITEMS USING 'onDelete()' + 'EditButton()'
struct ContentView: View {
    // PROGRAM STATE PROPERTIES
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    // 'onDelete()' Modifier ONLY EXIST IN 'ForEach'
                    ForEach(numbers, id:\.self) {
                        Text("Row \($0)")
                    }
                    // 'onDelete()' MODIFIER TO REMOVE ROW FROM 'ForEach' Collection View
                    // SWIPE LEFT TO DELETE / SHOW DELETE BUTTON
                    // Call 'removeRow' Method to remove the item from 'numbers' Array
                    .onDelete(perform: removeRow)
                }
                
                // BUTTON TO ADD 'currentNumber' VALUE INTO 'numbers' ARRAY
                Button("Add Number") {
                    // APPEND 'currentNumber' VALUE INTO 'numbers' ARRAY
                    numbers.append(currentNumber)
                    
                    // INCREASE 'currentNumber' INT VALUE BY 1
                    currentNumber += 1
                }
            }
            .navigationTitle("Add/Delete Rows")
            
            // ATTACH NAVIGATION TOOL BAR FOR "EDIT" FUNCTION
            .toolbar {
                EditButton()
            }
            
        }
    }
    
    // METHOD TO DELETE ROW
    // 'IndexSet' Type: the "Index" set of all the items in a Collection View
    func removeRow(at offset: IndexSet) {
        //'.remove(atOffsets: )' removes from 'number' Array at the IndexSet position
        numbers.remove(atOffsets: offset)
    }
}
*/



/*
// STORE USER SETTINGS W/ 'UserDefaults'
struct ContentView: View {
    // PROGRAM STATE PROPERTY TO STORE BUTTON TAP COUNT
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    // Reads an 'integer' value from the standard 'UserDefaults' from "Tap" Key
    
    
    var body: some View {
        
        Button("TAP: \(tapCount)") {
            tapCount += 1
            
            // Use 'UserDefaults' to store the value of 'tapCount'
            UserDefaults.standard.set(tapCount, forKey: "Tap")
            // 'set()' Collection View - accepts any types of Data
            // 'forKey:' - attach our 'UserDefaults' Data to a 'String'-type Key (case-sensitive)
            
        }
        .frame(maxWidth: 200,maxHeight: 50)
        .font(.title.weight(.bold))
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}
*/




// STORE USER SETTINGS W/ '@AppStorage' Property Wrapper
struct ContentView: View {
    // '@AppStorage' PROPERTY TO STORE BUTTON TAP COUNT
    // Work similar to 'UserDefaults'
    // Ideally the '@AppStorage's Key-name(case-sensitive) should match the Property's name
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        
        Button("TAP: \(tapCount)") {
            tapCount += 1
            
        }
        .frame(maxWidth: 200,maxHeight: 50)
        .font(.title.weight(.bold))
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}




/*
// ARCHIVING SWIFT OBJECT W/ 'Codeable' PROTOCOL
// Convert Objects into plain Text and back again

// A STRUCT THAT CONTAINS USER PROPERTIES
// CONFORMS TO THE 'Codable' PROTOCOL
struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    // PROGRAM STATE PROPERTY TO STORE OUR USER DATA (CALL 'User' STRUCT INSTANCE)
    @State private var user = User(firstName: "Bruce", lastName: "Wayne")
    
    var body: some View {
        
        // BUTTON TO "ARCHIVE" (CONVERT TO JSON DATA TYPE) & SAVE USER DATA TO 'UserDefaults'
        Button("Save User") {
            // MAKE AN INSTANCE OF A 'JSONEncoder'
            let encoder = JSONEncoder()
            
            
            // UNWRAP OPTIONAL DATA TO PASS ONTO 'JSONEncoder'
            // IF SUCCESSFULLY UNWRAPPED, 'data' WILL HOLD THE VALUE OF THE 'JSON-ENCODED' DATA FROM 'user' PROGRAM STATE PROPERTY
            // 'data' WILL HAVE A DATA TYPE OF 'Data'
            if let data = try? encoder.encode(user) {
                // IF UNWRAPPING IS SUCCESSFUL:
                // SAVE THE DATA FROM 'data' PROPERTY TO 'UserDefaults' W/ THEY KEYNAME "UserData"
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}
*/
 
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
