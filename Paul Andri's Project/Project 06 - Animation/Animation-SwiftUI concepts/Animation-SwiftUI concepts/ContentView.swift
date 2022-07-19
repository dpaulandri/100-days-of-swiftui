//
//  ContentView.swift
//  Animation-SwiftUI concepts
//
//  Created by Paul Andri on 07/18/2022.
//

import SwiftUI

/*
// IMPLICIT ANIMATION
struct ContentView: View {
    
   // Program State Property to store 'Double' value for the amount of '.scaleEffect()' animation value
    @State private var scaleAmount = 1.0
    
    var body: some View {
        
        // BUTTON VIEW TO ANIMATE
        Button("Tap") {
            
            // Increase the value of 'scaleAmount' Program State Property on each button tap
            scaleAmount += 0.5
            
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        
        // SCALING FX - using the value of 'scaleAmount' Program State Property
        // Effectively Scale our Button up on every Button Tap (see Button's body code)
        .scaleEffect(scaleAmount)
        
        // GAUSSIAN BLUR FX
        // '(scaleAmount - 1)' is there to make sure there's NO Blur when 'scaleAmount's value is 1
        // The Gaussian Blur FX is more intense on each Scaling FX
        .blur(radius: ((scaleAmount - 1) * 3))
        
        // ANIMATION TO SMOOTHEN OUR SCALING EFFECT
        // '.default' = '.eastInOut' Animation FX
        .animation(.default, value: scaleAmount)
        /* CODE LOGIC:
         Provide 'default' animation to the previous View whenever the value of 'scaleAmount' is changed */
        
    }
}
*/



/*
// CUSTOMISING ANIMATIONS IN SWIFTUI
struct ContentView: View {
    
    @State private var scaleAmount = 1.0
    
    var body: some View {
        
        Button("Tap") {
            scaleAmount += 0.5
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(scaleAmount)
        .blur(radius: ((scaleAmount - 1) * 3))
        
        
        // CUSTOMISING ANIMATION FX TYPEs
        
        // .'default' Animation
        // .animation(.default, value: scaleAmount)
        
        // .'easeOut' Animation
        // .animation(.easeOut, value: scaleAmount)
        
        
        /*
        // .'spring()' Animation
        .animation(
            .spring(
                // How fast the Spring FX releases (LOWER meant FASTER Spring Release FX)
                response: 0.2,
                // Spring Damping FX (HIGHER meant SLOWER Spring damping)
                dampingFraction: 0.3,
                // FX Blend Duration
                blendDuration: 0
            ), value: scaleAmount)
        */
        
        
        /*
        // '.interpolatingSpring()' Animation
        .animation(
            .interpolatingSpring(
                // "Stiffness" of the Spring (LOWER meant GENTLER Spring Release FX)
                stiffness: 100,
                // Spring Damping FX (HIGHER meant FASTER Spring damping)
                damping: 4
            ), value: scaleAmount)
        */
        
        
        /*
        // .'easeInOut' Animation w/ SPECIFIED ANIMATION DURATION
        // '(duration: )' - specify the length of the Animation in second
        .animation(.easeInOut(duration: 10), value: scaleAmount)
        // 'easeInOut' Animation that last for 10secs
        */
        
        
        
        
        // ADDING MODIFIER TO ANIMATION TYPE STRUCT
        /*
        // '.delay()' MODIFIER
        .animation(
            .easeInOut(duration: 3)
                // Delay 1sec before the 'easeInOut' animation starts
                .delay(1),
            value: scaleAmount
        )*/
        
        
        /*
        // '.repeatCount()' MODIFIER
        .animation(
            .easeInOut(duration: 1)
                // Repeat the ''easeInOut' Animation for 3 times, incl. autoreverses (Ease In & Out)
                // BE CAREFUL FOR THE REPEAT COUNT VALUE, IT SHOULD EVENTUALLY MATCH OUR PROGRAM STATE
                .repeatCount(3, autoreverses: true),
            value: scaleAmount
        )*/
        
        
        /*
        // '.repeatForever()' MODIFIER
        .animation(
            .easeInOut(duration: 1)
                // Repeat the ''easeInOut' Animation FOREVER, incl. autoreverses (Ease In & Out)
                .repeatForever(autoreverses: true),
            value: scaleAmount
        )*/
                 
    }
    
}
*/

    
    
