//
//  ContentView.swift
//  Drawing-SwiftUI concepts
//
//  Created by Paul Andri on 08/03/2022.
//

import SwiftUI

// DRAWING SHAPES W/ SWIFTUI
/*
// 'Path' VIEW - DRAWING W/ CUSTOM PATHS
/*
struct ContentView: View {
    var body: some View {
        
        // DRAW A TRIANGLE SHAPE W/ 'Path' VIEW
        Path { path in
            // PATH'S STARTING POINT
            path.move(to: CGPoint(x: 200, y: 100))
            // 1st LINE DRAWN FROM THE PATH'S STARTING POINT
            path.addLine(to: CGPoint(x: 100, y: 300))
            // 2nd LINE DRAWN FROM THE PATH'S 1st LINE POINT
            path.addLine(to: CGPoint(x: 300, y: 300))
            // 3rd LINE DRAWN FROM THE PATH'S 2nd LINE POINT
            path.addLine(to: CGPoint(x: 200, y: 100))
            // CLOSE SUBPATH - RESULTS IN NEAT DRAWING W/O EXTRA MODIFIERS
            path.closeSubpath()
        }
        
        // FILL PATH VIEW W/ COLOR/MATERIAL/GRADIENT ETC
        .fill(
            .linearGradient(stops: [
                Gradient.Stop(color: .yellow, location: 0.2),
                Gradient.Stop(color: .blue, location: 0.45)],
                startPoint: .topTrailing, endPoint: .bottomLeading
            )
        )
        
        
        /*
        // FILL PATH VIEW'S PATH LINE W/ '.stroke()' MODIFIER
        .stroke(.blue, lineWidth: 10)
        */
        
        /*
        // FILL PATH VIEW'S PATH LINE W/ CUSTOM '.stroke()' MODIFIER
        .stroke(
            .blue,
            style: StrokeStyle(
                lineWidth: 10,
                lineCap: .round,
                lineJoin: .round
            )
        )
        */
    }
}
*/



// 'Shape' VIEW - DRAWING INSIDE A GIVEN RECTANGLE
// 'Shape' VIEW DOES NOT REQUIRE ABSOLUTE COORDINATES
/*
// TRIANGLE 'Shape' VIEW
/*
// 'Shape' VIEW STRUCT TO DRAW A TRIANGLE
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        // PATH PROPERTY TO RETURN
        var path = Path()
        
        // PATH'S STARTING POINT (MIDDLE OF THE "RECTANGLE SHAPE"
        path.move(to: CGPoint(x:rect.midX, y: rect.midY)) // 'rect' = RECTANGLE
        // 1st LINE DRAWN FROM PATH'S STARTING POINT
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        // 2nd LINE DRAWN FROM PATH'S 1st LINE POINT
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        // 3rd LINE DRAWN FROM PATH'S 2nd LINE POINT
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        
        return path
    }
}

// 'Shape' VIEW STRUCT TO DRAW A INVERTED TRIANGLE
struct InvTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        // PATH PROPERTY TO RETURN
        var path = Path()
        
        // PATH'S STARTING POINT (MIDDLE OF THE "RECTANGLE SHAPE"
        // 'Shape' VIEW DOES NOT REQUIRE ABSOLUTE COORDINATES
        path.move(to: CGPoint(x:rect.midX, y: rect.midY)) // 'rect' = RECTANGLE
        // 1st LINE DRAWN FROM PATH'S STARTING POINT
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minX))
        // 2nd LINE DRAWN FROM PATH'S 1st LINE POINT
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        // 3rd LINE DRAWN FROM PATH'S 2nd LINE POINT
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        
        return path
    }
}

// MAIN CONTENT VIEW
struct ContentView: View {
    var body: some View {
        ZStack {
            // 'Triangle' SHAPE VIEW
            Triangle()
                // FILL 'Triangle' VIEW W/ COLOR/MATERIAL/GRADIENT ETC
                .fill(
                    .linearGradient(stops: [
                        Gradient.Stop(color: .yellow, location: 0.6),
                        Gradient.Stop(color: .blue, location: 0.9)],
                                    startPoint: .topTrailing, endPoint: .bottomLeading
                                   )
                )
            
            // 'InvTriangle' SHAPE VIEW
            InvTriangle()
                // FILL 'InvTriangle' VIEW W/ COLOR/MATERIAL/GRADIENT ETC
                .fill(
                    .linearGradient(stops: [
                        Gradient.Stop(color: .blue, location: 0.1),
                        Gradient.Stop(color: .yellow, location: 0.4)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                   )
                )
                
                // FILL // 'InvTriangle' SHAPE VIEW W/ CUSTOM '.stroke()' MODIFIER
                /*
                .stroke(
                    .blue,
                    style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                */
        }
        .frame(width: 300, height: 300)
    }
}
*/

