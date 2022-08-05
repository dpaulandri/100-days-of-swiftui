//
//  ContentView.swift
//  Drawing Challenge
//
//  Created by Paul Andri on 08/05/2022.
//

// DAY46 - DRAWING CHALLENGES

import SwiftUI

// CHALLENGE #1 & #2
// CHALLENGE #1 - CREATE AN "ARROW" SHAPE
// CHALLNEGE #2 - MAKE THE LINE THICKNESS OF ARROW SHAPE ANIMATABLE
/*
// ARROW SHAPE VIEW STRUCT
struct Arrow: Shape {
    // PART OF CHALLENGE #2 CODE
    // PROPERTY TO STORE THE VALUE THAT WILL AFFECT THE THICKEN OF THE ARROW BODY LINE
    var arrowThickness: Double
    
    // PART OF CHALLENGE #2 CODE
    // 'animatableData' COMPUTED PROPERTY
    // REQUIRED TO MAKE ANIMATING CHANGES IN SHAPE POSSIBLE
    // USE IN CONJUNCTION W/ 'withAnimation'
    var animatableData: Double {
        // READ PROPERTY VALUE
        get { arrowThickness }
        // WRITE 'newValue' VALUE TO PROPERTY
        set { arrowThickness = newValue} // 'newValue' IS AVAILABLE FOR 'set'
    }
    
    
    // METHOD TO CREATE ARROW SHAPE PATHS
    func path(in rect: CGRect) -> Path {
        // PATH PROPERTY TO RETURN
        var path = Path()
        
        // PATH'S STARTING POINT (MIDDLE OF THE "RECTANGLE SHAPE"
        path.move(to: CGPoint(x:rect.midX, y: rect.minY)) // 'rect' = RECTANGLE
        // 1st LINE DRAWN FROM PATH'S STARTING POINT
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        // 2nd LINE DRAWN FROM PATH'S 1st LINE POINT
        path.addLine(to: CGPoint(x: rect.midX / arrowThickness, y: rect.midY))
        // 3rd LINE DRAWN FROM PATH'S 2nd LINE POINT
        path.addLine(to: CGPoint(x: rect.midX / arrowThickness, y: rect.maxY))
        // 4th LINE DRAWN FROM PATH'S 3rd LINE POINT
        path.addLine(to: CGPoint(x: rect.maxX - (rect.maxX / (arrowThickness * 2)), y: rect.maxY))
        // 5th LINE DRAWN FROM PATH'S 4th LINE POINT
        path.addLine(to: CGPoint(x: rect.maxX - (rect.maxX / (arrowThickness * 2)), y: rect.midY))
        // 6th LINE DRAWN FROM PATH'S 5th LINE POINT
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        // 7th LINE DRAWN FROM PATH'S 6th LINE POINT (CLOSE THE SHAPE)
        path.addLine(to: CGPoint(x:rect.midX, y: rect.minY))

        // RETURN 'path' VALUE TO METHOD
        return path
    }
}

struct ContentView: View {
    // PART OF CHALLENGE #2 CODE
    // STATE PROPERTY TO STORE THE VALUE THAT WILL AFFECT THE THICKEN OF THE ARROW BODY LINE
    @State private var arrowThickness = 2.0
    
    var body: some View {
        VStack {
            
            Arrow(arrowThickness: arrowThickness)
                .fill(.orange)
                .frame(width: 300, height: 500)
                // USER FINGER TAP INPUT GESTURE MODIFIER
                .onTapGesture {
                    // PART OF CHALLENGE #2 CODE
                    // MAKE ANIMATING OF 'Arrow' SHAPE VIEW POSSIBLE WHEN 'arrowThickness' STATE PROPERTY VALUE CHANGES
                    // USE IN CONJUNCTION W/ 'arrowThickness' VIEW STRUCT'S 'animatableData' COMPUTED PROPERTY
                    withAnimation {
                        // SET RANDOM DOUBLE VALUE FROM 10-90 ON EACH TAP GESTURE REGISTERED
                        arrowThickness = Double.random(in: 2...5)
                    }
                }
            
        }
    }
}
*/



// CHALLENGE #3
// CREATE 'ColorCyclingRectangle' SHAPE
// ALLOW CONTROL FOR THE GRADIENT POSITIONS
//
// 'ColorCyclingRectangle' VIEW STRUCT
struct ColorCyclingRectangle: View {
    // STORE THE COLOR CYCLE AMOUNT
    var cycleAmount = 0.0
    // STORE HOW MANY RECTANGLE STEPS TO DRAW
    var steps = 100
    
    // STORE LINEAR GRADIENT TOP X POSITION
    var gradientTop: Double
    
    // STORE LINEAR GRADIENT BOTTOM X POSITION
    var gradientBottom: Double
    
    
    // VIEW BODY PROPERTY
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                // INSET MODIFIER
                    .inset(by: Double(value))
                
                // STROKEBORDER MODIFIER
                    .strokeBorder(
                        // VERY COMPLEX LINEAR GRADIENT TO BE RENDERED W/ "CORE GRAPHIC" FOR SO MANY CIRCLE VIEWS
                        // WOULD IMPACT RESPONSIVENESS & PERFORMANCE IF RENDERED USING "CORE GRAPHIC"
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    color(for: value, brightness: 1),
                                    color(for: value, brightness: 0.5)
                                ]
                            ), startPoint: UnitPoint(x: gradientTop, y: 0), endPoint: UnitPoint(x: gradientBottom, y: 1)
                        ), lineWidth: 2
                    )
                
            }
            
        }
        // ZSTACK VIEW MODIFIER
        
        // '.drawingGroup' MODIFIER
        // RENDER COMPLEX VIEW W/"METAL" FRAMEWORK
        .drawingGroup()
        /* RENDER VIEW W/ APPLE'S "METAL" FRAMEWORK
         1. Render the contents of the View into an off-screen Image
         2. Put it back onto the screen as a single rendered output
         */
        
    }
    
    // METHOD TO GET DYNAMIC COLOR VALUES, RETURNS A 'Color' VALUE
    func color(for value: Int, brightness: Double) -> Color {
        // METHOD PROPERTY TO STORE TARGET COLOR HUE
        var targetHue = Double(value) / Double(steps) + cycleAmount
        
        // CONDITIONAL HUE ADJUSTMENT
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
        
    }
    
}


// MAIN CONTENT VIEW
struct ContentView: View {
    // STATE PROPERTY TO STORE COLOUR CYCLE
    @State private var colorCycle = 0.0

    // STATE PROPERTY TO STORE GRADIENT TOP X POSITION
    @State private var gradientTop = 0.5
    
    // STATE PROPERTY TO STORE GRADIENT BOTTOM X POSITON
    @State private var gradientBottom = 0.5
    
    var body: some View {
        VStack {
            // CIRCLE VIEW SECTION
            
            Section {
                ColorCyclingRectangle(cycleAmount: colorCycle, gradientTop: gradientTop, gradientBottom: gradientBottom)
                    .frame(width: 300, height: 300)
            }
            
            
            // USER INPUT VSTACK
            VStack {
                // COLOR CYCLE SECTION
                Section("Color Cyle") {
                    Slider(value: $colorCycle)
                }
                
                // GRADIENT X AXIS POSITIONS SECTION
                Section("Gradient Position") {
                    Slider(value: $gradientTop, in: 0...1, step: 0.01)
                    Slider(value: $gradientBottom, in: 0...1, step: 0.01)
                }
            }
            .padding(50)
            
        }
        
    }
}
//


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
