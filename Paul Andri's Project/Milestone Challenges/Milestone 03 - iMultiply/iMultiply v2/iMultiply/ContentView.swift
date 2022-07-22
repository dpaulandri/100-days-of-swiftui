//
//  ContentView.swift
//  iMultiply
//
//  Created by Paul Andri on 07/21/2022.
//

import SwiftUI

// MAIN 'ContentView'
struct ContentView: View {
    
    // PROGRAM STATE FOR HOME SCREEN ANIMATION
    @State private var showHome = true
    
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
    
    
    // MAIN 'body' VIEW
    var body: some View {
        
        
        // MAIN ZSTACK VIEW
        ZStack {
            
            // BACKGROUND GRADIENT VIEW
            /*LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
             .ignoresSafeArea()*/
            VStack {
                Image("background-grass")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            
            
            
            
            // MAIN GAME CONTENT VSTACK
            VStack {
                // USER INPUT VSTACK
                if roundCount == 0 {
                    VStack {
                        
                        // TARGET MULTIPLICATION SECTION
                        Section {
                            VStack {
                                Text("✖️ iMultiply ✖️")
                                    .font(.largeTitle.weight(.heavy))
                                
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
                                    .shadow(radius: 2, x: 5, y: 5)
                                    
                                    Spacer()
                                    
                                    Text("\(targetNumber)")
                                        .font(.largeTitle.weight(.bold))
                                    
                                    Spacer()
                                    
                                    Button {
                                        if targetNumber < 12 {
                                            targetNumber += 1
                                        }
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                    }
                                    .shadow(radius: 2, x: 5, y: 5)
                                    
                                    Spacer()
                                }
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .padding()
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                        }
                        
                        
                        
                        // NUMBER OF ROUNDS PICKER SECTION
                        Section {
                            Picker("Number of rounds", selection: $numberOfRounds) {
                                ForEach(presetRound, id: \.self) {
                                    Text("\($0) rounds")
                                }
                            }
                            .pickerStyle(.segmented)
                            .shadow(radius: 4, x: 7, y: 7)
                            
                        }
                    }
                    // USER INPUT VSTACK MODIFIERS
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5, x: 5, y: 5)
                    .transition(.move(edge: .top))
                    
                    Spacer()
                    Spacer()
                    
                }
                
                
                // HOME SCREEN ANIMATION VIEW DEPENDING ON 'showHome' PROGRAM STATE
                if showHome {
                    
                    VStack {
                        Spacer()
                        Spacer()
                        HStack {
                            Spacer()
                            
                            Image("girl-cheer")
                                .resizable()
                                .scaledToFit()
                            
                            Image("boy-cheer")
                                .resizable()
                                .scaledToFit()
                            
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5, x: 5, y: 5)
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .slide))
                    
                }
                
                // CONDITONAL VIEWS DEPENDING ON 'showFinalScore' PROGRAM STATE
                if showFinalScore {
                    
                    // MAIN FINAL SCORE VSTACK VIEW
                    VStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            // CHARACTER IMAGE VIEW
                            switch currentScore {
                            case 0:
                                Image("girl-shock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            case numberOfRounds:
                                Image("girl-cheer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            default:
                                Image("boy-cheer")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            
                            Spacer()
                            Spacer()
                            
                            Text("Final Score")
                            Text("\(currentScore) / \(numberOfRounds)")
                            
                            Spacer()
                        }
                        .font(.largeTitle.weight(.heavy))
                        .foregroundColor(.white)
                        .shadow(radius: 5, x: 0, y: 10)
                        
                        Spacer()
                        
                    }
                    // FINAL SCORE VSTACK MODIFIERS
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(currentScore == 0 ? .red : .yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5, x: 5, y: 5)
                    
                    
                    
                } else {
                    
                    // SHOW THIS CONDITIONAL STACK IF 'showFinalScore' PROGRAM STATE IS FALSE
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
                            
                            // QUESTION / CURRENT SCORE VIEW SECTION
                            Section {
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    // CONDITIONAL VIEW DEPENDING ON 'showCurrentScore' PROGRAM STATE
                                    if showCurrentScore {
                                        if userWin {
                                            withAnimation {
                                                Text(answerResult)
                                            }
                                        } else {
                                            withAnimation {
                                                Text(answerResult)
                                            }
                                        }
                                        
                                    } else {
                                        // SHOW QUESTION VIEW IF 'showCurrentScore = false'
                                        Text("\(number1) x \(number2)")
                                    }
                                    Spacer()
                                }
                                // QUESTION / CURRENT SCORE HSTACK VIEW MODIFIERS
                                .font(.system(size: showCurrentScore ? 50 : 70).weight(.heavy))
                                .foregroundColor(showCurrentScore ? .white : .blue)
                                .frame(maxWidth: .infinity, maxHeight: 100)
                                .background(showCurrentScore ? (userWin ? .green : .red) : .white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 2, x: 0, y: 15)
                            }
                            
                            Spacer()
                            Spacer()
                            
                            // NEXT ROUND BUTTON / USER INPUT ANSWER BUTTONS SELECTION SECTION
                            Section {
                                HStack {
                                    
                                    // CONDITIONAL VIEW DEPENDING ON 'showCurrentScore' PROGRAM STATE
                                    if showCurrentScore {
                                        // SHOW BUTTON VIEW TO ADVANCE TO NEXT ROUND
                                        Button {
                                            roundComplete()
                                        } label: {
                                            Text(roundCount < numberOfRounds ? "NEXT" : "VIEW SCORE")
                                                .font(.system(
                                                    size: roundCount < numberOfRounds ? 50 : 35,
                                                    weight: .heavy)
                                                )
                                                .foregroundColor(.white)
                                        }
                                        
                                    } else {
                                        // SHOW USER INPUT ANSWER BUTTONS IF 'showCurrentScore = false'
                                        ForEach(0..<2) { number in
                                            Button {
                                                userAnswer(number)
                                            } label: {
                                                Text("\(availableAnswers[number])")
                                                    .font(.system(size: 50, weight: .heavy))
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        // BUTTONS VIEW MODIFIERS
                                        .frame(maxWidth: .infinity, maxHeight: 100)
                                        .padding()
                                        .background(.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 2, x: 0, y: 15)
                                        
                                    }
                                }
                                // BUTTON VIEWS MODIFIERS
                                .frame(maxWidth: .infinity, maxHeight: 150)
                                .background(.yellow)
                                .clipShape(RoundedRectangle(cornerRadius: 150))
                                .shadow(radius: 2, x: 0, y: 15)
                            }
                            
                            Spacer()
                            
                        }
                        // QUESTION / CURRENT SCORE & ANSWER INPUT VSTACK MODIFIERS
                        .padding(20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5, x: 5, y: 5)
                        .transition(.move(edge: .bottom))
                    }
                    
                }
                
                
                Spacer()
                
                
                // HOME/QUIT/START/RESTART BUTTONS SECTION
                Section {
                    HStack {
                        
                        // CONDTIONAL VIEW DEPENDING ON 'roundCount' PROGRAM STATE
                        if roundCount == 0 {
                            // 'HOME' BUTTON VIEW
                            Button {
                                // TRIGGERS "EXPLICIT ANIMATION"
                                withAnimation(.easeOut(duration: 0.1)) {
                                    roundCount = 0
                                    showHome = true
                                }
                            } label: {
                                Label("HOME", systemImage: "house")
                            }
                            // 'HOME' BUTTON VIEW MODIFIERS
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        } else {
                            // 'QUIT' BUTTON VIEW IF 'roundCount != 0'
                            Button {
                                // TRIGGERS "EXPLICIT ANIMATION"
                                withAnimation(.easeOut(duration: 0.1)) {
                                    roundCount = 0
                                    showHome = true
                                    showFinalScore = false
                                }
                            } label: {
                                Label("QUIT", systemImage: "house")
                            }
                            // 'QUIT' BUTTON VIEW MODIFIERS
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Spacer()
                        
                        // CONDTIONAL VIEW DEPENDING ON 'roundCount' PROGRAM STATE
                        if roundCount == 0 {
                            // 'START' BUTTON VIEW IF 'roundCount == 0'
                            Button {
                                // TRIGGERS "EXPLICIT ANIMATION"
                                withAnimation(.easeIn(duration: 0.1)) {
                                    newGame()
                                    showHome = false
                                }
                            } label: {
                                Label("START", systemImage: "gamecontroller.fill")
                            }
                            // 'START' BUTTON VIEW MODIFIERS
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        } else if showFinalScore {
                            // 'QUIT' BUTTON VIEW IF 'showFinalScore = true'
                            Button {
                                // TRIGGERS "EXPLICIT ANIMATION"
                                withAnimation(.easeIn(duration: 0.1)) {
                                    newGame()
                                    roundCount = 1
                                    showFinalScore = false
                                }
                            } label: {
                                Label("PLAY AGAIN", systemImage: "gamecontroller.fill")
                            }
                            // 'QUIT' BUTTON VIEW MODIFIERS
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        } else {
                            // IF NOT, SHOW 'RESTART' BUTTON VIEW
                            Button {
                                newGame()
                            } label: {
                                Label("RESTART", systemImage: "gamecontroller.fill")
                            }
                            // 'RESTART' BUTTON VIEW MODIFIER
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .font(.body.weight(.bold))
                            .foregroundColor(.white)
                            .background(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }
                    // HOME/QUIT/START/RESTART BUTTONS HSTACK VIEW MODIFIER
                    //.padding()
                    .shadow(radius: 5, x: 10, y: 10)
                    
                }
                
            }
            // MAIN GAME CONTENT VSTACK MODIFIER
            .padding()
            
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
        // RESET 'showCurrentScore' PROGRAM STATE
        showCurrentScore = false
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
        showFinalScore = false
        showCurrentScore = false
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


// APP PREVIEW VIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