// ARC 'Shape' VIEW
/*
 // 'Shape' VIEW STRUCT TO DRAW AN ARC SHAPE
 struct Arc: Shape {
     let startAngle: Angle
     let endAngle: Angle
     let clockwise: Bool
     
     // ARC PATH DRAWING METHOD
     func path(in rect: CGRect) -> Path {
         // PROPERTY TO "CORRECT" THE "SWIFTUI ANGLE" INTO "HUMAN'S ANGLE"
         let angleAdjust = Angle.degrees(90)
         
         // PROPERTY TO MODIFY OUR 'startAngle' PARAM VALUE W/ 'angleAdjust' PROPERTY VALUE
         let modifiedStartAngle = startAngle - angleAdjust
         
         // PROPERTY TO MODIFY OUR 'endAngle' PARAM VALUE W/ 'angleAdjust' PROPERTY VALUE
         let modifiedEndAngle = endAngle - angleAdjust
         
         // PATH PROPERTY TO RETURN
         var path = Path()
         
         path.addArc(
             // CENTER POINT OF THE ARC
             center: CGPoint(x: rect.midY, y: rect.midY),
             
             // RADIUS = HALF OF WIDTH
             radius: rect.width / 2,
             
             // ARCH ANGLE PARAMS USING 'modifiedStartAngle' & 'modifiedEndAngle' VALUES
             startAngle: modifiedStartAngle,
             endAngle: modifiedEndAngle,
             
             // WHETHER THE ARC DRAW IN CLOCKWISE DIRECTION
             clockwise: !clockwise // FLIP CLOCKWISE DIRECTION
         )
         
         return path
     }
 }

// MAIN CONTENT VIEW
struct ContentView: View {
    var body: some View {
        ZStack {
            
            // ARCH VIEW #1 (OUTER MOST)
            Arc(startAngle: .degrees(0), endAngle: .degrees(310), clockwise: true)
            // CUSTOM '.stroke()' MODIFIER
            .stroke(
                .green,
                style: StrokeStyle(
                    lineWidth: 20,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
                .frame(width: 300, height: 300)
            
            // ARCH VIEW #2
            Arc(startAngle: .degrees(0), endAngle: .degrees(330), clockwise: true)
            // CUSTOM '.stroke()' MODIFIER
            .stroke(
                .blue,
                style: StrokeStyle(
                    lineWidth: 20,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
                .frame(width: 250, height: 250)
        
            // ARCH VIEW #3
            Arc(startAngle: .degrees(0), endAngle: .degrees(300), clockwise: true)
            // CUSTOM '.stroke()' MODIFIER
            .stroke(
                .yellow,
                style: StrokeStyle(
                    lineWidth: 20,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
                .frame(width: 200, height: 200)
            
            // ARCH VIEW #4
            Arc(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
            // CUSTOM '.stroke()' MODIFIER
            .stroke(
                .red,
                style: StrokeStyle(
                    lineWidth: 20,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
                .frame(width: 150, height: 150)
            
            // ARCH VIEW #5 (INNER MOST)
            Arc(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
            // CUSTOM '.stroke()' MODIFIER
                .fill(.orange)
                .frame(width: 120, height: 120)
            
        }
    }
}
*/
*/



