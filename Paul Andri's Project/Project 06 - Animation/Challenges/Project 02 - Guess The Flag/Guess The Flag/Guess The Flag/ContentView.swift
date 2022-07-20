//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Paul Andri on 07/07/2022.
//

import SwiftUI

// CODE PART OF DAY 24 - CHALLENGE #2
// CREATE A NEW VIEW STRUCT
struct FlagImage: View {
    var countries: String
    
    var body: some View {
        Image(countries)
        // 'Image' View Modifier - make SwiftUI render the Image as is
            .renderingMode(.original)
        
        // View Modifier - add Shadow fx to a View
        // We can also specifiy the 'color', default is translucent black
            .shadow(radius: 10, x: 5, y: 5)
        
    }
    
}

struct ContentView: View {
    // A Program State Variable Property to determine whether the alert window is currently shown
    @State private var showScore = false
    
    // Part of Challenge #3 Code
    // A Program State Variable Property to determine whether 8 rounds of game has been Completed
    @State private var roundCompleted = false
    
    // A Program State Variable Property to store the message that will be shown in the alert window
    @State private var scoreResult = ""
    
    // Part of Challenge #1 Code
    // A Program State Variable Property to store the Int value for correct score count
    @State private var scoreCount = 0
    
    // PART OF DAY 34 - CHALLENGE #2
    // A Program State Variable Property to store Bool value whether the user has tapped a Flag
    @State private var userTapped = false
    
    // Part of Challenge #2 Code
    // A Program State Variable Property to store the Int value for User chosen Flag Button
    @State private var chosenFlag = 0
    
    // Part of Challenge #3 Code
    // A Program State Variable Property to store the Int value for how many round the game has ran for
    @State private var roundCount = 1   // Initial Round counted as 1
    
    // PART OF DAY 34 - CHALLENGE #1
    // // A Program State Variable Property to store 'Double' value for 'rotation3DEffect' 'degree
    @State private var rotateDegree = 0.0
    
