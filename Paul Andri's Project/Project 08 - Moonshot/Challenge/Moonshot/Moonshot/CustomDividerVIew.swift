//
//  CustomDividerVIew.swift
//  Moonshot
//
//  Created by Paul Andri on 08/02/2022.
//

import SwiftUI

// PART OF DAY 42 - CHALLENGE #2
struct CustomDividerVIew: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBG)
            .padding(.vertical)
    }
}

struct CustomDividerVIew_Previews: PreviewProvider {
    static var previews: some View {
        CustomDividerVIew()
    }
}