/*
// USING '.overlay()' AND '.onAppear()' MODIFIER
// THIS STRUCT VIEW WILL CREATE A LOOPING "BROCASTING SIGNAL" LIKE ANIMATION
struct ContentView: View {
    
    @State private var scaleAmount = 1.0
    
    var body: some View {
        
        Button("AI") {
            // TAPPING THIS BUTTON DOES NOTHING
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        
        // '.overlay()' MODIFIER
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(scaleAmount)
            
            // '.opacity()' MODIFIER FOR 'Circle()' VIEW
            // value 1 = fully OPAQUE
            // value 0 = fully TRANSPARENT
                .opacity(2 - scaleAmount)   // DYNAMIC VALUE (WORKS W/ 'onAppear()' MODIFIER
            // THIS MODIFIER WILL ALTERNATE THE 'Circle()' VIEW OPACITY BETWEEN FULLY OPAQUE & TRANSPARENT
            
            // ANIMATION MODIFIER
                .animation(
                    .easeInOut(duration: 1)
                    // Repeat the ''easeInOut' Animation FOREVER
                        .repeatForever(autoreverses: false),
                    value: scaleAmount
                )
        )
        
        // 'onAppear()' MODIFIER
        // Execute code whenever a View is shown
        .onAppear {
            // Set the value of 'scaleAmount' PROGRAM STATE PROPERTY to '2' everytime the VIew is shown
            scaleAmount = 2
        }
        
    }
}
*/



/*
// ANIMATING BINDINGS
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY TO STORE A VALUE
    @State private var aValue = 1.0
    
    var body: some View {
        
        // VSTACK VIEW
        VStack {
            // A 'Stepper' Input View, bounded to 'aValue' Program State Property
            Stepper(
                // STEPPER TITLE
                "Value",
                
                // 'Stepper' Input bounded to 'aValue' Program State Property
                // '.animation()' MODIFIER added to the Bounded Property
                // ADDING '.animation()' MODIFIER CAUSES SMOOTH '.scaleEffect()' TO BUTTON VIEW WHEN 'aValue' VALUE IS CHANGED USING 'Stepper' INPUT
                value: $aValue.animation(
                    
                    // 'animation()' PARAMETERS FOR BINDINGS
                    // PARAMETERS FOR BINDINGS ARE SIMILAR (NOT ALL THE SAME) TO NORMAL 'animation()' VIEW MODIFIERS
                    .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
                    
                ),
                
                // Valid Stepper Input range from 1 to 5
                in: 1...5
            )
            
            Spacer()
            
            // BUTTON VIEW
            Button("Tap Me") {
                // ADD '1' to 'aValue' Program State Property everytime the Button is tapped
                aValue += 1
            }
            // BUTTON VIEW MODIFIERS
            .padding(50)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(aValue)
            // BUTTON VIEW HAVE NOT '.animation() MODIFIER, CAUSES CHOPPY '.scaleEffect()'
            
        }
    }
}
*/



/*
// EXPLICIT ANIMATIONS
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        // BUTTON VIEW
        Button("Bounce") {
            
            // 'withAnimation { }'
            // TRIGGER "Explicit Animation" W/ EACH BODY CODE RAN (MUST TRIGGER ANY ARBITRARY STATE CHANGE)
            /*
            withAnimation {
                // ADD VALUE OF '360' TO 'animationAmount' PROGRAM STATE PROPERTY ON EACH BUTTON TAP
                animationAmount += 360
                // THIS BODY CODE TRIGGERS ARBITRARY STATE CHANGE ON 'animationAmount'
            }
            */
            
            // WE CAN ATTACH ANIMATION PARAMETERS TO 'withAnimation { }'
            withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)) {
                animationAmount += 360
            }
            
        }
        // BUTTON VIEW MODIFIERS
        .padding(50)
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        
        // '.rotation3DEffect()' MODIFIER
        // Spin a View around in 3D axis
        .rotation3DEffect(
            // 3D ROTATION '.degrees' USING 'animationAmount' PROGRAM STATE PROPERTY VALUE
            .degrees(animationAmount),
            
            // ROTATE ON 'X' AXIS (VERTICAL)
            // axis: (x:1, y:0 , z:0)
            // ROTATE ON 'Y' AXIS (HORIZONTAL)
            // axis: (x:0, y:1 , z:0)
            // ROTATE ON 'Z' AXIS (DEPTH)
            // axis: (x:0, y:0 , z:1)
            // ROTATE ON ALL AXIS
            axis: (x:1, y:1 , z:1)
        )
        
    }
}
*/



