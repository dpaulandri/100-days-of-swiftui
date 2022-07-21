//
//  ContentView.swift
//  Win Or Lose
//
//  Created by Paul Andri on 07/09/2022.
//
// Image Vector Attribution: Rock Paper Scissors Vectors by Vecteezy
// Link: https://www.vecteezy.com/free-vector/rock-paper-scissors

import SwiftUI

// View Modifiers for Title "Win or Lose"
struct TitleView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 50).weight(.heavy))
            .foregroundStyle(.primary)
            .shadow(radius: 5, x: 1, y: 10)
    }
}

// View Modifiers for 🤖 Emoji
struct EmojiView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(1)
            .font(.system(size: 80))
            .shadow(radius: 1, x: 0, y: 15)
    }
}

// View Modifier for 🤖 AI VStack
struct AIStack: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 80))
            .shadow(radius: 2, x: 0, y: 15)
    }
}

// View Modifier for Other Texts
struct InstructionView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .font(.title3.weight(.semibold))
            .foregroundStyle(.primary)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 6, x: 0, y: 10)
    }
}

// View Modifier for Move Selection 'HStack'
struct MoveSelection: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 110)
            .padding(10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 80))
            .shadow(radius: 2, x: 0, y: 15)
    }
}

// Extended all custom View Modifier Structs as the extension for 'View' Protocol
extension View {
    func titleStyle() -> some View {
        modifier(TitleView())
    }
    
    func emojiStyle() -> some View {
        modifier(EmojiView())
    }
    
    func instStyle() -> some View {
        modifier(InstructionView())
    }
    
    func selectionStyle() -> some View {
        modifier(MoveSelection())
    }
    
    func aiStyle() -> some View {
        modifier(AIStack())
    }
}

// Breaking up Image View into its View Struct + its View Modifiers
struct AvailableMoves: View {
    var moves: String
    
    var body: some View {
        Image(moves)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(radius: 1, x: 0, y: 10)
    }
}


struct ContentView: View {
    // Program State Property for showing round score alert
    @State private var showScore = false
    
    // Program State Property for whether 10 rounds of game has been run
    @State private var roundCompleted = false
    
    // Program State Property for game AI move
    @State private var aiMove = Int.random(in: 0...2)
    
    // Program State Property for whether user is supposed to Win OR Lose/Draw
    @State private var userToWin = Bool.random()
    
    // Program State Property for whether user DID WON a game round, regadless of 'userToWin' value
    @State private var UserDidWin = false
    
    // Program State Property for whether user is SUPPOSED OR NOT SUPPOSED TO WIN a game round
    @State private var roundResult = ""
    
    // Program State Property that will be added 1 everytime the user WIN/LOSE/DRAW as per 'userToWin' value
    @State private var scoreCount = 0
    
    // Program State Property that will be added 1 everytime a round is finished & the user tapped "Next Round" button
    @State private var roundCount = 1
    
    // Property to store available moves
    private let moves = ["rock", "paper", "scissor"]
    
    // Property to store the winning move that correspond to the Item Index of 'moves'
    private let winningMoves = ["paper", "scissor", "rock"]
    
