//
//  MemoryCardsView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 22/10/22.
//

import SwiftUI

struct MemoryCardsView: QuizProtocolView {

    let cardSize: CGFloat = 90.0
    let topBarSize: CGFloat = 50.0

    @State var total: Int
    @State var completed: Int
    @State var wrong: Int? = 0
    @State var correct: Int? = nil
    @State var questions: [Question]
    @State var randomised: Bool
    @State var attempts: [Question : (Int, Int)]

    @State var statsToShow: [Stat] = [ .total, .completed, .wrong ]

    @State var currentQAs: [(String, Question)] // 12 elements ONLY
    @State var selectedQuestion: Question?
    @State var pastQuestions: [Question]

    init(options: [Question], randomised: Bool = false) {
        self._total = State(initialValue: options.count)
        self._completed = State(initialValue: 0)
        self._questions = State(initialValue: randomised ? options.shuffled() : options)
        self._randomised = State(initialValue: randomised)
        self._attempts = State(initialValue: [:])

        self._pastQuestions = State(initialValue: [])
        self._currentQAs = State(initialValue: (0..<12).map({ _ in
            (emptyIdentifier, .empty())
        }))
        newGridElements()
    }

    var body: some View {
        ZStack {
            if completed < total {
                GeometryReader { geometry in
                    VStack(alignment: .center) {
                        HStack {
                            stats
                        }
                        .padding(.horizontal, 10)
                        ForEach(0..<4) { lineNo in
                            HStack {
                                Spacer()
                                ForEach(0..<3) { colNo in
                                    if currentQAs[lineNo * 3 + colNo].1.question != emptyIdentifier {
                                        SingleFlipCardView(front: .constant(""),
                                                           back: $currentQAs[lineNo * 3 + colNo].0,
                                                           onFlip: { onCardFlip(isOnBack: $0, lineNo: lineNo, colNo: colNo) })
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
            } else {
                endView
            }
        }
        .navigationBarTitle("Memory Cards")
    }

    func onCardFlip(isOnBack: Bool, lineNo: Int, colNo: Int) -> SingleFlipCardView.Behaviour {
        guard isOnBack else {
            // deselect everything if flipped to front
            selectedQuestion = nil
            return .none
        }
        if let selectedQuestion = selectedQuestion {
            let id = currentQAs[lineNo * 3 + colNo].1.id
            if id == selectedQuestion.id {
                // MATCH
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation {
                        pastQuestions.append(currentQAs[lineNo * 3 + colNo].1)
                        currentQAs[lineNo * 3 + colNo] = (emptyIdentifier, .empty())
                        if let otherIndex = currentQAs.firstIndex(where: { $0.1.id == id }) {
                            currentQAs[otherIndex] = (emptyIdentifier, .empty())
                        }
                    }
                }
                // update the attempts and total completed
                let existingScore = attempts[selectedQuestion] ?? (0, 0)
                attempts[selectedQuestion] = (existingScore.0, existingScore.1 + 1)
                self.selectedQuestion = nil
                completed += 1
                return .none
            } else {
                // NO MATCH
                // update the attempts and total wrong
                let existingScore = attempts[selectedQuestion] ?? (0, 0)
                attempts[selectedQuestion] = (existingScore.0 + 1, existingScore.1 + 1)
                self.selectedQuestion = nil
                wrong = (wrong ?? 0) + 1
                return .unflipAll
            }
        } else {
            // None selected
            print("None selected")
            self.selectedQuestion = currentQAs[lineNo * 3 + colNo].1
            return .exclusive
        }
    }

    func newGridElements() {
        var localCurrentQAs = [(String, Question)]()
        // create an array of unselected questions
        var questions = questions.filter({ !pastQuestions.contains($0) })

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

    func restart() {
        self.completed = 0
        self.attempts = [:]
        self.selectedQuestion = nil
        self.pastQuestions = []

        self.currentQAs = (0..<12).map({ _ in (emptyIdentifier, .empty()) })
        newGridElements()
        newGridElements()
    }

    @Environment(\.presentationMode) var presentationMode
    func exit() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct MemoryCardsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MemoryCardsView(options: [
                Question(question: "a", answer: "1"),
                Question(question: "b", answer: "2")
                //            Question(question: "c", answer: "3"),
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
}