/*
// CONTROLLING THE ANIMATION STACK
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY
    @State private var enableAnimation = false
    
    /*
    // COMMON "IMPLICIT ANIMATION" ON VIEW
    var body: some View {
        
        // BUTTON VIEW
        Button("Tap Me") {
            // Toggle Bool value of 'enableAnimation' Program State w/ each Button tap
            enableAnimation.toggle()
        }
        // BUTTON VIEW MODIFIERS
        .frame(width: 200, height: 200)
        
        // CONDITIONAL MODIFIER USING TERNATY CONDITIONAL OPERATOR
        .background(enableAnimation ? .blue : .red)
        
        .foregroundColor(.white)
        
        // ANIMATION MODIFIER
        // "IMPLICIT ANIMATION" OCCURS WHENEVER THE 'enableAnimation' PROGRAM STATE IS CHANGED
        .animation(.default, value: enableAnimation)
        
    }*/
    
    
    // ANIMATING MULTIPLE VIEW MODIFIERS W/ MULTIPLE 'animation()' MODIFIERS
    var body: some View {
        
        // BUTTON VIEW
        Button("Tap Me") {
            // Toggle Bool value of 'enableAnimation' Program State w/ each Button tap
            enableAnimation.toggle()
        }
        // BUTTON VIEW MODIFIERS
        // VIEW MODIFIER ORDER BEFORE 'animation()' MODIFIER MATTERS!
        
        .frame(width: 200, height: 200)
        
        // CONDITIONAL MODIFIER USING TERNATY CONDITIONAL OPERATOR
        // THIS MODIFIER GETS ANIMATED BY ANIMATION MODIFIER 1
        .background(enableAnimation ? .blue : .red)
        
        // ANIMATION MODIFIER 1
         .animation(.default, value: enableAnimation)
        // ANIMATION MODIFIER 1 - 'nil' VERSION
        // WE CAN PASS 'nil' VALUE TO A ANIMATION MODIFIER; DISABLING THE ANIMATION
        // USE W/ MULTIPLE ANIMATION MODIFIER TO SET THE BREAKPOINT FOR WHERE THE ANIMATION SHOULD START
        //.animation(nil, value: enableAnimation)
        
        .foregroundColor(.white)
        
        // CONDITIONAL MODIFIER USING TERNATY CONDITIONAL OPERATOR
        // THIS MODIFIER GETS ANIMATED BY ANIMATION MODIFIER 2
        .clipShape(RoundedRectangle(cornerRadius: enableAnimation ? 60 : 0))
        
        // ANIMATION MODIFIER 2
        .animation(.interpolatingSpring(stiffness: 50, damping: 2), value: enableAnimation)
        
    }
    
}
*/