    // Property to store 'Color' for use with 'ZStack's Linear Gradient
    private let color: [Color] = [.blue, .purple, .orange, .yellow, .white, .green, .red]
    
    
    var body: some View {
        
        // Main 'Stack' View
        ZStack {
            
            // 'LinearGradient' as app's background.
            // Uses random colors from 'color' Property for its gradient color choices
            LinearGradient(
                gradient: Gradient(colors: [color[Int.random(in: 0...6)], color[Int.random(in: 0...6)]]),
                startPoint: .topTrailing, endPoint: .bottomLeading
            ) .ignoresSafeArea()
            
            Spacer()
            
            // Outer 'VStack' View
            VStack {
                
                Spacer()
                
                // Main "VStack" View
                VStack {
                    
                    // Displaying 'roundCount' value w/ String Interpolation
                    Text("Round \(roundCount) / 10")
                        .instStyle()
                    
                    Spacer()
                    
                    // 'VStack' for AI Move
                    VStack {
                        VStack {
                            
                            Text("🤖")
                                .emojiStyle()
                            
                            // Displaying the choice of 'aiMove'
                            Image(moves[aiMove])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .emojiStyle()
                            
                        }
                        .aiStyle()
                        .padding()
                        
                    }
                    
                    
                    Spacer()
                    
                    // 'Stack' for Instruction & User Move choice input
                    VStack {
                        
                        Text("You have to: \(userToWin ? "WIN" : "LOSE / DRAW")")
                        .instStyle()
                        .padding()
                        
                        HStack {
                            ForEach(0..<3) { number in
                                Button {
                                    userMove(number)
                                } label: {
                                    AvailableMoves(moves: winningMoves[number])
                                }
                            }
                        }
                        .selectionStyle()
                    }
                    .padding()
                }
            }
            
            Spacer()
            
        }
        
        // Current Round Score Alert window
        // Triggered when the 'showScore' Program State is 'true' (after every round)
        .alert(roundResult, isPresented: $showScore) {
            // Call 'askQuestion' Method to store Program State changes & start new round
            Button("Next Round", action: askQuestion)
        } message: {
            // Conditional Summary Messages baed on whether the User DID/DID NOT follow the WIN / LOSE/ DRAW instruction
            if userToWin == UserDidWin {
                Text("""
                    You followed the instruction!
                    Current Score: \(scoreCount) / 10
                """) // Part of Challenge #1 Code
            } else {
                Text("""
                    You are supposed to \(userToWin ? "WIN" : "LOSE / DRAW")!
                    Current Score: \(scoreCount) / 10
                """)
            }
        }
        
        // Final Round Summary Alert window
        // Triggered when the 'roundCompleted' Program State is 'true' (after 10 rounds of game)
        .alert("Final Score", isPresented: $roundCompleted) {
            // Restart game by calling 'newRound' Method
            Button("New Game", action: newRound)
        } message: {
            // Conditional Summary Messages baed on the final value of 'scoreCount'
            switch scoreCount {
            case 0...2:
                Text("""
                Sorry!
                You've got \(scoreCount) / 10
                """)
            case 8...10:
                Text("""
                Great Job!
                You've got \(scoreCount) / 10
                """)
            default:
                Text("""
                Good Game!
                You've got \(scoreCount) / 10
                """)
            }
            
        }
        
    }
    
    
    // Method for to determine whether the user followed the instruction to WIN or LOSE/DRAW
    // Trigger everytime the user choose their move on either of the 3 available move choices
    func userMove(_ number: Int) {
        // Value depends whether the user chose the winning move
        UserDidWin = number == aiMove ? true : false
        // Value depending whether the user follow the instruction to WIN or LOSE/DRAW
        roundResult = UserDidWin == userToWin ? "Good job!" : "Oops!"
        // If the user followed the instruction to WIN or LOSE/DRAW
        if roundResult == "Good job!" { scoreCount += 1 }
        // Trigger the Round Score alert by changing the Program State of 'showScore'
        showScore = true
        
    }
    
    // Method for next game round
    // To be used w/ 'Next' Button on each Round Score alert window
    func askQuestion() {
        // Re-initialize the random Int value of 'aiMove' Property
        aiMove = Int.random(in: 0...2)
        // Re-initialize the random Bool value of 'userToWIn' Property
        userToWin = Bool.random()
        // userToWin.toggle() - Alternatively use this to toggle the value instead
        
        // Adding 1 to 'roundCount' as long as its value is less than 10
        if roundCount < 10 {
            roundCount += 1
        } else { // else, change the Program State of 'roundCompleted' to 'true'
            roundCompleted = true
        }
        
    }
    
    
    // Method to reset the game
    // To be used w/ 'New Game' Button in the Final Score Summary alert window
    func newRound() {
        // Reset 'roundCount' value to 1
        roundCount = 1
        // Reset 'scoreCount' value to 0
        scoreCount = 0
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