    // A Program State Variable Property to store Country names in an Array
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
    ].shuffled()
    // 'shuffled' - Shuffle the Array items on each run
    
    // A Program State Variable Property w/ randomised Int value
    // For use w/ 'countries' to randomise the correct answer
    @State private var correctFlag = Int.random(in: 0...2)
    
    
    var body: some View {
        
        // Main View is a ZStack (Depth) to allow customisation of View's depth appearances, etc
        ZStack {
            // A 'LinearGradient' colour as our background (the back layer)
            LinearGradient(
                gradient: Gradient(colors: [.purple, .yellow]),
                startPoint: .topTrailing, endPoint: .bottomLeading
            )
                // View Modifier to fill the entire iDevice screen, incl. safe areas
                .ignoresSafeArea()
            
            
            VStack {
                // Add a Spacer to the top of VStack View
                Spacer()
                
                //Create a Text View Title
                Text("Guess The Flag")
                    // 'font' Modifier for our Text View
                    .font(.largeTitle.bold())
                    // 'foregroundColor' Modifier for our Text View
                    .foregroundColor(.white)
                    .shadow(radius: 2, x: 5, y: 5)
                
                
                // VStack for the Content Group
                VStack(spacing: 15) {
                    VStack {
                        // This Text View will react & adjust to Light/Dark Mode
                        Text("The Flag of")
                        // 'foregroundColor' Modifier for our Text View
                            .foregroundStyle(.secondary)
                        // 'font' Modifier for our Text View
                            .font(.subheadline.weight(.semibold))
                        
                        // This Text View will react & adjust to Light/Dark Mode
                        Text(countries[correctFlag])
                            .font(.largeTitle.bold()) // 'font' Modifier for our Text View
                        // 'largeTitle' is the largest built-in iOS font size
                    }
                    
                    
                    // Create 3 Buttons w/ randomised value from 'countries' Array Property
                    ForEach(0..<3) { number in
                        Button {
                            // Call Method whenever the Button is tapped
                            flagTapped(number)
                            
                            // PART OF DAY 34 - CHALLENGE #1
                            // TRIGGER "EXPLICIT ANIMATION" ON 'rotateDegree' PROGRAM STATE CHANGE
                            // TIED W/ 'rotation3DEffect' FX MODIFIER 'degrees' VALUE
                            // ONLY TAPPED FLAG BUTTON WILL HAVE ANIMATION
                            withAnimation {
                                // PART OF DAY 34 - CHALLENGE #1
                                // Add 360 to 'rotateDegree' Program State value on each Tap
                                rotateDegree += 360
                                
                                // PART OF DAY 34 - CHALLENGE #2
                                // TOGGLE 'userTapped' PROGRAM STATE
                                userTapped.toggle()
                            }
                            
                        } label: {
                            // CODE PART OF DAY 24 - CHALLENGE #2
                            FlagImage(countries: countries[number])
                        }
                        
                        // PART OF DAY 34 - CHALLENGE #1
                        // 3D ROTATION FX MODIFIER
                            .rotation3DEffect(
                                // 'degrees' value depends on whether the Flag View is tapped
                                // ONLY TAPPED FLAG BUTTON WILL ROTATE
                                .degrees(chosenFlag == number ? rotateDegree : 0),
                                // ROTATE ON 'Y' AXIS (HORIZONTAL)
                                axis: (x:0, y:1 , z:0)
                            )
                        
                        // PART OF DAY 34 - CHALLENGE #2
                        // CHANGE OPACITY OF UNTAPPED FLAGS TO 25% OPACITY
                            .opacity(userTapped ? (chosenFlag == number ? 1 : 0.25) : 1)
                        
                        // PART OF DAY 34 - CHALLENGE #2
                        // BLUR FX FOR UNTAPPED FLAGS
                            .blur(radius: userTapped ? (chosenFlag == number ? 0 : 5) : 0)
                        
                    }
                    
                    
                }
                // Modifiers for 'ZStack'
                // Width of the ZStack View is set to stretch to infinity
                .frame(maxWidth: .infinity)
                // Add a Vertical padding of 20pt to the ZStack View
                .padding(.vertical, 20)
                // Use a "Material" type as the background of ZStack View
                .background(.thinMaterial)
                // Add 'clipShape' modifier to ZStack View
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                // Add 2 Spacers
                Spacer()
                Spacer()
                
                
                // Part of Challenge #1 Code
                // Add a Text View showing the 'scoreResult' Prop value
                Text("Score: \(scoreCount) / 8")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .shadow(radius: 3, x: 5, y: 5)
                
                
                // Add a Spacer
                Spacer()
                
            }
            .padding()  // Add a Padding
            
        }
        // '.alert' placed AFTER the Main ZStack View
        
        // Use 'scoreResult' value as the Alert Title
        .alert(scoreResult, isPresented: $showScore) {
            Button("OK", action: askQuestion)
        } message: {    // Display this message in the alert window
            if scoreResult == "Correct" {
                Text("""
                    This is the Flag of \(countries[correctFlag])
                    Current Score: \(scoreCount) / 8
                """) // Part of Challenge #1 Code
            } else {
                Text("""
                    That is the Flag of \(countries[chosenFlag])
                    Current Score: \(scoreCount) / 8
                """) // Part of Challenge #2 Code
            }
        }
        
        
        // Part of Challenge #3 Code
        // Give a Final Score summary & Option to Play again after 8 rounds of game
        // Had to place this in the 2nd Position in order for it to be triggered if game has finished its 8th round
        .alert("Final Score", isPresented: $roundCompleted) {
            Button("Play Again", action: newRound) // call 'newRound' Property to reset game values
        } message: {
            switch scoreCount {
            case 0:
                Text("""
                Sorry!
                You've got \(scoreCount) / 8
                """)
            case 8:
                Text("""
                Great Job!
                You've got \(scoreCount) / 8
                """)
            default:
                Text("""
                Good Game!
                You've got \(scoreCount) / 8
                """)
            }
            
        }
        
    }
    
    
    // Method to use w/ Flag 'Button' - execute whenever any Flag "Button" is pressed
    func flagTapped(_ number: Int) {
        // Using Ternary Optional Operator to set the value for 'scoreResult' Program State Property
        scoreResult = number == correctFlag ? "Correct" : "Incorrect"
        
        // Assign 'true' to 'showScore' Program State Property, which will trigger the alert window
        showScore = true
        
        // Part of Challenge #1 Code
        // 'if' Statement to increase value for 'scoreCount' Program State Property
        if number == correctFlag {
            scoreCount += 1
        }
        
        // Part of Challenge #2 Code
        // Assign 'number' value as User 'chosenFlag' Program State Property
        chosenFlag = number
    }
    
    
    // Method to use w/ "Play Again" 'Button' in the Alert window
    func askQuestion() {
        // Shuffle the 'countries' Array Items
        countries = countries.shuffled()
        
        // Randomise the 'correctFlag' Int value
        correctFlag = Int.random(in: 0...2)
        
        // Part of Challenge #3 Code
        // Assign increase value for 'roundCount' Program State Property after each round of game
        if roundCount < 8 { // Increase value ONLY IF 'roundCount' value is < 8
            roundCount += 1
        } else { // If 'roundCount' = 8 (8 rounds of Game has been completed)
            roundCompleted = true   // Set 'roundCompleted' value to 'true', triggers "Final Score" Alert
        }
        
        // PART OF DAY 34 - CHALLENGE #2
        // Set 'userTapped' back to 'false' on New Round
        userTapped = false
    }
    
    
    // Part of Challenge #3 Code
    // Method to use w/ "Play Again" 'Button' in the "Final Score" Alert window
    func newRound() {
        roundCount = 1  // Reset value to 1
        scoreCount = 0  // Reset value to 0
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
