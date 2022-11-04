//
//  QuizView.swift
//  Ticolingo
//
//  Created by T Krobot on 2/11/22.
//

import SwiftUI

struct QuizView: QuizProtocolView {
    @State var total: Int
    @State var completed: Int
    @State var wrong: Int?
    @State var correct: Int?
    @State var questions: [Question]
    @State var randomised: Bool
    @State var attempts: [Question : (Int, Int)]

    @State var statsToShow: [Stat] = [ .total, .completed, .wrong ]

    @State var options: [(Question, [String])]
    @State var correctQuestions: [Question]
    @State var wrongQuestions: [Question]

    @State var isCorrect: Bool?

    init(options: [Question], randomised: Bool = false) {
        self._total = State(initialValue: options.count)
        self._completed = State(initialValue: 0)
        self._questions = State(initialValue: options)
        self._wrong = State(initialValue: 0)
        self._correct = State(initialValue: 0)
        self._correctQuestions = State(initialValue: [Question]())
        self._wrongQuestions = State(initialValue: [Question]())
        self._randomised = State(initialValue: randomised)
        self._attempts = State(initialValue: [:])

        let allAnswers = options.map { $0.answer }

        let optionMap = options.map { option in
            // remove the correct answer from the possible random answers
            // shuffle the possible other answers
            let possibleOtherAnswers = allAnswers.filter({ $0 != option.answer }).shuffled()

            // get the first 3 (or fewer) possible other answers
            // if we asked for exactly 3 other answers, the app would crash if there
            // were fewer than 4 questions, so we need this min function to avoid that.
            var answers = possibleOtherAnswers[0..<min(3, possibleOtherAnswers.count)]

            // add the correct answer, shuffle, and then return
            answers.append(option.answer)
            return (option , answers.shuffled())
        }
        self._options = State(initialValue: randomised ? optionMap.shuffled() : optionMap)

        self.total = self.options.count
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in VStack {
                if completed < options.count {
                    HStack {
                        stats
                    }
                    .padding(.horizontal, 10)

                    // question
                    // this view reuses the single flip card view for its auto
                    // resizing text. It does not flip.
                    ResizableTextView(.constant(options[completed].0.questionType
                        .questionUsingFormatFor(text: options[completed].0.question)))
                        .frame(height: geometry.size.height/2)

                    // answer options
                    VStack {
                        ForEach(0..<options[completed].1.count, id: \.self) { index in
                            buttonForOption(optionNo: index)
                                .padding(4)
                        }
                    } // no need to set the frame here since it'll automatically fill the
                    // rest of the view
                } else {
                    VStack {
                        endView
                        Text("Number: \(options.count)")
                    }
                }
            }}
            if let isCorrect = isCorrect {
                if isCorrect {
                    ZStack {
                        Color.green
                    }
                } else {
                    ZStack {
                        Color.red
                    }
                }

                VStack {
                    Text(isCorrect ? "Correct!" : "Incorrect")
                        .font(.largeTitle)
                    Text("Correct option:")
                        .font(.title2)
                        .padding(20)
                    ResizableTextView(.constant(options[completed].0.answer))
                    .frame(height: 80)
                    Button("Next Question") {
                        self.isCorrect = nil
                        self.completed += 1
                    }
                    .padding(20)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Quiz")
    }

    @ViewBuilder
    func buttonForOption(optionNo: Int) -> some View {
        Button {
            if options[completed].0.answer == options[completed].1[optionNo] { // correct
                correctQuestions.append(options[completed].0)
                attempts[options[completed].0] = (0, 1)
                correct = correctQuestions.count
                isCorrect = true
            } else { // wrong
                wrongQuestions.append(options[completed].0)
                attempts[options[completed].0] = (1, 1)
                wrong = wrongQuestions.count
                isCorrect = false
            }
        } label: {
            ResizableTextView(.constant("\(options[completed].1[optionNo])"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(buttonColors[optionNo])
                .cornerRadius(10)
                .padding(.horizontal, 10)
        }
        .buttonStyle(.plain)
    }

    // this arrangement theoretically allows up to 6 options
    let buttonColors: [Color] = [.red, .yellow, .green, .blue, .orange]

    @Environment(\.presentationMode) var presentationMode
    func exit() {
        presentationMode.wrappedValue.dismiss()
    }

    func restart() {
        completed = 0
        attempts = [:]
        correctQuestions = []
        correct = 0
        wrongQuestions = []
        wrong = 0
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizView(options: [Question(question: "a", answer: "1", questionType: .character, answerType: .pinYin),
                               Question(question: "b", answer: "2", questionType: .character, answerType: .pinYin),
                               Question(question: "c", answer: "3", questionType: .character, answerType: .pinYin),
                               Question(question: "d", answer: "4", questionType: .character, answerType: .pinYin),
                               Question(question: "e", answer: "5", questionType: .character, answerType: .pinYin)])
        }
    }
}
