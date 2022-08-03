//
//  ContentView.swift
//  Drawing-SwiftUI concepts
//
//  Created by Paul Andri on 08/03/2022.
//

import SwiftUI

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



// 'strokeBorder()' MODIFIER & 'InsettableShape' PROTOCOL
//
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
//


/*
struct ContentView: View {
    var body: some View {
        Text("")
    }
}

struct ContentView: View {
    var body: some View {
        Text("")
    }
}

struct ContentView: View {
    var body: some View {
        Text("")
    }
}

struct ContentView: View {
    var body: some View {
        Text("")
    }
}
*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
