//
//  SingleFlipCardView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 22/10/22.
//

import SwiftUI

struct SingleFlipCardView: View {
    // front and back need to be bindings because when the view is created,
    // these values may not have been filled out yet and may simply be placeholders.
    // As state variables update unreliably across views, these must be binding.
    @Binding var front: String
    @Binding var back: String
    @State var duration: CGFloat = 0.4

    @State var amount: CGFloat = 0
    @State var flipToBack = false

    var body: some View {
        ZStack {
            if flipToBack ? amount <= 90 : amount < 90 {
                Color.green
                    .cornerRadius(15)
                Text(front)
            } else {
                Color.purple
                    .cornerRadius(15)
                Text(back)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .onTapGesture {
            flipToBack = amount < 90
            withAnimation(.easeIn(duration: duration/2)) {
                amount = 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: duration/2)) {
                    amount = flipToBack ? 180 : 0
                }
            }
        }
        .rotation3DEffect(.degrees(amount), axis: (x: 0, y: 1, z: 0))
    }
}

struct SingleFlipCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleFlipCardView(front: .constant("hi"), back: .constant("bye"))
            .frame(width: 150, height: 200)
    }
}