// ANIMATING GESTURES : CREDICARD SHAPE OFFSET DRAG GESTURE + ANIMATIONS
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY TO STORE DRAG GESTURE VALUE
    @State private var dragAmount = CGSize.zero
    // 'CGSize' = Core Graphic Size
    // '.zero' = NO WIDTH & HEIGHT VALUE
    
    var body: some View {
        
        //ZSTACK VIEW
        ZStack {
            
            // CREDITCARD SHAPE
            // LINEARGRADIENT VIEW
            LinearGradient(
                colors: [.yellow, .indigo],
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            
            // VSTACK VIEW
            VStack {
                
                HStack {
                    Text("CREDIT CARD")
                    Spacer()
                    Image(systemName: "creditcard")
                        .font(.largeTitle)
                    
                }
                .padding(.top)
                
                Spacer()
                
                HStack {
                    Image(systemName: "rectangle.split.3x3.fill")
                        .font(.largeTitle)
                    Spacer()
                }
                
                
                Spacer()
                
                HStack {
                    Text("JOHN APPLESEED")
                        .font(.headline)
                    Spacer()
                }
                
                
                HStack {
                    VStack {
                        Text("1234 5678 9112 3456")
                            .frame(width: 150, height: 3, alignment: .leading)
                        Text("09/25")
                            .frame(width: 150, height: 5, alignment: .leading)
                    }
                    .font(.footnote)
                    
                    Spacer()
                }
                .padding(.bottom)
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
        }
        // VIEW MODIFIERS
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5, x: 10, y: 10)
        // ALL VIEWS & MODIFIERS ABOVE IS USED TO CREATE AN APPROXIMATION OF A CREDITCARD SHAPE
        
        
        
        // '.offset()' MODIFIER - INFLUENCE the 'X' & 'Y' ON-SCREEN POSITION OF OUR LINEARGARDIENT VIEW
        .offset(dragAmount)
        
        
        // DRAG GESTURE MODIFIER
        // '.gesture()' MODIFIER
        .gesture(
            DragGesture()
                // '.onChange { }' Modifier: run a Closure whenever user moves their finger
                .onChanged { dragAmount = $0.translation }  // Translate value to a CGSize Value
                
                // '.onEnded { }' Modifier: run a Closure whenever user lifts their finger off screen
                // NO ANIMATION
                // .onEnded { _ in dragAmount = .zero }    // Reset value to 'CGSize.zero'
            
                // W/ "EXPLICIT ANIMATION" FOR GESTURE RELEASE ANIMATION
                .onEnded { _ in
                    withAnimation {
                        dragAmount = .zero  // Reset value to 'CGSize.zero'
                    }
                }
        )
        
        // "IMPLICIT ANIMATION" FOR BOTH DRAG & RELEASE GESTURES
        // .animation(.spring(), value: dragAmount)
        
        
    }
    
}




/*
// ANIMATING GESTURES : TEXT OFFSET DRAG GESTURE + DELAYED ANIMATION
struct ContentView: View {
    
    // 'Array()' - CONVERT OUR STRING VALUE TO AN ARRAY CONTAINING EACH LETTER
    let letters = Array("Hello, SwiftUI")
    
    // PROGRAM STATE PROPERTY
    @State private var enableAnimation = false
    
    // PROGRAM STATE PROPERTY TO STORE DRAG GESTURE VALUE
    @State private var dragAmount = CGSize.zero
    // 'CGSize' = Core Graphic Size
    // '.zero' = NO WIDTH & HEIGHT VALUE
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    // CONDITIONAL MODIFIER USING TERNARY CONDITIONAL OPERATOR
                    .background(enableAnimation ? .blue : .red)
                
                    // OFFSET MODIFIER
                    .offset(dragAmount)
                
                    // "IMPLICIT ANIMATION" MODIFIER
                    .animation(
                        // '.delay()' - Create a delayed Animation
                        .default.delay(Double(num) / 20),
                        
                        value: dragAmount
                    )
            }
            
        }
        // GESTURE MODIFIER FOR THE HSTACK VIEW
        .gesture(
            DragGesture()
                // '.onChange { }' Modifier: run a Closure whenever user moves their finger
                .onChanged { dragAmount = $0.translation }  // Translate value to a CGSize Value
            
                // '.onEnded { }' Modifier: run a Closure whenever user lifts their finger off screen
                .onEnded { _ in
                    dragAmount = .zero          // Reset value to 'CGSize.zero'
                    enableAnimation.toggle()    // Toggle Program State of 'enableAnimation'
                    
                }
        )
        
    }
    
}
*/



