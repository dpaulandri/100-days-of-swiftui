//
//  ContentView.swift
//  Moonshot-SwiftUI concepts
//
//  Created by Paul Andri on 07/30/2022.
//

import SwiftUI


/*
// CONVENTIONAL WAYS TO CLIP & SCALE IMAGES IN SWIFTUI
struct ContentView: View {
    var body: some View {
        
        /*
        // "CLIP" AN IMAGE TO A FRAME SIZE
        Image("aldrin")
            .frame(width: 300, height: 300)
            .clipped()
        */
        
        // '.resizable()' MODIFIER - MAKE AN IMAGE SCALABLE & STRETCHABLE
        Image("aldrin")
            .resizable()
            
            // '.scaledToFit()' - SCALE AN IMAGE TO FIT THE ENTIRE IMAGE INTO A CONSTRAIN
            // POTENTIALLY WILL HAVE WHITE SPACES
            //.scaledToFit()
        
            // '.scaledToFit()' - SCALE AN IMAGE TO FILL A CONSTRAIN
            // POTENTIALLY SPILL THE IMAGE OUTSIDE THE CONSTRAIN
            .scaledToFill()
            .frame(width: 300, height: 300)
            
    }
}
*/



/*
// 'GeometryReader' VIEW
// 'GeometryReader'AUTOMATICALLY EXPANDS TO TAKE UP AVAILABLE SPACE & POSITIONS ITS CONTENT ALIGNED TO TOP-LEFT CORNER
struct ContentView: View {
    var body: some View {
        
        // USING 'GeometryReader' TO FILL SPECIFIC SCREEN PROPERTY ON iDEVICE
        // 'GeometryProxy' lets us query the iDevice environment
        // 'geo in' IS THE PROXY
        GeometryReader { geo in
            Image("aldrin")
                .resizable()
                .scaledToFit()
                .frame(
                    // USE THE GEOMETRY PROXY's WIDTH SIZE VALUE
                    // ASK 'GeometryReader' TO FILL 80% OF THE VIEW
                    width: geo.size.width * 0.8

                    // WE OMITTED THE FRAME 'height' VALUE
                    // SWIFTUI CAN AUTOMATICALLY ADJUST TO THE CORRECT PROPORTIONAL FRAME HEIGHT SIZE
                    // BECAUSE WE HAD THE IMAGE MODIFIER '.scaledToFit()'
                )
            
                // ADD ADDITIONAL TO CENTER-ALIGNED THE 'GeometryReader' FRAME VIEW
                .frame(width: geo.size.width, height: geo.size.height)
        }
        
    }
}
*/



/*
// 'ScrollView'
struct ContentView: View {
    var body: some View {
        
        // SCROLL VIEW
        ScrollView {
            VStack(spacing: 10) {
                ForEach(1..<101) {
                    Text("Item \($0)")
                        .font(.title)
                }
            }
            // MODIFY THE VSTACK VIEW FRAME TO FILL THE ENTIRE FRAME WIDTH
            // USER ARE ABLE TO SCROLL THE VSTACK VIEW BY TAPPING ANYWHERE
            .frame(maxWidth: .infinity)
        }
        
    }
}
*/



/*
// 'LazyVStack' & 'LazyHStack'
// USE JUST LIKE REGULAR V/HSTACK, BUT ONLY LOAD CONTENT WHEN NEEDED
// REDUCE THE AMOUNT OF SYSTEM RESOURCE USED

// STRUCT TO PRINT IN DEBUG CONSOLE WHEN A NEW TEXT IS CREATED IN LAZYVSTACK VIEW
struct CreateText: View {
    let text: String
    var body: some View {
        Text(text)
    }
    init(_ text: String) {
        print("Creating a new Text")
        self.text = text
    }
    
}

// MAIN VIEW W/ LAZYVSTACK INSIDE A SCROLLVIEW
struct ContentView: View {
    var body: some View {
        
        /*
        ScrollView {
            // LAZYVSTACK VIEW
            LazyVStack(spacing: 10) {
                ForEach(1..<101) {
                    CreateText("Item \($0)")
                        .font(.title)
                }
            }
            // MODIFY THE VSTACK VIEW FRAME TO FILL THE ENTIRE FRAME WIDTH
            // USER ARE ABLE TO SCROLL THE VSTACK VIEW BY TAPPING ANYWHERE
            .frame(maxWidth: .infinity)
        }
        */
        
        
        // MAKE A HORIZONTAL SCROLL VIEW
        ScrollView(.horizontal) {
            // LAZYHSTACK VIEW
            // THE LAZY STACK VIEW SHOULD CORRESPOND TO THE SCROLLING VIEW AXIS!!
            LazyHStack(spacing: 10) {
                ForEach(1..<101) {
                    CreateText("Item \($0)")
                        .font(.title)
                }
            }
            // MODIFY THE VSTACK VIEW FRAME TO FILL THE ENTIRE FRAME WIDTH
            // USER ARE ABLE TO SCROLL THE VSTACK VIEW BY TAPPING ANYWHERE
            .frame(maxWidth: .infinity)
        }
    }
}
*/



