//
//  DragAndMatchView.swift
//  dragAndMatch
//
//  Created by TAY KAI QUAN on 13/9/22.
//

import SwiftUI

struct DragAndMatchView: QuizProtocolView {

    @State var total: Int
    @State var completed: Int
    @State var wrong: Int? = 0
    @State var correct: Int? = nil
    @State var questions: [Question]
    @State var randomised: Bool
    @State var statsToShow: [Stat] = [.remaining, .completed, .wrong]
    @State var attempts: [Question : (Int, Int)]
    
    let cardSize: CGFloat = 40.0

    init(options: [Question], randomised: Bool = false) {
        self._total = State(initialValue: options.count)
        self._completed = State(initialValue: 0)
        self._questions = State(initialValue: randomised ? options.shuffled() : options)
        self._randomised = State(initialValue: randomised)
        self._attempts = State(initialValue: [:])
    }

    @State var currentOptions: [Question] = []
    @State var leftArrangement: [Int] = [0, 1, 2, 3, 4]
    @State var rightArrangement: [Int] = [0, 1, 2, 3, 4].shuffled()

    @State var translation: CGSize = .zero
    @State var draggedCard: Question?
    @State var pairedQuestions: [Question] = []

    var body: some View {
        ZStack {
            if completed < total {
                VStack {
                    HStack {
                        stats
                    }
                    .padding(.horizontal, 10)

                    GeometryReader { proxy in
                        actions

                        Color.white
                            .opacity(0.000001)
                            .gesture(makeDragGesture(size: proxy.size))
                    }
                }
            } else {
                endView
            }
        }
        .navigationTitle("Drag and Match")
    }

    @ViewBuilder
    var actions: some View {
        GeometryReader { proxy in
            ZStack { // this is so that the left options are on top of the right options when dragged
                // right options
                HStack {
                    Spacer()
                        .frame(width: proxy.size.width/5*3.5)
                    VStack {
                        ForEach(rightArrangement, id: \.self) { optionIndex in
                            if currentOptions.count == rightArrangement.count {
                                SingleFlipCardView(front: .constant(currentOptions[optionIndex].answer),
                                                   back: .constant(""),
                                                   frontColor: .pink,
                                                   onFlip: { _ in .reject })
                                .opacity(currentOptions[optionIndex].answer == emptyIdentifier ? 0 : (
                                    pairedQuestions.contains(currentOptions[optionIndex]) ? 0 : 1
                                ))
                            }
                        }
                    }
                    .offset(x: -10)
                }.onAppear {
                    generateNewOption()
                }
                // left options
                HStack {
                    VStack {
                        ForEach(leftArrangement, id: \.self) { optionIndex in
                            if currentOptions.count == leftArrangement.count {
                                SingleFlipCardView(front: .constant(currentOptions[optionIndex].question),
                                                   back: .constant(""),
                                                   frontColor: .pink,
                                                   onFlip: { _ in .reject })
                                .opacity(currentOptions[optionIndex].question == emptyIdentifier ? 0 : (
                                    pairedQuestions.contains(currentOptions[optionIndex]) ? 0 : 1
                                ))
                                .offset(x: draggedCard == currentOptions[optionIndex] ? translation.width : 0,
                                        y: draggedCard == currentOptions[optionIndex] ? translation.height : 0)
                            }
                        }
                    }
                    .offset(x: 10)
                    Spacer()
                        .frame(width: proxy.size.width/5*3.5)
                }
            }
        }
    }

    func makeDragGesture(size: CGSize) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                // if the gesture started outside the left 1/3, ignore it
                guard gesture.startLocation.x < size.width/3 else { return }

                // update the translation
                self.translation = gesture.translation

                // figure out which card was dragged by the start location
                let selectedIndex = Int(gesture.startLocation.y / (size.height/5))
                self.draggedCard = currentOptions[selectedIndex]
            }
            .onEnded { gesture in

                // only if the x coordinate is on the right 1/3 of the screen, calculate overlap
                if gesture.location.x > size.width/3*2 {
                    // figure out which card it was dragged over
                    let selectedIndex = Int(gesture.location.y / (size.height/5))
                    let overlapCard = currentOptions[rightArrangement[selectedIndex]]
                    if overlapCard == draggedCard {
                        // They answered correctly
                        let existingScore = attempts[overlapCard] ?? (0, 0)
                        attempts[overlapCard] = (existingScore.0, existingScore.1 + 1)
                        withAnimation {
                            pairedQuestions.append(overlapCard)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.draggedCard = nil
                            self.translation = .zero
                            withAnimation {
                                generateNewOption()
                            }
                        }
                        completed += 1
                        return
                    } else {
                        // They answered incorrectly
                        let existingScore = attempts[overlapCard] ?? (0, 0)
                        attempts[overlapCard] = (existingScore.0 + 1, existingScore.1 + 1)
                        wrong = (wrong ?? 0) + 1
                    }
                }

                // default: animate back
                withAnimation(.easeInOut(duration: 0.2)) {
                    translation = .zero
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02, execute: {
                    self.draggedCard = nil
                })
            }
    }

    func generateNewOption() {
        var leftovers = questions.filter { question in
            !pairedQuestions.contains(question) && !currentOptions.contains(question)
        }
        for (index, option) in currentOptions.enumerated() {
            if pairedQuestions.contains(option) {
                guard !leftovers.isEmpty else { return }

                // this index has just been matched, find a new one
                if let newOption = leftovers.randomElement() {
                    leftovers.removeAll(where: { $0 == newOption })
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        withAnimation {
                            currentOptions[index] = newOption
                            // shuffle the order of the answers
                            rightArrangement = rightArrangement.shuffled()
                        }
                    })
                }
            }
        }
        while currentOptions.count < leftArrangement.count {
            // this index has just been matched, find a new one
            if let newOption = leftovers.randomElement() {
                leftovers.removeAll(where: { $0 == newOption })
                withAnimation {
                    currentOptions.append(newOption)
                    // shuffle the order of the answers
                    rightArrangement = rightArrangement.shuffled()
                }
            } else {
                currentOptions.append(.empty())
            }
        }
    }

    func restart() {
        generateNewOption()
        pairedQuestions = []
        attempts = [:]
    }

    @Environment(\.presentationMode) var presentationMode
    func exit() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct DragAndMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DragAndMatchView(options: [
                Question(question: "a", answer: "1"),
                Question(question: "b", answer: "2"),
                Question(question: "c", answer: "3"),
                Question(question: "d", answer: "4"),
                Question(question: "e", answer: "5"),
                Question(question: "f", answer: "6"),
                Question(question: "g", answer: "7"),
                Question(question: "h", answer: "8"),
                Question(question: "i", answer: "9"),
                Question(question: "j", answer: "10"),
                Question(question: "k", answer: "11"),
                Question(question: "l", answer: "12")
            ])
        }
    }
}
