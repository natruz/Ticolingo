//
//  MemoryCardsView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 22/10/22.
//

import SwiftUI

struct MemoryCardsView: View {

    let options: [Question]
    @State var scores: [Question: Double?]
    @State var currentQAs: [(String, Question)] // 12 elements ONLY
    @State var pastQuestions: [Question]
    @State var selectedQuestion: Question?

    let cardSize: CGFloat = 90.0
    let topBarSize: CGFloat = 50.0

    init(options: [Question]) {
        self.options = options
        let empty: [Double?] = options.map({ _ in nil })
        self.scores = Dictionary(uniqueKeysWithValues: zip(options, empty))
        self.pastQuestions = []
        self.currentQAs = (0..<12).map({ _ in (emptyIdentifier, .empty()) })
        newGridElements()
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ForEach(0..<4) { lineNo in
                    HStack {
                        Spacer()
                        ForEach(0..<3) { colNo in
                            if currentQAs[lineNo * 3 + colNo].1.question != emptyIdentifier {
                                SingleFlipCardView(front: .constant(""),
                                                   back: $currentQAs[lineNo * 3 + colNo].0,
                                                   onFlip: { isOnBack in
                                    print("Callback called")
                                    guard isOnBack else { return .none }
                                    print("Callback going")
                                    if let selectedQuestion = selectedQuestion {
                                        let id = currentQAs[lineNo * 3 + colNo].1.id
                                        if id == selectedQuestion.id {
                                            // MATCH
                                            print("Match")
                                            pastQuestions.append(currentQAs[lineNo * 3 + colNo].1)
                                            currentQAs[lineNo * 3 + colNo] = (emptyIdentifier, .empty())
                                            if let otherIndex = currentQAs.firstIndex(where: { $0.1.id == id }) {
                                                currentQAs[otherIndex] = (emptyIdentifier, .empty())
                                            }
                                            return .none
                                        } else {
                                            // NO MATCH
                                            print("No Match")
                                            self.selectedQuestion = nil
                                            return .unflipAll
                                        }
                                    } else {
                                        // None selected
                                        print("None selected")
                                        self.selectedQuestion = currentQAs[lineNo * 3 + colNo].1
                                        return .exclusive
                                    }
                                })
                                .frame(width: geometry.size.width/3-10, height: geometry.size.height/4-20)
                            } else {
                                Spacer()
                                    .frame(width: geometry.size.width/3-10, height: geometry.size.height/4-20)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            newGridElements()
        }
    }

    func newGridElements() {
        var localCurrentQAs = [(String, Question)]()
        // create an array of unselected questions
        var questions = options.filter({ !pastQuestions.contains($0) })

        while localCurrentQAs.count < 12 {
            // if somehow no random element was selected, this means options is empty. Add an empty placeholder.
            guard let randomQuestion = questions.randomElement() else {
                localCurrentQAs.append((emptyIdentifier, .empty()))
                localCurrentQAs.append((emptyIdentifier, .empty()))
                continue
            }

            // remove the question from questions
            questions.removeAll(where: { $0.id == randomQuestion.id })

            // add the question and answer to localCurrentQAs
            localCurrentQAs.append((randomQuestion.answer, randomQuestion))
            localCurrentQAs.append((randomQuestion.question, randomQuestion))
        }

        // randomise the order so that questions and answers are not together
        localCurrentQAs.shuffle()
        self.currentQAs = localCurrentQAs
    }
}

struct MemoryCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCardsView(options: [
            Question(question: "a", answer: "1"),
            Question(question: "b", answer: "2"),
            Question(question: "c", answer: "3"),
//            Question(question: "d", answer: "4"),
//            Question(question: "e", answer: "5"),
//            Question(question: "f", answer: "6"),
//            Question(question: "g", answer: "7"),
//            Question(question: "h", answer: "8"),
//            Question(question: "i", answer: "9"),
//            Question(question: "j", answer: "10"),
//            Question(question: "k", answer: "11"),
//            Question(question: "l", answer: "12"),
        ])
    }
}