//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import Foundation
import SwiftUI

// MAKE 'Color' EXTENSION AS 'ShapeStyle' PROTOCOL
// ONLY WHEN THE EXTENSION IT'Self' IS BEING USED AS A 'Color'
extension ShapeStyle where Self == Color {
    // DARK BACKGROUND COLOR
    static var darkBG: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    // LIGHT BACKGROUND COLOR
    static var lightBG: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