// 'strokeBorder()' MODIFIER & 'InsettableShape' PROTOCOL
/*
// 'Shape' VIEW STRUCT TO DRAW AN ARC SHAPE
// CONFORMS TO 'Shape' & 'InsettableShape' PROTOCOLS
struct Arc: Shape, InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    // PART OF CODE TO MAKE 'Arc' VIEW CONFORM TO 'InsettableShape' PROTOCOL
    // INSET AMOUNT PROPERTY
    var insetAmount = 0.0
    
    // ARC PATH DRAWING METHOD
    func path(in rect: CGRect) -> Path {
        // PROPERTY TO "CORRECT" THE "SWIFTUI ANGLE" INTO "HUMAN'S ANGLE"
        let angleAdjust = Angle.degrees(90)
        
        // PROPERTY TO MODIFY OUR 'startAngle' PARAM VALUE W/ 'angleAdjust' PROPERTY VALUE
        let modifiedStartAngle = startAngle - angleAdjust
        
        // PROPERTY TO MODIFY OUR 'endAngle' PARAM VALUE W/ 'angleAdjust' PROPERTY VALUE
        let modifiedEndAngle = endAngle - angleAdjust
        
        // PATH PROPERTY TO RETURN
        var path = Path()
        
        path.addArc(
            // CENTER POINT OF THE ARC
            center: CGPoint(x: rect.midY, y: rect.midY),
            
            // PART OF CODE TO MAKE 'Arc' VIEW CONFORM TO 'InsettableShape' PROTOCOL
            // RADIUS = HALF OF WIDTH
            // '- insetAmount' ALLOWS THE SHAPE TO BE INSETTED
            radius: rect.width / 2 - insetAmount,
            
            // ARCH ANGLE PARAMS USING 'modifiedStartAngle' & 'modifiedEndAngle' VALUES
            startAngle: modifiedStartAngle,
            endAngle: modifiedEndAngle,
            
            // WHETHER THE ARC DRAW IN CLOCKWISE DIRECTION
            clockwise: !clockwise // FLIP CLOCKWISE DIRECTION
        )
        
        return path
    }
    
    // PART OF CODE TO MAKE 'Arc' VIEW CONFORM TO 'InsettableShape' PROTOCOL
    // METHOD TO ALLOW 'Arc' VIEW TO BE INSETTED & RETURNS SOMEKIND OF 'InsettableShape'
    // 'CGFloat' IS A LEGACY DATA TYPE EQUIVALENT TO 'DOUBLE' DATA TYPE
    func inset(by amount: CGFloat) -> some InsettableShape {
        // COPY THE PROPERTIES & VALUE OF THE MAIN 'Arc' STRUCT
        var arc = self
        // ADD THE 'amount' PARAM VALUE ON THE 'insetAmount' PROPERTY VALUE IN 'arc' METHOD PROPERTY
        arc.insetAmount += amount
        
        return arc
    }
    
}


// MAIN CONTENT VIEW
struct ContentView: View {
    var body: some View {
        
        // CIRCLE VIEW & 'strokeBorder()' MODIFIER
        /*
        Circle()
            // SWIFTUI STROKE ON THE CENTER-LINE OF THE CIRCLE SHAPE VIEW BORDER
            //.stroke(.blue, lineWidth: 40)
            
            // SWIFTUI STROKE ON THE INSIDE OF THE CIRCLE SHAPE VIEW BORDER
            .strokeBorder(.blue, lineWidth: 40)
        */
        
        // ARC SHAPE VIEW & 'strokeBorder()' MODIFIER
        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
            // 'strokeBorder()' MODIFIER REQUIRES 'Arc' VIEW STRUCT TO ALSO CONFORM TO 'InsettableShape' PROTOCOL
            .strokeBorder(.blue, lineWidth: 40)
            .frame(width: 370, height: 370)
        
    }
}
*/



