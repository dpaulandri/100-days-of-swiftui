//
//  ContentView.swift
//  Spirograph
//
//  Created by Paul Andri on 08/05/2022.
//

import SwiftUI

// SPIROGRAPHY SHAPE VIEW STRUCT
struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let drawAmount: Double
    
    // METHOD TO GET THE "GREATEST COMMON DIVISOR" (GCD) VALUE FROM THE STRUCT'S PROPERTY
    func gcd(_ a:Int, _ b:Int) -> Int {
        // COPY THE INPUT PARAMETERS VALUES
        var a = a
        var b = b
        
        // WHILE LOOP
        while b != 0 {
            // WHILE 'b' IS NOT '0':
            // CREATE A 'temp' CONSTANT THAT HAVE THE VALUE OF 'b'
            let temp = b
            
            // 'b' IS ASSIGN THE RESULT VALUE OF 'a % b'
            b = a % b
            
            // 'a' IS ASSIGNED THE VALUE OF 'temp'
            a = temp
        }
        
        // RETURN THE 'Int' VALUE OF 'a'
        return a
    }
    
    // METHOD TO DRAW THE SPIROGRAPH PATHS
    func path(in rect: CGRect) -> Path {
        // METHOD PROPERTIES  SECTION
        //============================
        // COMPUTED PROPERTY FOR THE "GCD" VALUE USING 'gcd' METHOD
        let divisor = gcd(innerRadius, outerRadius)
        
        
        // CREATE A COPY OF THE STRUCT'S 'outerRadius' VALUE
        let outerRadius = Double(self.outerRadius)
        // CREATE A COPY OF THE STRUCT'S 'innerRadius' VALUE
        let innerRadius = Double(self.innerRadius)
        // CREATE A COPY OF THE STRUCT'S 'distance' VALUE
        let distance = Double(self.distance)
        // COMPUTED PROPERTY TO COUNT THE DIFFERENCE B/W 'innerRadius' & 'outerRadius'
        let difference = innerRadius - outerRadius
        
        
        // COMPUTED PROPERTY TO DETERMINE THE "ENDPOINT" OF OUR DRAWING
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * drawAmount
        
        //============================
        
        
        
        // PATH SECTION
        //============================
        // CREATE PATH PROPERTY
        var path = Path()
        
        // FOR LOOP
        // MATHS FORMULA TO CREATE SPIROGRAPHY DRAWING LOGIC
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        // RETURN 'path' VALUE
        return path
        
        //============================

    }
    
}

struct ContentView: View {
    // STATE PROPERTIES FOR 'Spirograph' SHAPE VIEW SPECS
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var drawAmount = 1.0
    @State private var colorHue = 0.6
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // SPIROGRAPH SHAPE VIEW
            Spirograph(
                innerRadius: Int(innerRadius),
                outerRadius: Int(outerRadius),
                distance: Int(distance),
                drawAmount: drawAmount
            )
            // STROKE MODIFIER
            .stroke(Color(hue: colorHue, saturation: 1, brightness: 1), lineWidth: 1)
            // FRAME MODIFIER
            .frame(width: 300, height: 300)
            
            Spacer()
            
            // GROUP VIEW FOR USER VALUE INPUTS
            Group {
                // INNER RADIUS INPUT
                Text("Inner Radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                // OUTER RADIUS INPUT
                Text("Outer Radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                // DISTANCE INPUT
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                
                // DRAW AMOUNT INPUT
                // FORMATTED TO SHOW LAST 2 DECIMAL POINT
                Text("Draw Amount: \(drawAmount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $drawAmount)
                    .padding([.horizontal, .bottom])
                
                // COLOUR HUE INPUT
                Text("Color")
                Slider(value: $colorHue)
                    .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
