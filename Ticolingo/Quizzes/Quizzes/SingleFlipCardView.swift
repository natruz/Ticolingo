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

    @State var frontColor: Color = Color.green
    @State var backColor: Color = Color.purple

    // Taking in a boolean for if it is on the back side (true) or front side (false)
    // returns a behaviour that it should do
    @State var onFlip: (Bool) -> Behaviour = { _ in .none }

    @State var duration: CGFloat = 0.4

    @StateObject var flipManager: CardFlipManager = .shared

    @State var amount: CGFloat = 0
    @State var flipToBack = false

    let id = UUID()

    var body: some View {
        ZStack {
            if flipToBack ? amount <= 90 : amount < 90 {
                frontColor
                    .cornerRadius(15)
                Text(front)
                    .padding(15)
            } else {
                backColor
                    .cornerRadius(15)
                Text(back)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .padding(15)
            }
        }
        .font(.largeTitle)
        .fixedSize(horizontal: false, vertical: false)
        .minimumScaleFactor(0.4)
        .onReceive(flipManager.$allOthersUnflip) { _ in
            if amount != 0 && flipManager.sender != self.id {
                flipToBack = false
                print("Unflipping")
                withAnimation(.easeIn(duration: duration/2)) {
                    amount = 90
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: duration/2)) {
                        amount = flipToBack ? 180 : 0
                    }
                }
            }
        }
        .onTapGesture {
            flipToBack = amount < 90
            switch onFlip(flipToBack) {
            case .exclusive:
                if flipToBack {
                    flipManager.sender = self.id
                    flipManager.allOthersUnflip = true
                    flipManager.objectWillChange.send()
                    flipManager.allOthersUnflip = false
                }
            case .unflip:
                if flipToBack {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation(.easeIn(duration: duration/2)) {
                            amount = 90
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration/2) {
                            withAnimation(.easeOut(duration: duration/2)) {
                                amount = 0
                            }
                        }
                    }
                }
            case .unflipAll:
                if flipToBack {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        flipManager.sender = UUID()
                        flipManager.allOthersUnflip = true
                        flipManager.objectWillChange.send()
                        flipManager.allOthersUnflip = false
                    }
                }
            case .reject:
                return
            default: break
            }
            withAnimation(.easeIn(duration: duration/2)) {
                amount = 90
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + duration/2) {
                withAnimation(.easeOut(duration: duration/2)) {
                    amount = flipToBack ? 180 : 0
                }
            }
        }
        .rotation3DEffect(.degrees(amount), axis: (x: 0, y: 1, z: 0))
    }

    enum Behaviour {
        /// No special behaviour
        case none
        /// When this card is flipped, all other cards will unflip.
        case exclusive
        /// When this card is flipped, it unflips everything including itself after completion.
        case unflipAll
        /// When this card is flipped, it unflips itself after completion.
        case unflip
        /// Does not allow a flip to occur
        case reject
    }
}

struct SingleFlipCardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SingleFlipCardView(front: .constant("hi"), back: .constant("bye"))
                .frame(width: 150, height: 200)
            SingleFlipCardView(front: .constant("really long title please work this is super duper long yay"), back: .constant("def"))
                .frame(width: 150, height: 200)
        }
    }
}

class CardFlipManager: ObservableObject {
    static let shared = CardFlipManager()

    @Published
    var allOthersUnflip: Bool = false {
        didSet {
            print("All others unflip changed")
        }
    }

    @Published
    var sender: UUID = UUID()
}
