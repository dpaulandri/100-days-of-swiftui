//
//  ContentView.swift
//  iMultiply
//
//  Created by Paul Andri on 07/21/2022.
//

import SwiftUI

struct ContentView: View {
    
    // PROGRAM STATE FOR THE FINAL GAME SCORE ALERT WINDOW
    @State private var showFinalScore = false
    
    // PROGRAM STATE FOR THE CURRENT GAME SCORE ALERT WINDOW
    @State private var showCurrentScore = false
    
    // PROGRAM STATE OF WHETHER THE USER ANSWERED CORRECTLY
    @State private var userWin = false
    
    // PROGRAM STATE PROPERTY THAT STRING VALUE BASED ON 'userWin' PROGRAM STATE
    @State private var answerResult = ""
    
    // PROGRAM STATE PROPERTY THAT STORE USER-DEFINED NUMBER OF ROUNDS
    @State private var numberOfRounds = 5
    
    // PROGRAM STATE PROPERTY THAT STORE CURRENT ROUND NUMBER
    @State private var roundCount = 0
    
    // PROGRAM STATE PROPERTY THAT STORE CURRENT SCORE VALUE
    @State private var currentScore = 0
    
    // PROGRAM STATE PROPETY THAT STORE THE USER-DEFINED TARGET MULTIPLICATION NUMBER
    @State private var targetNumber = 3
    
    // PROGRAM STATE PROPERTIES THAT STORE USER 'targetNumber' value
    @State private var number1 = 0
    // PROGRAM STATE PROPERTIES THAT STORE THE RANDOM MULTIPLICATION NUMBER
    @State private var number2 = 0
    
    // PROGRAM STATE PROPERTIES THAT STORE THE CORRECT MULTIPLICATION ANSWER OF 'number1 * number2'
    @State private var correctAnswer = 0
    
    // PROGRAM STATE PROPERTIES THAT STORE RANDOMISED AVAILABLE ANSWER CHOICES
    @State private var availableAnswers = [0, 1]
    
    // PROPERTY THAT STORE AN ARRAY OF INT VALUE FOR NUMBER OF ROUND CHOICES
    let presetRound = [5, 10, 20]

    
    
