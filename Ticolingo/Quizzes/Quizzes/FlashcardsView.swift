//
//  FlashcardsView.swift
//  Ticolingo
//
//  Created by T Krobot on 29/10/22.
//

import SwiftUI

struct FlashcardsView: QuizProtocolView {

    @State var total: Int
    @State var completed: Int
    @State var wrong: Int? = nil
    @State var correct: Int? = nil
    @State var questions: [Question]
    @State var randomised: Bool
    @State var attempts: [Question : (Int, Int)]

    @State var statsToShow: [Stat] = [ .total, .completed ]

    @State var knownQuestions: [Question] = []
    @State var unknownQuestions: [Question] = []

    @State var isCorrect: Bool?

    init(options: [Question], randomised: Bool = false) {
        self._total = State(initialValue: options.count)
        self._completed = State(initialValue: 0)
        self._questions = State(initialValue: randomised ? options.shuffled() : options)
        self._knownQuestions = State(initialValue: [Question]())
        self._unknownQuestions = State(initialValue: [Question]())
        self._randomised = State(initialValue: randomised)
        self._attempts = State(initialValue: [:])
    }

    @State var cardOffset: CGSize = .zero
    @State var cardScale: CGSize = .one
    
    var body: some View {
        VStack {
            if completed < total {
                HStack {
                    stats
                }
                .padding(.horizontal, 10)

                // The actual card
                Spacer()
                ZStack {
                    SingleFlipCardView(front: $questions[completed].question,
                                       back: $questions[completed].answer)
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
            } else { // completion screen
                endView
            }
        }
        .navigationTitle("Flashcards")
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
        unknownQuestions.append(questions[completed])
        attempts[questions[completed]] = (0, 1)
        let screenSize = UIScreen.main.bounds
        let goAwayCardPos = CGSize(width: screenSize.width/4-20, height: screenSize.height/2-70)
        let scale = min(CGFloat(1), CGFloat(100)/goAwayCardPos.height)
        goNextCard(dismissLocation: goAwayCardPos, dismissSize: .init(width: scale, height: scale))
    }

    func markCardAsKnown() {
        guard !isAnimating else { return }
        knownQuestions.append(questions[completed])
        attempts[questions[completed]] = (1, 1)
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
            completed += 1
            cardOffset = .zero
            withAnimation(.easeInOut(duration: 0.2)) {
                cardScale = .one
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isAnimating = false
            }
        }
    }

    @Environment(\.presentationMode) var presentationMode
    func exit() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func restart() {
        completed = 0
        knownQuestions = []
        unknownQuestions = []
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