/*
// SHOW/HIDE VIEWS W/ 'transition()' MODIFIER
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY
    @State private var showRectangle = false
    
    var body: some View {
        
        VStack {
            
            /*
            // METHOD 1: 'if' STATEMENT + "EXPLICIT ANIMATION" (NO TRANSITION MODIFIER)
            // BUTTON VIEW
            Button("Tap Me") {
                // "EXPLICIT ANIMATION" ON EACH 'showRectangle' PROGRAM STATE
                withAnimation {
                    // TOGGLE 'showRectangle' PROGRAM STATE ON EACH BUTTON TAP
                    showRectangle.toggle()
                }
            }
            
            // SHOW 'Rectangle' VIEW ONLY IF 'showRectangle' PROGRAM STATE IS 'true'
            if showRectangle {
                Rectangle()
                    .fill(.indigo)
                    .frame(width: 200, height: 200)
            }
            */
            
            
            /*
            // METHOD 2: 'if' STATEMENT + "EXPLICIT ANIMATION" + 'transition()' MODIFIER
            // BUTTON VIEW
            Button("Tap Me") {
                // "EXPLICIT ANIMATION" ON EACH 'showRectangle' PROGRAM STATE
                withAnimation {
                    // TOGGLE 'showRectangle' PROGRAM STATE ON EACH BUTTON TAP
                    showRectangle.toggle()
                }
            }
            
            // SHOW 'Rectangle' VIEW ONLY IF 'showRectangle' PROGRAM STATE IS 'true'
            if showRectangle {
                Rectangle()
                    .fill(.indigo)
                    .frame(width: 200, height: 200)
                
                    // TRANSITION MODIFIER
                    // PROVIDES A BETTER VIEW TRANSITION FX
                    // TRY OUT DIFFERENT TRANSITION FX
                    .transition(.scale)
            }
            */
            
            
            // METHOD 3: 'if' STATEMENT + "EXPLICIT ANIMATION" + 'asymetric' 'transition()' FX
            // BUTTON VIEW
            Button("Tap Me") {
                // "EXPLICIT ANIMATION" ON EACH 'showRectangle' PROGRAM STATE
                withAnimation {
                    // TOGGLE 'showRectangle' PROGRAM STATE ON EACH BUTTON TAP
                    showRectangle.toggle()
                }
            }
            
            // SHOW 'Rectangle' VIEW ONLY IF 'showRectangle' PROGRAM STATE IS 'true'
            if showRectangle {
                Rectangle()
                    .fill(.indigo)
                    .frame(width: 200, height: 200)
                
                    // TRANSITION MODIFIER
                    // PROVIDES A BETTER VIEW TRANSITION FX
                    // '.asymetric(): Use different transition FX for Insert & Removal of View
                    .transition(.asymmetric(insertion: .scale, removal: .slide))
            }
            
        }
        
    }
}
*/



/*
// BUILDING CUSTOM TRANSITIONS USING 'ViewModifier'

//CREATE A "CORNER ROTATE" MODIFIER STRUCT
struct CornerRotateModifier: ViewModifier {
    // The amount of Rotation Degrees
    let amount: Double
    
    // The anchor point
    let anchor: UnitPoint
    
    // Struct Method
    func body(content: Content) -> some View {
        content
            // ROTATION FX MODIFIER
            .rotationEffect(.degrees(amount), anchor: anchor)
            
            // CONSTRAIN THE TRANSITION FX DRAWING TO OCCUR ONLY INSIDE A CLIPPED VIEW FRAME/SHAPE
            .clipShape(Circle())    // CONTAIN TRANSITION FX INSIDE A CIRCLE SHAPE
            // USER 'clipped()' for a SQUARE SHAPE
    }
}

// ADD 'CornerRotateModifier' AS AN EXTENSION FOR 'AnyTransition' Protocol
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            // THE ACTIVE MODIFIER VALUES
            active: CornerRotateModifier(amount: -90, anchor: .bottom),
            // THE NON ACTIVE MODIFIER VALUES
            identity: CornerRotateModifier(amount: 0, anchor: .bottom)
        )
    }
}

// MAIN CONTENT VIEW
struct ContentView: View {
    
    // PROGRAM STATE PROPERTY
    @State private var showRed = false
    
    var body: some View {
        
        ZStack {
                
            // RECTANGLE VIEW
            Circle()
                .fill(.indigo)
                .frame(width: 200, height: 200)
            
            
            // IF 'showRed' PROGRAM STATE PROPERTY IS 'true'
            if showRed {
                Circle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                
                    // OUR CUSTOM 'pivot' TRANSITION FX
                    .transition(.pivot)
            }
            
        }
        // TAP GESTURE VIEW MODIFIER ATTACHED TO THE ZSTACK VIEW
        .onTapGesture {
            // "EXPLICIT ANIMATION" OCCURS ON EACH USER TAP INPUT
            // CHANGES THE PROGRAM STATE OF 'showRed'
            withAnimation {
                // TOGGLE 'showRed' PROGRAM STATE ON EACH USER TAP INPUT
                showRed.toggle()
            }
        }
        
    }
    
}
*/



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