// 'CGAffineTransform' & EVEN-ODD FILLS
// 'CGAffineTransform' - Describes how a Path or View should be rotated, scaled, or sheared
/*
// CREATE A FLOWER SHAPE OUT OF 16 ROTATED ELLIPSE PETALS, POSIITONED AROUND A CIRCLE SHAPE
// FLOWER VIEW STUCT
struct Flower: Shape {
    // PROPERTY TO DEFINE HOW MUCH TO MOVE THE PETAL AWAY FROM THE CENTER POINT
    var petalOffset: Double = -20   // MOVE -20PT FROM THE CENTER POINT
    
    // PROPERTY TO DEFINE HOW WIDE IS EACH THE PETAL
    var petalWidth: Double = 100
    
    // METHOD TO DEFINE FLOWER PATH
    func path(in rect: CGRect) -> Path {
        // PROPERTY TO HOLD ALL PETAL PATHS
        var path = Path()
        
        // FOR LOOP FUNCTION
        // 'stride(from:to:by:)' - count in 2s
        // FOR LOOP LOGIC: COUNT 'from: 0' UP TO 'pi * 2', MOVE UP "AN-EIGHT OF 'PI' VALUE" IN EACH LOOP ITERATION
        for number in stride(
            from: 0,
            through: Double.pi * 2, // PI VALUE * 2 = 360DEGREE
            by: Double.pi / 8) {
            
            // FOR LOOP BODY CODE
            // ROTATE THE FLOWER PETAL BY THE CURRENT 'number' VALUE OF OUR LOOP
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // MOVE THE FLOWER PETAL TO BE AT THE CENTER OF OUR 'rect' DRAWING RECTANGLE
            // 'concatenating' returns an Affine Transformation matrix by multiplying two Affine Transformation matrices together
            let position = rotation.concatenating(
                CGAffineTransform(                  // DEFINE HOW FAR TO MOVE THE FLOWER PETALS
                    translationX: rect.width / 2,   // HALF OF THE DRAWING RECTANGLE WIDTH
                    y: rect.height / 2              // HALF OF THE DRAWING RECTANGLE HEIGHT
                )
            )
            
            // CREATE A NEW PATH FOR THE FLOWER PETAL USING STRUCT'S PROPERTIES & FIXED 'y' & 'height' VALUES
            let originalPetal = Path(
                // ELLIPSE SHAPE PATH
                ellipseIn: CGRect(
                    x: petalOffset,         // X POSITION OF THE ELLIPSE PATH
                    y: 0,
                    width: petalWidth,      // WIDTH OF THE ELLIPSE PATH
                    height: rect.width / 2  // HEIGHT OF THE ELLIPSE PATH
                )
            )
            
            // APPLY ROTATION(POSITION TRANSFORMATION) TO THE 'originalPetal'
            let rotatedPetal = originalPetal.applying(position)
            
            // ADD 'rotatedPetal' INTO OUR MAIN METHOD PROPERTY 'path'
            path.addPath(rotatedPetal)
            
        }
        
        // RETURN 'path' VALUE
        return path
        
    }
    
}


// MAIN CONTENT VIEW
struct ContentView: View {
    // STATE PROPETY TO STORE FLOWER PETAL OFFSET VALUE
    @State private var petalOffset = -20.0
    // STATE PROPETY TO STORE FLOWER PETAL WIDTH VALUE
    @State private var petalWidth = 100.0
    
    var body: some View {
        // MAIN VSTACK VIEW
        VStack {
            // FLOWER STRUCT VIEW
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                // FILL MODIFIER W/ "EVEN-ODD" FILL STYLE
                .fill(.red, style: FillStyle(eoFill: true))
                // HOW EVEN-ODD FILL STYLE WORK:
                /*
                - If a path has no overlaps it will be filled.
                - If another path overlaps it, the overlapping part won’t be filled
                - If a third path overlaps the previous two, then it will be filled.
                -...and so on.*/
            
                // STROKE MODIFIER
                //.stroke(.red, lineWidth: 1)
            
                .padding()
            
            // USER INTERACTIVE INPUT SECTION TO DYNAMICALLY TRANSFORM THE 'Flower' VIEW
            Section {
                VStack {
                    // PETAL OFFSET SLIDER INPUT
                    Text("Offset")
                    Slider(value: $petalOffset, in: -40...40)
                        .padding([.horizontal, .bottom])
                    
                    // PETAL WIDTH SLIDER INPUT
                    Text("Width")
                    Slider(value: $petalWidth, in: 0...100)
                        .padding(.horizontal)
                    
                }
            }
            // PADDING MODIFIER FOR INPUT SECTION VIEW
            .padding()
        }
    }
}
*/