/*
// 'NavigationLink' VIEW
struct ContentView: View {
    var body: some View {
        
        // NAVIGATION VIEW
        NavigationView {
            List(1..<101) { row in
                
                // 'NavigationLink' VIEW
                NavigationLink {
                    Text("Hello, I'm #\(row)!")
                } label: {
                    Text("Show #\(row)")
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}
*/



/*
// WORKING W/ HIERARCHICAL 'Codeable' DATA

// STRUCT'S PROPERTY NAME MUST MATCH THE JSON DATA'S STRING
struct User: Codable {
    let name: String
    let address: Address
}

// STRUCT'S PROPERTY NAME MUST MATCH THE JSON DATA'S STRING
struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    var body: some View {
        Button("Decode JSON") {
            // 'input' PROPERTY VALUE IS A JSON FORMAT DATA
            // WE WOULD USUALLY CREATE THIS IN A SEPARATE JSON FILE
            let input = """
            {
                "name" : "Taylor Swift",
                "address" : {
                    "street" : "555, Taylor Swift Avenue",
                    "city" : "Nashville"
                }
            }
            """
            
            // PREPARE 'input' VALUE AS A 'Data' TYPE TO DECODE
            let data = Data(input.utf8)
            
            // TRY DECODE THE 'data' JSON VALUE AND STORE IT AS THE VALUE FOR 'user' PROPERTY
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                // PRINT THIS VALUE IF 'data' JSON DATA IS SUCCESSFULLY DECODED
                print(user.address.street)
                // Prints: "555, Taylor Swift Avenue"
            }
        }
    }
}
*/




// 'LazyVGrid' & 'LazyHGrid' VIEWS
// SCROLLING GRID OF DATA
// ABLE TO ADAPT TO SHOW MORE DATAS ON LARGER SCREENS
struct ContentView: View {
    // STEP 1: DEFINE THE NUMBER OF COLUMNS(V) / ROWS(H) FOR THE LAZY GRID
    let layout = [
        /*
         // THE LAYOUT IS 3 COLUMNS, EXACTLY 80POINTS WIDE EACH
         GridItem(.fixed(80)),
         GridItem(.fixed(80)),
         GridItem(.fixed(80))
        */
        
        /*
        // THE AMOUNT OF COLUMN IS ADAPTIVE
        // EACH COLUMN HAVE A MINIMUM WIDTH SIZE OF 80POINTS
        GridItem(.adaptive(minimum: 80))
        */
        
        // THE AMOUNT OF COLUMN IS ADAPTIVE
        // EACH COLUMN HAVE A MINIMUM WIDTH SIZE OF 80POINTS & MAXIMUM WIDTH SIZE OF 120POINTS
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    
    var body: some View {
        
        // 'LazyVGrid' VIEW
        // STEP 2: PLACE THE LAYOUT INSIDE A 'ScrollView'
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(1..<1001) {
                    Text("Item \($0)")
                }
            }
        }
        
        
        /*
        // 'LazyHGrid' VIEW
        // STEP 2: PLACE THE LAYOUT INSIDE A 'ScrollView'
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(1..<1001) {
                    Text("Item \($0)")
                }
            }
        }
        */
        
    }
}


        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
