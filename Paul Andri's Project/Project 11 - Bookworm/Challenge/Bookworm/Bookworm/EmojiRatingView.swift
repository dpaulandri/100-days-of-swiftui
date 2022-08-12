//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Paul Andri on 08/12/2022.
//
// CUSTOM EMOJI RATING VIEW

import SwiftUI

struct EmojiRatingView: View {
    // PROPERTY TO STORE 'Int16' DATA TYPE RATING VALUE
    let rating: Int16
    
    
    // MAIN BODY VIEW PROPERTY
    var body: some View {
        // RETURN A TEXT VIEW BASED ON 'rating' PROPERTY'S VALUE
        switch rating {
        case 1:
            return Text("🗑")
        case 2:
            return Text("☹️")
        case 3:
            return Text("😐")
        case 4:
            return Text("🙂")
        default:
            return Text("🤩")
        }
    }
}



struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        // PASS A DUMMY RATING VALUE
        EmojiRatingView(rating: 3)
    }
}