// 'ImagePaint'
// A dedicated Type that wraps Images in a way that we have complete control over how they should be rendered
/*
struct ContentView: View {
    var body: some View {
        
        // IMAGEPAINT W/ TEXT VIEW's 'border' MODIFIER
        /*
        Text("Hello!")
            .frame(width: 300, height: 300)
            
            // BORDER MODIFIER W/ 'ImagePaint'
            .border(
                // IMAGEPAINT
                ImagePaint(
                    // COMPULSARY IMAGEPAINT PARAMETER 'image'
                    image: Image("singapore"),
                    
                    // OPTIONAL SOURCE RECTANGLE IMAGEPAINT PARAMETER (MUST BE 'CGRect')
                    // CROPS A SPECIFIC PORTION OF THE IMAGE INTO A RECTANGLE
                    sourceRect: CGRect(x: 0, y: 0.4, width: 1, height: 0.2),
                    
                    // OPTIONAL IMAGE SCALE IMAGEPAINT PARAMETER
                    // SCALE THE IMAGE FILE
                    scale: 0.2
                ), width: 50
            )
         */
        
        
        // IMAGEPAINT W/ CAPSULE VIEW 'strokeBorder' MODIFIER
        Capsule()
            .strokeBorder(
                ImagePaint(
                    // COMPULSARY IMAGEPAINT PARAMETER 'image'
                    image: Image("singapore"),
                    
                    // OPTIONAL SOURCE RECTANGLE IMAGEPAINT PARAMETER (MUST BE 'CGRect')
                    // CROPS A SPECIFIC PORTION OF THE IMAGE INTO A RECTANGLE
                    sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5),
                    
                    // OPTIONAL IMAGE SCALE IMAGEPAINT PARAMETER
                    // SCALE THE IMAGE FILE
                    scale: 0.3
                ), lineWidth: 20
            )
            .frame(width: 300, height: 200)
        
    }
}
*/



// "METAL" RENDERING W/ 'drawingGroup()'
// COLOR CYCLING CIRCLE
/*
// 'ColorCyclingCircle' VIEW STRUCT
struct ColorCyclingCircle: View {
    // STORE THE CIRCLE AMOUNT
    var amount = 0.0
    // STORE HOW MANY CIRCLE STEPS TO DRAW
    var steps = 100
    
    // VIEW BODY PROPERTY
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
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
                            ), startPoint: .top, endPoint: .bottom
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
        var targetHue = Double(value) / Double(steps) + amount
        
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
    
    var body: some View {
        VStack {
            // CIRCLE VIEW SECTION
            Section {
                ColorCyclingCircle(amount: colorCycle)
                    .frame(width: 300, height: 300)
            }
            
            // USER INPUT SECTION
            Section {
                Slider(value: $colorCycle)
            }
            .padding()
            
        }

    }
}
*/
*/



// SPECIALFX IN SWIFT UI
/*
// '.blendMode()' & '.colorMultiply()' MODIFIER
/*
struct ContentView: View {
    var body: some View {
        
        // '.blendMode()' MODIFIER
        /*
        ZStack {
            Image("paul")
            
            Rectangle()
                .fill(.red)
                
                // BLEND MODE MODIFIER
                .blendMode(.multiply)
        }
        */
        
        // '.colorMultiply()' MODIFIER
        /*
            Image("paul")
                .colorMultiply(.red)
        */
        
        Text("")
    }
}
*/

