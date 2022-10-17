//
//  DiceView.swift
//  Tesserae
//
//  Created by Paul Andri on 10/17/2022.
//

import SwiftUI

struct DiceView: View {
	@Environment(\.colorScheme) var colorScheme
	
	@State private var diceFace = 6
	@State private var diceValue = 6
	
    var body: some View {
		VStack {
			// DICE FACE ZSTACK
			ZStack {
				RoundedRectangle(cornerRadius: 20)
					.overlay {
						switch colorScheme {
						case .light:
							Color.white
						case.dark:
							Color.red
						default:
							Color.red
						}
					}
					.clipShape(RoundedRectangle(cornerRadius: 20))
					.shadow(color: colorScheme == .dark ? .white.opacity(0.33) : .black.opacity(0.33), radius: 10, y: 10)
				
				Text("\(diceValue)")
					.font(.largeTitle)
					.monospacedDigit()
					.foregroundColor(colorScheme == .light ? .black : .white)
					.scaleEffect(3)
			}
			.frame(width: 200, height: 200)
			//.rotation3DEffect(Angle(degrees: 45), axis: (x: 0, y: 1, z: 0))
			
			// ROLL DICE BUTTON
			Button {
				rollDice()
			} label: {
				Text("Roll")
					.font(.largeTitle)
					.foregroundColor(.white)
					.padding()
					.frame(maxWidth: 200)
					.background(.green)
					.clipShape(RoundedRectangle(cornerRadius: 20))
					.shadow(color: colorScheme == .dark ? .white.opacity(0.33) : .black.opacity(0.33), radius: 10, y: 10)
			}
		}
    }
	
	
	func rollDice() {
		var newDiceValue = Int.random(in: 0...diceFace)
		
		while newDiceValue == diceValue {
			newDiceValue = Int.random(in: 0...diceFace)
		}
		
		diceValue = newDiceValue
	}
}



struct _SidedDiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
