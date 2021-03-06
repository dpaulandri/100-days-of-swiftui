//
//  ContentView.swift
//  WordScramble-SwiftUI concepts
//
//  Created by Paul Andri on 07/15/2022.
//

import SwiftUI


/*
// LIST VIEW - 'List'
// Provide scrolling table of Datas, equivalent to UIKit's 'UITableView'
struct ContentView: View {
    var body: some View {
        
        // LIST VIEW - 'List'
        List {
            
            // LIST CAN HAVE BOTH STATIC & DYNAMIC DATAS
            // iOS' Wifi Network selection screen is made of 'List' View
            
            // Ex: Static Datas within a 'Section'
            Section("Section 1") {
                Text("Static row 1")
                Text("Static row 2")
                Text("Static row 3")
            }
            
            // Ex: Dynamic Datas within a 'Section'
            Section("Section 2") {
                ForEach(1..<4) {
                    Text("Dynamic row \($0)")
                }
            }
            
        }
        // LIST VIEW STYLE MODIFIERS
        // '.listStyle()' - modifies how the 'List' is presented
        .listStyle(.grouped)
        
        
        // GENERATE DYNAMIC ROWS USING 'List'
        List(1..<4) {
            Text("Row \($0) generated by 'List'")
        }
        
    }
}
*/



/*
// UNIQUE IDENTIFIER FOR DYNAMIC ROWS GENERATED FROM 'List' & 'ForEach'
// 'id:' - UNIQUE IDENTIFIER in 'List' View
struct ContentView: View {
    // A String Array
    let characters = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        
        // GENERATE DYNAMIC ROWS USING 'List'
        // Dynamically generate rows in 'List' using the items in 'characters' Array
        // 'id: \.self' - Each item in the Array is its row UNIQUE IDENTIFIER
        List(characters, id: \.self) {
            Text($0)
        }
        
        
        // GENERATE DYNAMIC ROWS USING 'ForEach'
        List {
            Text("Static Row")
            
            // Dynamically generate rows using 'ForEach' from the items in 'characters' Array
            // 'id: \.self' - Each item in the Array is its row UNIQUE IDENTIFIER
            ForEach(characters, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }
        
    }
}
*/



/*
// "URL" DATA TYPE
// Stores web addresses, as well as the path/location of local files in the App bundle, etc
struct ContentView: View {
    var body: some View {
        Text(" ")
    }
    
    // An example Method for loading file
    func loadFile() {
        
        // Load file at the URL pointing to "MAIN" App Bundle
        // Would return optional 'URL?' Data Type
        // Use 'if let' to unwrap the Optional 'URL?' Data Type
        // Logic: Find "some-file.txt" Text file from the App's Main Bundle
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            
            // Code to execute if the file is found:
            // Load whatever 'String' value that is contained inside "some-file.txt" to a new Property called 'fileContents'
            // If successful, 'fileContents' will contain a 'String' type value
            if let fileContents = try? String(contentsOf: fileURL) {
            }
        }
        
        // 'Bundle.main.url' kind of URL is one of the way Apple implement "Sandboxing", making App more secure, self-contained & less prone to hacking attempts
        
    }
    
}
*/



/*
// WORKING WITH '[String]'
struct ContentView: View {
    var body: some View {
        Text("")
    }

    
    // BREAKING UP A 'String' VALUE INTO AN ARRAY
    // Break up the 'String' value separated by " " (Space)
    func test1() {
        
        // A 'String' Array
        let input = "a b c"
        
        // Break up the 'String' value from 'input', separated by " " (Space)
        let letters = input.components(separatedBy: " ")
        // 'letters' will contain a 'String' Array containing: ["a", "b", "c"]
        
    }
    
    
    // BREAKING UP A 'String' VALUE INTO AN ARRAY
    // Break up the 'String' value separated by "\n" (New line)
    // 'randomElement()' - getting random element from a [String]
    //
    func test2() {
        
        // A multiple line 'String' Array
        let input = """
        a
        b
        c
        """
        
        // Break up the 'String' value from 'input', separated by "\n" (New line)
        let letters = input.components(separatedBy: "\n")
        // 'letter' will contain a 'String' Array containing: ["a", "b", "c"]
        
        
        
        // 'randomElement()' - getting a random element from 'letters' Array
        // Will return an Optional 'String?', good idea to use w/ '??'
        let randomLetter = letters.description.randomElement()
     
        
        
        // 'trimmingCharacters(in: )' - Trim characters at the defined breakpoint
        // Trim Characters at any " " Whitespaces and New Lines
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // 'UITextChecker' - comes from UIKit
        // Check mis-spelled characters
        
    }
    
}
*/



// USING 'UITextChecker'
// Check for mis-spelled words
// Part of UIKit's 'UITableView', based on 'Objective-C', available for use w/ Swift
// 'OBJECTIVE-C' DOES NOT PLAY NICE w/ UNICODE/EMOJI CHARACTER SUPPORT LIKE SWIFT DOES
struct ContentView: View {
    var body: some View {
        Text("")
    }
    
    // Method to check 'String' value using 'UITextChecker'
    func checkSpelling() {
        let word = "Swift"
        
        // STEP 1 - CREATE AN 'UITextChecker' INSTANCE
        let checker = UITextChecker()
        
        
        // STEP 2 - USING SWIFT TO CREATE AN OBJECTIVE-C CHARACTER RANGE TO WORK W/ 'UITextChecker'
        let range = NSRange(location: 0, length: word.utf16.count)
        // We use 'utf16' to let 'Objective-C' understand how Swift handle and store its 'String' data
        
        
        // STEP 3 - DEFINE THE 'rangeOfMisspelledWord'
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        // 'rangeOfMisspelledWord()' components:
        // - 'in: word' - check mis-spelled in words
        // - 'range: range' - check the entire range
        // - 'startingAt: 0' - starting at position 0 (the start) of the predefined 'range'
        // - 'wrap' - Whether to wrap the range and start from the top again once finished
        // - 'language: "en"' - Use English dictionary words to check
        
        
        // STEP 4 - CREATE A COMPUTED BOOLEAN PROPERTY IF MIS-SPELLING ARE FOUND
        let noMistake = misspelledRange.location == NSNotFound
        // 'NSNotFound' is the 'Objective-C's equivalent of "Optional" in Swift
        // IF NO MISTAKE ARE FOUND, 'noMistake' will have 'true' Bool value, vice versa
        
    }
    
}
 


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
