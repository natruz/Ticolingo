//
//  MemoryCardsView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 22/10/22.
//

import SwiftUI

struct MemoryCardsView: View {

    let options: [Question]
    @State var scores: [Question: Double]
    @State var currentQAs: [(String, Question)] // 12 elements ONLY
    @State var pastQuestions: [Question]
    @State var selectedQuestion: Question?
    @State var wrongAnswers: Int = 0

    let cardSize: CGFloat = 90.0
    let topBarSize: CGFloat = 50.0

    init(options: [Question]) {
        self.options = options
        let empty: [Double] = options.map({ _ in 0 })
        self.scores = Dictionary(uniqueKeysWithValues: zip(options, empty))
        self.pastQuestions = []
        self.currentQAs = (0..<12).map({ _ in (emptyIdentifier, .empty()) })
        newGridElements()
    }

    var body: some View {
        if pastQuestions.count < options.count {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    HStack {
                        stats
                    }
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
                        NavigationLink("Finish") {
                            QuizResultsView(scores: scores)
                        }
                    }
                    .offset(y: 200)
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    var stats: some View {
        Spacer()
            .frame(width: 10)
        ZStack {
            Color.cyan
                .frame(height: 50)
                .cornerRadius(10)
                .opacity(0.5)
            HStack {
                Text("Left")
                    .padding(.bottom, 0)
                Text("\(options.count-pastQuestions.count)")
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
                Text("\(pastQuestions.count)")
                    .font(.system(size: 30))
            }
        }

        ZStack {
            Color.indigo
                .frame(height: 50)
                .cornerRadius(10)
                .opacity(0.5)
            HStack {
                Text("Wrong")
                    .padding(.bottom, 0)
                Text("\(wrongAnswers)")
                    .font(.system(size: 30))
            }
        }
        Spacer()
            .frame(width: 10)
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
                withAnimation {
                    pastQuestions.append(currentQAs[lineNo * 3 + colNo].1)
                    currentQAs[lineNo * 3 + colNo] = (emptyIdentifier, .empty())
                    if let otherIndex = currentQAs.firstIndex(where: { $0.1.id == id }) {
                        currentQAs[otherIndex] = (emptyIdentifier, .empty())
                    }
                }
                // Turn the scores into usable doubles instead of Integers
                // Before they're matched, they're in the form of integers representing how many
                // failed tries have occured. This equation takes the reciprocal of it as the
                // final percentage.
                let timesAttempted = (scores[selectedQuestion] ?? 0) + 1
                scores[selectedQuestion] = 1/timesAttempted

                // Load new grid elements if all have been used up
                if currentQAs.filter({ $0.1.question != emptyIdentifier }).count == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation {
                            newGridElements()
                        }
                    }
                }
                self.selectedQuestion = nil
                return .none
            } else {
                // NO MATCH
                wrongAnswers += 1
                scores[selectedQuestion] = (scores[selectedQuestion] ?? 0) + 1
                self.selectedQuestion = nil
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

    func restart() {
        let empty: [Double] = options.map({ _ in 0 })
        self.scores = Dictionary(uniqueKeysWithValues: zip(options, empty))
        self.pastQuestions = []
        self.currentQAs = (0..<12).map({ _ in (emptyIdentifier, .empty()) })
        self.wrongAnswers = 0
        newGridElements()
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