    var body: some View {
        
        // MAIN ZSTACK VIEW
        ZStack {
            
            // BACKGROUND GRADIENT VIEW
            LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // MAIN GAME CONTENT VSTACK
            VStack {
                // USER INPUT VSTACK
                VStack {
                    
                    // TARGET MULTIPLICATION SECTION
                    Section {
                        VStack {
                            Text("✖️ iMultiply ✖️")
                                .font(.largeTitle.weight(.heavy))
                                .shadow(radius: 5, x: 5, y: 5)
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Button {
                                    if targetNumber > 0 {
                                        targetNumber -= 1
                                    }
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                }
                                
                                Spacer()
                                Text("\(targetNumber)")
                                Spacer()
                                
                                Button {
                                    if targetNumber < 12 {
                                        targetNumber += 1
                                    }
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                }
                                
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .padding()
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .shadow(radius: 5, x: 5, y: 5)
                    }
                    
                    
                    // NUMBER OF ROUNDS PICKER SECTION
                    Section {
                        Picker("Number of rounds", selection: $numberOfRounds) {
                            ForEach(presetRound, id: \.self) {
                                Text("\($0) rounds")
                                    
                            }
                        }
                        .pickerStyle(.segmented)
                        .shadow(radius: 5, x: 5, y: 5)

                    }
                }
                // USER INPUT VSTACK MODIFIERS
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5, x: 5, y: 5)
                    
                
                Spacer()
                Spacer()
                
                
                
                // QUESTION & ANSWER INPUT VSTACK
                // THIS VSTACK VIEW WILL ONLY BE SHOWN IF 'roundCount != 0' (WHEN USER TAPPED 'START' / 'RESTART' BUTTON)
                if roundCount != 0 {
                    VStack {
                        // ROUND / SCORE DISPLAY
                        Section {
                            HStack {
                                VStack{
                                    Text(roundCount > 0 ? "Round \(roundCount) / \(numberOfRounds)" : "")
                                }
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .background(.blue)
                                
                                Spacer()
                                
                                VStack {
                                    Text(roundCount > 0 ? "Score: \(currentScore)" : "")
                                }
                                .frame(maxWidth: .infinity, maxHeight: 40)
                                .background(.blue)
                                
                            }
                            .padding(10)
                            .font(.title3.weight(.bold))
                            .foregroundColor(.white)
                            .shadow(radius: 5, x: 0, y: 7)
                            
                        }
                        
                        Spacer()
                        
                        // QUESTION DISPLAY
                        Section {
                            HStack {
                                    HStack {
                                        Spacer()
                                        Text("\(number1) x \(number2)")
                                            .font(.system(size: 50).weight(.heavy))
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                                    .background(.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 2, x: 0, y: 15)
                            }
                            
                        }
                        
                        Spacer()
                        Spacer()
                        
                        // USER BUTTONS SELECTION SECTION
                        Section {
                                HStack {
                                    ForEach(0..<2) { number in
                                        Button {
                                            userAnswer(number)
                                        } label: {
                                            Text("\(availableAnswers[number])")
                                                .font(.system(size: 50, weight: .heavy))
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                                    .padding()
                                    .background(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 2, x: 0, y: 15)
                                }
                                .frame(maxWidth: .infinity, maxHeight: 150)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 165))
                                .shadow(radius: 2, x: 0, y: 15)
                        }
                        Spacer()
                        Spacer()
                    }
                    // QUESTION & ANSWER INPUT VSTACK MODIFIERS
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        LinearGradient(
                            colors: [.blue, .white],
                            startPoint: .bottom, endPoint: .topTrailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5, x: 5, y: 5)
                }
                
                
                Spacer()
                
                
                // HOME/START/RESTART BUTTON VSTACK
                VStack {
                    Section {
                        HStack {
                            Button {
                                // TRIGGERS "EXPLICIT ANIMATION"
                                withAnimation(.easeOut(duration: 0.3)) {
                                    roundCount = 0
                                }
                            } label: {
                                Label("HOME", systemImage: "house")
                            }
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Spacer()
                            
                            if roundCount == 0 {
                                Button {
                                    // TRIGGERS "EXPLICIT ANIMATION"
                                    withAnimation(.easeIn(duration: 0.2)) {
                                        newGame()
                                    }
                                } label: {
                                    Label("START", systemImage: "gamecontroller.fill")
                                }
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .font(.body.weight(.bold))
                                .foregroundColor(.white)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            } else {
                                Button {
                                    // TRIGGERS "EXPLICIT ANIMATION"
                                    withAnimation(.interpolatingSpring(stiffness: 50, damping: 6)) {
                                        newGame()
                                    }
                                } label: {
                                    Label("RESTART", systemImage: "gamecontroller.fill")
                                }
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .font(.body.weight(.bold))
                                .foregroundColor(.white)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }

                        }
                        // HSTACK VIEW MODIFIER
                        .shadow(radius: 2, x: 5, y: 5)
                    }
                }
            }
            // MAIN GAME CONTENT VSTACK MODIFIER
            .padding(20)
        }
        // MAIN ZSTACK VIEW MODIFIERS
        
        // ALERT WINDOW MOIFIERS
        // CURRENT ROUND SCORE ALERT WINDOW
        .alert(answerResult, isPresented: $showCurrentScore) {
            Button("Next Round", action: roundComplete)
        } message: {
                Text("\(number1) x \(number2) = \(correctAnswer)")
        }
        
        
        // FINAL SCORE SUMMARY ALERT WINDOW
        .alert("Final Score", isPresented: $showFinalScore) {
            Button("New Game", action: newGame)
        } message: {
            switch currentScore {
            case 0:
                Text("""
                Sorry!
                You've scored \(currentScore) / \(numberOfRounds)
                """)
            default:
                Text("Your final score is \(currentScore) / \(numberOfRounds)")
            }
        }

    }
    
    
    // METHOD TO GENERATE RANDOM MULTIPLICATION QUESTIONS & ANSWER BASED ON USER-INPUT DATAS
    func userAnswer(_ number: Int) {
        // CHECK WHETHER THE USER'S ANSWER IS CORRECT
        userWin = availableAnswers[number] == correctAnswer ? true : false
        // SET VALUE OF 'answerResult' BASED UPON THE PROGRAM STATE OF 'userWin'
        answerResult = userWin ? "Great job!" : "Oops!"
        // ADD 1 TO 'currentScore' PROPERTY IF 'userWin' STATE IS 'true'
        if userWin { currentScore += 1 }
        // TRIGGERS CURRENT SCORE ALERT WINDOW AFTER EACH ROUND
        showCurrentScore = true
    }
    
    
    // METHOD TO ADVANCE TO NEXT ROUND
    func roundComplete() {
        // SET A RANDOM INT VALUE FOR 'number2'
        number2 = Int.random(in: 1...12)
        // SET CORRECT ANSWER VALUE
        correctAnswer = number1 * number2
        // SET MEW VALUE TO 'availableAnswers' ARROW & SHUFFLE THE ARRAY ITEMS
        availableAnswers = [
            (Int.random(in: 1...12) * Int.random(in: 1...12)),
            (number1 * number2)
        ].shuffled()
        
        if roundCount < numberOfRounds {
            // ADD 1 TO 'roundCount' PROPERTY IF 'roundCount < numberOfRounds'
            roundCount += 1
        } else {
            // ELSE TRIGGE FINAL SUMMARY SCORE ALERT WINDOW
            showFinalScore = true
        }
    }
    
    
    // METHOD TO START/RESTART NEW GAME
    func newGame() {
        // RESET PROPERTY VALUE TO DEFAULT FOR NEW GAME
        roundCount = 1
        currentScore = 0
        answerResult = ""
        userWin = false
        
        // SET 'targetNumber' VALUE AS 'number1' PROPERTY VALUE
        number1 = targetNumber
        // SET A RANDOM INT VALUE FOR 'number2'
        number2 = Int.random(in: 1...12)
        // SET CORRECT ANSWER VALUE
        correctAnswer = number1 * number2
        // SET MEW VALUE TO 'availableAnswers' ARROW & SHUFFLE THE ARRAY ITEMS
        availableAnswers = [
            (Int.random(in: 1...12) * Int.random(in: 1...12)),
            (number1 * number2)
        ].shuffled()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