// SWIFTUI'S ADAPTIVE COLOUR VS PURE RGB COLOUR
/*
struct ContentView: View {
    // STATE PROPERTY TO STORE USER INPUT SLIDER VALUE
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                // CIRCLE SHAPE VIEWS W/ SWIFTUI'S ADAPTIVE COLOUR
                // Designed to look good in both dark mode and light mode
                // Custom blend of red, green, and blue rather than pure shades.
                /*
                // CIRCLE SHAPE VIEW #1 - RED
                Circle()
                    .fill(.red)
                    // FRAME WIDTH DEPENDS ON THE 'amount' STATE PROPERTY VALUE
                    .frame(width: 200 * amount)
                    // CIRCLE VIEW POSITION OFFSET
                    // TOP-LEFT POSITION
                    .offset(x: -50, y: -80)
                    // SCREEN BLEND MODE
                    .blendMode(.screen)
                
                
                // CIRCLE SHAPE VIEW #2 - GREEN
                Circle()
                    .fill(.green)
                    // FRAME WIDTH DEPENDS ON THE 'amount' STATE PROPERTY VALUE
                    .frame(width: 200 * amount)
                    // CIRCLE VIEW POSITION OFFSET
                    // TOP-RIGHT POSITION
                    .offset(x: 50, y: -80)
                    // SCREEN BLEND MODE
                    .blendMode(.screen)
                
                
                // CIRCLE SHAPE VIEW #3 - BLUE
                // STAY CENTERED
                Circle()
                    .fill(.blue)
                    // FRAME WIDTH DEPENDS ON THE 'amount' STATE PROPERTY VALUE
                    .frame(width: 200 * amount)
                    // SCREEN BLEND MODE
                    .blendMode(.screen)
                */
                
                
                // CIRCLE SHAPE VIEWS W/ PURE RGB COLOUR
                //
                // CIRCLE SHAPE VIEW #1 - RED
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    // FRAME WIDTH DEPENDS ON THE 'amount' STATE PROPERTY VALUE
                    .frame(width: 200 * amount)
                    // CIRCLE VIEW POSITION OFFSET
                    // TOP-LEFT POSITION
                    .offset(x: -50, y: -80)
                    // SCREEN BLEND MODE
                    .blendMode(.screen)
                
                
                // CIRCLE SHAPE VIEW #2 - GREEN
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    // FRAME WIDTH DEPENDS ON THE 'amount' STATE PROPERTY VALUE
                    .frame(width: 200 * amount)
                    // CIRCLE VIEW POSITION OFFSET
                    // TOP-RIGHT POSITION
                    .offset(x: 50, y: -80)
                    // SCREEN BLEND MODE
                    .blendMode(.screen)
                
                
                // CIRCLE SHAPE VIEW #3 - BLUE
                // STAY CENTERED
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    // FRAME WIDTH DEPENDS ON THE 'amount' STATE PROPERTY VALUE
                    .frame(width: 200 * amount)
                    // SCREEN BLEND MODE
                    .blendMode(.screen)
                //
                
            }
            // ZSTACK FRAME MODIFIER
            .frame(width: 300, height: 300)
            
            // USER INPUT SLIDER FOR 'amount' STATE PROPERTY VALUE
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}
*/

// 'saturation()'MODIFIERS
// Adjusts how much colour is used inside a View
/*
struct ContentView: View {
    // STATE PROPERTY TO STORE USER INPUT SLIDER VALUE
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            // IMAGE VIEW
            Image("paul")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                // SATURATION MODIFIER BOUND TO 'amount' STATE PROPERTY VALUE
                .saturation(amount)
                // BLUE MODIFIER BOUNT TO CALCULATED VALUE W/ 'amount' STATE PROPERTY VALUE
                .blur(radius: (1-amount) * 20)
            
            // USER INPUT SLIDER FOR 'amount' STATE PROPERTY VALUE
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}
*/
*/



// ANIMATING SHAPES W/ SWIFT UI
//
// ANIMATING SIMPLE SHAPES W/ 'animatableData'
/*
// TRAPEZOID SHAPE VIEW STRUCT
struct Trapezoid: Shape {
    // PROPERTY TO STORE TRAPEZOID INSET AMOUNT
    var insetAmount: Double
    
    // 'animatableData' COMPUTED PROPERTY
    // REQUIRED TO MAKE ANIMATING CHANGES IN SHAPE POSSIBLE
    // USE IN CONJUNCTION W/ 'withAnimation'
    var animatableData: Double {
        // READ PROPERTY VALUE
        get { insetAmount }
        // WRITE 'newValue' VALUE TO PROPERTY
        set { insetAmount = newValue} // 'newValue' IS AVAILABLE FOR 'set'
    }
    
    // METHOD TO CREATE THE SHAPE PATHS
    func path(in rect: CGRect) -> Path {
        // PATH PROPERTY
        var path = Path()
        
        // DEFINE PATH'S STARTING POINT
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        
        // ADD 1st PATH LINE DRAWN FROM PATH'S STARTING POINT
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        
        // ADD 2nd PATH LINE DRAWN FROM THE 1st PATH LINE
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        
        // ADD 3rd PATH LINE DRAWN FROM THE 2nd PATH LINE
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // ADD 4th PATH LINE DRAWN FROM THE 3rd PATH LINE
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        // RETURN 'path' VALUE
        return path
    }
}

// MAIN CONTENT VIEW
struct ContentView: View {
    // STATE PROPERTY TO STORE TRAPEZOID SHAPE INSERT AMOUNT
    @State private var insetAmount = 50.0
    
    var body: some View {
        VStack {
            Trapezoid(insetAmount: insetAmount)
                .fill(.orange)
                .frame(width: 200, height: 100)
                // USER FINGER TAP INPUT GESTURE MODIFIER
                .onTapGesture {
                    // MAKE ANIMATING OF 'Trapezoid' SHAPE VIEW POSSIBLE WHEN 'insetAmount' STATE PROPERTY VALUE CHANGES
                    // USE IN CONJUNCTION W/ 'Trapezoid' VIEW STRUCT'S 'animatableData' COMPUTED PROPERTY
                    withAnimation {
                        // SET RANDOM DOUBLE VALUE FROM 10-90 ON EACH TAP GESTURE REGISTERED
                        insetAmount = Double.random(in: 10...90)
                    }
                }
        }
    }
}
*/

