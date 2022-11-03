//
//  FlashcardsView.swift
//  Ticolingo
//
//  Created by T Krobot on 29/10/22.
//

import SwiftUI

struct FlashcardsView: View {
    
    @State var options: [Question]
    @State var questionNumber = 0

    @State var knownQuestions: [Question] = []
    @State var unknownQuestions: [Question] = []

    @State var cardOffset: CGSize = .zero
    @State var cardScale: CGSize = .one

    init(options: [Question]) {
        self.options = options // .shuffled()
    }
    
    var body: some View {
        if questionNumber < options.count {
            VStack {
                stats

                // The actual card
                Spacer()
                ZStack {
                    SingleFlipCardView(front: $options[questionNumber].question,
                                       back: $options[questionNumber].answer)
                    .scaleEffect(cardScale)
                    .offset(cardOffset)
                    .opacity(cardScale.height)
                }
                .frame(width: 250, height: 400)
                .gesture(cardDragGesture)
                Spacer()

                // the bottom buttons/indicators
                HStack {
                    Spacer()
                    ZStack {
                        SingleFlipCardView(front: .constant("\(knownQuestions.count)"),
                                           back: .constant(""),
                                           onFlip: { _ in
                            markCardAsKnown()
                            return .reject
                        }).frame(width: 50, height: 80)
                        Text("Familiar")
                            .offset(x: -65)
                    }
                    Spacer()
                    ZStack {
                        SingleFlipCardView(front: .constant("\(unknownQuestions.count)"),
                                           back: .constant(""),
                                           onFlip: { _ in
                            markCardAsUnknown()
                            return .reject
                        }).frame(width: 50, height: 80)
                        Text("Unfamiliar")
                            .offset(x: 75)
                    }
                    Spacer()
                }
                .frame(height: 100)
            }
            .navigationTitle("Flashcards")
            .navigationBarTitleDisplayMode(.inline)
        } else { // completion screen
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    stats
                    Spacer()
                    Button("Restart") {
                        withAnimation {
                            restart()
                        }
                    }
                    .padding(.bottom, 20)
                    NavigationLink("Finish") {
                        Text("Not finished :P")
                    }
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("Flashcards")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var cardDragGesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                cardOffset = value.translation

                // get a new scale for the card proportional to the card's vertical offset
                if cardOffset.height > 0 {
                    let scale = min(CGFloat(1), CGFloat(100)/cardOffset.height)
                    cardScale = .init(width: scale, height: scale)
                } else {
                    cardScale = .one
                }
            }
            .onEnded{ value in
                if value.velocity.height > 700 ||
                    value.translation.height > UIScreen.main.bounds.height/6 {

                    if value.translation.width > 0 { // right
                        markCardAsUnknown()
                    } else { // left
                        markCardAsKnown()
                    }
                } else {
                    withAnimation {
                        cardOffset = .zero
                        cardScale = .one
                    }
                }
            }
    }

    @State var isAnimating: Bool = false

    func markCardAsUnknown() {
        guard !isAnimating else { return }
        unknownQuestions.append(options[questionNumber])
        let screenSize = UIScreen.main.bounds
        let goAwayCardPos = CGSize(width: screenSize.width/4-20, height: screenSize.height/2-70)
        let scale = min(CGFloat(1), CGFloat(100)/goAwayCardPos.height)
        goNextCard(dismissLocation: goAwayCardPos, dismissSize: .init(width: scale, height: scale))
    }

    func markCardAsKnown() {
        guard !isAnimating else { return }
        knownQuestions.append(options[questionNumber])
        let screenSize = UIScreen.main.bounds
        let goAwayCardPos = CGSize(width: screenSize.width/(-4)+20, height: screenSize.height/2-70)
        let scale = min(CGFloat(1), CGFloat(100)/goAwayCardPos.height)
        goNextCard(dismissLocation: goAwayCardPos, dismissSize: .init(width: scale, height: scale))
    }

    // Moves the card to a location and size, then increment the question number
    func goNextCard(dismissLocation: CGSize = .zero, dismissSize: CGSize = .one) {
        isAnimating = true
        withAnimation(.easeOut(duration: 0.2)) {
            cardOffset = dismissLocation
            cardScale = dismissSize
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            questionNumber += 1
            cardOffset = .zero
            withAnimation(.easeInOut(duration: 0.2)) {
                cardScale = .one
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isAnimating = false
            }
        }
    }
    
    func restart() {
        questionNumber = 0
        knownQuestions = []
        unknownQuestions = []
    }
    
    @ViewBuilder
    var stats: some View {
        HStack {
            Spacer().frame(width: 10)

            ZStack {
                Color.cyan
                    .frame(height: 50)
                    .cornerRadius(10)
                    .opacity(0.5)
                HStack {
                    Text("Left")
                        .padding(.bottom, 0)
                    Text("\(options.count-questionNumber)")
                        .font(.system(size: 30))
                }
            }

            ZStack {
                Color.green
                    .frame(height: 50)
                    .cornerRadius(10)
                    .opacity(0.5)
                HStack {
                    Text("Matched")
                        .padding(.bottom, 0)
                    Text("\(questionNumber)")
                        .font(.system(size: 30))
                }
            }

            Spacer().frame(width: 10)
        }
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FlashcardsView(options: [
                Question(question: "who is the best team", answer: "ticolingo"),
                Question(question: "who is the best team2", answer: "ticolingo"),
                Question(question: "who is the best team3", answer: "ticolingo"),
                Question(question: "who is the best team4", answer: "ticolingo"),
                Question(question: "who is the best team5", answer: "ticolingo"),
            ])
        }
    }
}

extension DragGesture.Value {

    /// The current drag velocity.
    ///
    /// While the velocity value is contained in the value, it is not publicly available and we
    /// have to apply tricks to retrieve it. The following code accesses the underlying value via
    /// the `Mirror` type.
    internal var velocity: CGSize {
        let valueMirror = Mirror(reflecting: self)
        for valueChild in valueMirror.children {
            if valueChild.label == "velocity" {
                let velocityMirror = Mirror(reflecting: valueChild.value)
                for velocityChild in velocityMirror.children {
                    if velocityChild.label == "valuePerSecond" {
                        if let velocity = velocityChild.value as? CGSize {
                            return velocity
                        }
                    }
                }
            }
        }

        fatalError("Unable to retrieve velocity from \(Self.self)")
    }

}

extension CGSize {
    static let one: CGSize = .init(width: 1, height: 1)
}
