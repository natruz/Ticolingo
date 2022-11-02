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
                    .padding(.horizontal, 10)

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

                HStack {
                    Spacer()
                    ZStack {
                        SingleFlipCardView(front: .constant("\(knownQuestions.count)"),
                                           back: .constant(""),
                                           onFlip: { _ in .reject })
                            .frame(width: 50, height: 80)
                        Text("Familiar")
                            .offset(y: 55)
                    }
                    Spacer()
                    ZStack {
                        SingleFlipCardView(front: .constant("\(unknownQuestions.count)"),
                                           back: .constant(""),
                                           onFlip: { _ in .reject })
                            .frame(width: 50, height: 80)
                        Text("Unfamiliar")
                            .offset(y: 55)
                    }
                    Spacer()
                }
                .frame(height: 100)
                .background(Color.yellow)
            }
        } else {
            HStack {
                Spacer()
                ZStack {
                    VStack {
                        stats
                    }
                    .frame(width: 200)
                    VStack {
                        Button("Restart") {
                            withAnimation {
                                restart()
                            }
                        }
                        .padding(.bottom, 20)
                        Button("Exit") {
                            // TODO: Exit
                        }
                    }
                    .offset(y: 200)
                }
                Spacer()
            }
        }
    }

    var cardDragGesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                cardOffset = value.translation

                if cardOffset.height > 0 {
                    let scale = min(CGFloat(1), CGFloat(100)/cardOffset.height)
                    cardScale = .init(width: scale, height: scale)
                } else {
                    cardScale = .one
                }
            }
            .onEnded{ value in
                print("Current pos: \(value.location)")
                print("Start pos: \(value.startLocation)")
                print("Screen size: \(UIScreen.main.bounds)")
                if value.translation.height < 50 {
                    withAnimation {
                        cardScale = .one
                        cardOffset = .zero
                    }
                } else if value.velocity.height > 700 || value.translation.height > 300 {
                    var goAwayCardPos = cardOffset
                    let screenSize = UIScreen.main.bounds
                    if value.translation.width > 0 { // right
                        unknownQuestions.append(options[questionNumber])
                        goAwayCardPos = .init(width: screenSize.width/4, height: screenSize.height/2)
                    } else { // left
                        knownQuestions.append(options[questionNumber])
                        goAwayCardPos = .init(width: screenSize.width/(-4), height: screenSize.height/2)
                    }
                    let scale = min(CGFloat(1), CGFloat(100)/goAwayCardPos.height)
                    withAnimation(.easeOut(duration: 0.2)) {
                        cardOffset = goAwayCardPos
                        cardScale = .init(width: scale, height: scale)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        questionNumber += 1
                        cardOffset = .zero
                        withAnimation(.easeInOut(duration: 0.2)) {
                            cardScale = .one
                        }
                    }
                } else {
                    withAnimation {
                        cardOffset = .zero
                    }
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
                Color.cyan
                    .frame(height: 50)
                    .cornerRadius(10)
                    .opacity(0.5)
                HStack {
                    Text("Total")
                        .padding(.bottom, 0)
                    Text("\(options.count)")
                        .font(.system(size: 30))
                }
            }
            ZStack {
                Color.cyan
                    .frame(height: 50)
                    .cornerRadius(10)
                    .opacity(0.5)
                HStack {
                    Text("Done")
                        .padding(.bottom, 0)
                    Text("\(questionNumber)")
                        .font(.system(size: 30))
                }
            }
        }
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView(options: [
            Question(question: "who is the best team", answer: "ticolingo"),
            Question(question: "who is the best team2", answer: "ticolingo"),
            Question(question: "who is the best team3", answer: "ticolingo"),
            Question(question: "who is the best team4", answer: "ticolingo"),
            Question(question: "who is the best team5", answer: "ticolingo"),
        ])
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