// ANIMATING COMPLEX SHAPES W/ 'AnimatablePair'
//
// CHECKERBOARD SHAPE VIEW STRUCT
struct Checkerboard: Shape {
    // CHECKERBOARD SPEC PROPERTIES
    var rows: Int
    var cols: Int
    
    // 'animatablePair' COMPUTED PROPERTY THAT STORE TWO 'Double' VALUES
    // REQUIRED TO MAKE ANIMATING CHANGES IN SHAPE POSSIBLE
    // USE IN CONJUNCTION W/ 'withAnimation'
    var animatableData: AnimatablePair<Double, Double> {
        // READ 'AnimatablePair' PROPERTY VALUE
        get {
            // 'rows' & 'cols' HAD TO BE CONVERTED TO A DOUBLE VALUE
            // 'Int' WHOLE NUMBER DATA TYPE DO NOT HAVE "IN-BETWEEN" DATA
            AnimatablePair(Double(rows), Double(cols))
        }
        
        // WRITE 'newValue' VALUES TO ITS CORRESPONDING PROPERTY
        set {
            // 'first' 'second' CORRESPONDS TO THE ORDER ON 'get'
            rows = Int(newValue.first)
            cols = Int(newValue.second)
            // 'newValue' VALUES ARE IN 'Double'DATA TYPE
            // NEEDS TO BE CONVERTED BACK TO THE CORRECT 'Int' DATA TYPE
        }
    }
    
    // METHOD TO GENERATE CHECKERBOARD PATHS
    func path(in rect: CGRect) -> Path {
        // PATH PROPERTY
        var path = Path()
        
        // DEFINING ROW & COL SIZES W/ COMPUTED PROPERTIES
        let rowSize = rect.height / Double(rows)
        let colSize = rect.width / Double(cols)
        
        // DYNAMICALLY GENERATE THE CHECKERBOARD VIEW USING 'for' LOOP
        for row in 0..<rows {
            for col in 0..<cols {
                // CONDITIONALLY CREATE CHECKERBOX PATTERNS
                // ONLY COLOUR THE PATTERN OF ALL ODD NUMBERED ROWS & COLS
                if (row + col).isMultiple(of: 2) {
                    // DYNAMICALLY GET THE STARTING X & Y AXIS VALUES FOR THE COLOURED CHECKER PATTERN
                    let startX = colSize * Double(col)
                    let startY = rowSize * Double(row)
                    
                    // CREATE PATTERN RECTANGLE
                    let rect = CGRect(x: startX, y: startY, width: colSize, height: rowSize)
                    
                    // ADD THE 'rect' CGRECT VALUE TO 'path' PROPERTY
                    path.addRect(rect)
                }
            }
        }
        
        // RETURN 'path' VALUE
        return path
        
    }
}

// MAIN CONTENT VIEW
struct ContentView: View {
    // STATE PROPERTY TO STORE CHECKERBOX's ROW SPEC VALUE
    @State private var rows = 8
    
    // STATE PROPERTY TO STORE CHECKERBOX's COL SPEC VALUE
    @State private var cols = 4
    
    var body: some View {
        Checkerboard(rows: rows, cols: cols)
            // USER FINGER TAP INPUT GESTURE MODIFIER
            .onTapGesture {
                // MAKE ANIMATING OF 'Checkerboard' SHAPE VIEW POSSIBLE WHEN THE STATE PROPERTIES VALUE CHANGES
                // USE IN CONJUNCTION W/ 'Checkerboard' VIEW STRUCT'S 'animatableData: animatablePair' COMPUTED PROPERTY
                withAnimation(.linear(duration: 0.2)) {
                    rows += 4
                    cols += 8
                }
            }
            .ignoresSafeArea()
    }
}
//

//



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
            
    }
}
