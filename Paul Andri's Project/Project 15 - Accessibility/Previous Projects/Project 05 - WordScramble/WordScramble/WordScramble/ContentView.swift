//
//  ContentView.swift
//  WordScramble
//
//  Created by Paul Andri on 07/16/2022.
//
// DAY 75 - ADD ACCESSIBILITY FUNCTIONS

import SwiftUI

struct ContentView: View {
    // Program State Property storing a 'String' Array of used/entered words
    @State private var usedWords = [String]()
    
    // Program State Property storing "root word" 'String' value of an 8-letter word
    @State private var rootWord = ""
    
    // Program State Property storing 'String' value from user input
    @State private var userInput = ""
    
    
    // PROGRAM STATE PROPERTIES FOR 'UITextChecker' ALERT WINDOW
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showErrorAlert = false
    
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                // User Word Input Section
                Section("ENTER A WORD") {
                    TextField("Enter a word", text: $userInput)
                    // Disable letter auto-capitalisation on user input's keyboard
                    // Disabled to maintain uniformity w/ 'addNewWord' Method
                        .autocapitalization(.none)
					// DAY 75:
					/// 1. IGNORE ELEMENT FROM VOICEOVER
					.accessibilityElement()
					/// 2. ADD CUSTOM ACCESSIBILITY LABEL FOR VOICEOVER
					.accessibilityLabel("Word Input text field")
                }
                
                
                // PART OF DAY 31 CHALLENGE #3 CODE
                // Section to display current Score
                Section("CURRENT SCORE") {
                    Text("\(usedWords.count)")
                }
				// DAY 75: REMOVE HEADER TRAIT FROM SECTION
				.accessibilityRemoveTraits(.isHeader)
                
                
                // Section to display the 'String' Array content from 'userWords'
                Section("ENTERED WORDS") {
                    
                    // Generate Row dynamically from the items in 'usedWords' Array
                    ForEach(usedWords, id: \.self) { word in
                        
                        // HStack View on each dynamically generated row
                        HStack {
                            
                            // Image View with Int value from 'word.count' encricled
                            Image(systemName: "\(word.count).circle")
                            
                            // Text View from 'word' value
                            Text(word)
                            
                        }
						// DAY 75:
						/// 1. GROUP & IGNORE THE HSTACK VIEW ELEMENTS FROM VOICEOVER
						.accessibilityElement()
						/// 2. SET CUSTOM ACCESSIBILITY LABEL THAT MAKE SENSE AS A SPOKEN SENTENCE
						.accessibilityLabel("\(word), \(word.count) letters")
                        
						// ALTERNATIVE VERSION:
						/*
						/// 1. IGNORE CHILD ELEMENTS FROM VOICEOVER
						.accessibilityElement(children: .ignore)
						/// 2. SET CUSTOM ACCESSIBILITY LABEL
						.accessibilityLabel(word)
						/// 3. ADD HINT THAT WILL BE READ AFTER A SLIGHT PAUSE FOLLOWING THE LABEL
						.accessibilityHint("\(word.count) letters")
						*/
                    }
                }

                
            }
            
            // Use the 'String' value from 'rootWord' as the title for the NavigationView
            .navigationTitle(rootWord)
            
            // 'onSubmit' - run a code / Method when the user submit their input
            // Call 'addNewWord' Method when the user submit its word input
            .onSubmit(addNewWord)
            
            
            // 'onAppear(perform: )' - run specific code / Method when the 'List' View is shown
            // Call 'startGame' Method when the 'List' View is shown
            .onAppear(perform: startGame)
            
            
            // Alert Window Modifier
            .alert(errorTitle, isPresented: $showErrorAlert) {
                // An "OK" button with "cancel" role
                Button("OK", role: .cancel) { }
            } message: {
                // Use 'errorMessage' String value as the Alert Window Message
                Text(errorMessage)
            }
            
            // PART OF DAY 31 CHALLENGE #2 CODE
            // Add a Toolbar Button that calls 'startGame' Method to get a new 'rootWord' value
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("New Word", action: startGame)
                }
                
            }
            
        }
        
    }
    
    
    
    // Method to add new words from User Input
    func addNewWord() {
        
        // TREATING THE INPUT 'String' VALUE
        // Lower-cased the 'String' value from 'userInput' & remove any whitespace
        let inputWord = userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        // GAME RULE VALIDATIONS
        
        // CHECK #1
        // Check & validate that there're at least one character in 'inputWord'
        guard inputWord.count > 0 else { return }
        // 'return' if 'inputWord.count > 0' is false
        
        // CHECK #2
        //METHOD 1 - Check whether a word has been entered/used before
        guard isNewWord(word: inputWord) else {
            // METHOD 4 - Setting values for the Alert Window Program State Properties
            errorFound(title: "Repeated Word", message: "\(inputWord) has been used!")
            
            return
        }
        
        // CHECK #3
        // METHOD 2 - Check whether the user input word is made up of the letters from 'rootWord' value
        guard isPossible(word: inputWord) else {
            errorFound(title: "Invalid Word", message: "Can't make \"\(inputWord)\" from \"\(rootWord)\"")
            
            return
        }
        
        // CHECK #4
        // METHOD 3 - Use 'UITextChecker' to check whether the input word is a valid word & NOT MISPELLED
        guard isValidAndCorrect(word: inputWord) else {
            errorFound(title: "Invalid Word", message: "\"\(inputWord)\" is not a valid English word!")
            
            return
        }
        
        
        // PART OF DAY 31 CHALLENGE #1 CODE
        // CHECK #5
        // METHOD 5 - Check whether the input word is less than 3 letters
        guard tooShort(word: inputWord) else {
            errorFound(title: "Too Short", message: "Please input at least 3 letters!")
            
            return
        }
        
        
        // PART OF DAY 31 CHALLENGE #1 CODE
        // CHECK #6
        // METHOD 6 - Check whether the input word is the same as our 'rootWord'
        guard notSameAsRootWord(word: inputWord) else {
            errorFound(title: "Be Creative", message: "Don't input the Root Word!")
            
            return
        }
        
        
        
        
        // THE CODE BELOW WON'T RUN IF ANY OF THE GAME VALIDATIONS ABOVE HAS FAILED
        
        // 'withAnimation' - add animation when the body code is run
        withAnimation {
            // Insert the validated 'inputWord' value into 'usedWords' 'String' Array at Index position 0
            // Index Position '0' so the new added words will the show at the very top of the list
            usedWords.insert(inputWord, at: 0)
        }
            
        // Reset the 'userInput' value to "Empty String"
        userInput = ""
        
    }
    
    
    // Method to get a random word from '8letterword.txt' to start the Game
    func startGame() {
        
        // Unwrap Optional 'URL?' value for '8letterword.txt' file in our main App bundle
        if let wordBankURL = Bundle.main.url(forResource: "8letterword", withExtension: "txt") {
            
            // Execute code below if 'URL?' is SUCCESSFULLY UNWRAPPED
            // Try to throw a single 'String' value from 'wordBankURL' content
            if let allWords = try? String(contentsOf: wordBankURL) {
                
                // Execute code below if 'String' value is SUCCESSFULLY THROWN from 'wordBankURL' content
                // Create an Array by separating the single 'String' value from 'allWords' by New Lines
                let wordBank = allWords.components(separatedBy: "\n")
                
                // Set rootWord Property value into a random Element from 'wordBank' Array
                // Would return an Optional 'String?', use '??' to provide a default value
                rootWord = wordBank.randomElement() ?? "silkworm"
                
                // PART OF DAY 31 CHALLENGE #3 CODE
                // Reset usedWords as an Empty String Array
                usedWords = [String]()
                
                return
                
            }
        }
        
        // This code will be executed if the Unwrapping Optional has FAILED for whatever reason
        // Theoritically it should never happen
        fatalError("Could not load '8letterword.txt' from Bundle")
        // The text will be printed in our Xcode Debugging console
        
    }
    
    
    
    // 4 METHODS FOR THE GAME's USER INPUT WORDS VALIDATION!
    
    // METHOD 1 - Check whether a word has been entered/used before
    // Accept a 'String' input Parameter & returns a 'Bool' value
    func isNewWord(word: String) -> Bool {
        
        // Check whether 'word' value is NOT '!' found inside 'usedWords' Array
        !usedWords.contains(word)
        
    }
    
    // METHOD 2 - Check whether the user input word is made up of the letters from 'rootWord' value
    // Accept a 'String' input Parameter & returns a 'Bool' value
    func isPossible(word: String) -> Bool {
        // Create a new 'var' by copying the value from 'rootWord'
        var tempWord = rootWord
        
        // 'for' Loop for every 'letter' in 'word'
        for letter in word {
            
            // Unwrap Optional 'String.Index?'  alue for each letter in 'tempWord'
            if let position = tempWord.firstIndex(of: letter) {
                // Run this if the UNWRAPPING IS SUCCESFFULE
                // remove the letter at 'String.Index' from 'position'
                tempWord.remove(at: position)
                
            } else {
                // Run this if the UNWRAPPING IS SUCCESFFULE
                // Return 'false' to the Method
                return false
            }
            
        }
        
        // IF THE VALIDATION IS ALL GOOD
        // Return 'true' to the Method
        return true
        
    }
    
    // METHOD 3 - Use 'UITextChecker' to check whether the input word is a valid word & NOT MISPELLED
    func isValidAndCorrect(word: String) -> Bool {
        
        // Create an Instance of 'UITextChecker'
        let checker = UITextChecker()
        
        // Set the 'Objective-C' 'NSRange' to bridge with Swift's 'utf16' character
        // 'location: 0': At the start position
        let range = NSRange(location: 0, length: word.utf16.count)
        
        // Create an 'checker' Instance to check for 'rangeOfMisspelledWord'
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,   // in 'word' character
            range: range,   // range from 'range' value
            startingAt: 0,  // Starting at the start position
            wrap: false,    // DO NOT WRAP the checker
            language: "en"  // Use "en" - English Dictionary to check the word against
        )
        
        // Return the 'Bool' value of the statement below
        // Statement read nothing misspelled character location is found
        return misspelledRange.location == NSNotFound
        
    }
    
    // METHOD 4 - Setting values for the Alert Window Program State Properties
    func errorFound(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showErrorAlert = true
    }
    
    
    // PART OF DAY 31 CHALLENGE #1 CODE
    // METHOD 5 - Check whether the input word is less than 3 letters
    func tooShort(word: String) -> Bool {
        word.count > 2
    }
    
    // PART OF DAY 31 CHALLENGE #1 CODE
    // METHOD 6 - Check whether the input word is the same as our 'rootWord'
    func notSameAsRootWord(word: String) -> Bool {
        word != rootWord
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
