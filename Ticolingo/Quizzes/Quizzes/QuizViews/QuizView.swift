//
//  QuizView.swift
//  Ticolingo
//
//  Created by T Krobot on 2/11/22.
//

import SwiftUI

struct QuizView: View {
    @State var options: [(Question, [String])]
    @State var questionIndex = 0
    @State var correctQuestions = [Question]()
    @State var wrongQuestions = [Question]()

    @State var isCorrect: Bool?

    init(options: [Question]) {
        let allAnswers = options.map { $0.answer }

        self.options = options.map { option in
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
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in VStack {
                if questionIndex < options.count {
                    HStack {
                        stats
                    }

                    // question
                    // this view reuses the single flip card view for its auto
                    // resizing text. It does not flip.
                    SingleFlipCardView(front: .constant(options[questionIndex].0.questionType
                        .questionUsingFormatFor(text: options[questionIndex].0.question)),
                                       back: .constant(""),
                                       frontColor: .clear,
                                       onFlip: { _ in .reject })
                    .frame(height: geometry.size.height/2)

                    // answer options
                    VStack {
                        ForEach(0..<options[questionIndex].1.count, id: \.self) { index in
                            buttonForOption(optionNo: index)
                                .padding(4)
                        }
                    } // no need to set the frame here since it'll automatically fill the
                    // rest of the view
                } else {
                    VStack {
                        stats
                            .frame(width: geometry.size.width/2)
                    }
                    .frame(maxWidth: .infinity)
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
                    SingleFlipCardView(front: .constant(options[questionIndex].0.answer),
                                       back: .constant(""),
                                       frontColor: .clear,
                                       onFlip: { _ in .reject })
                    .frame(height: 80)
                    Button("Next Question") {
                        self.isCorrect = nil
                        self.questionIndex += 1
                    }
                    .padding(20)
                    .buttonStyle(.borderedProminent)
                }
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
                Text("\(options.count-questionIndex)")
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
                Text("\(questionIndex)")
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
                Text("\(wrongQuestions.count)")
                    .font(.system(size: 30))
            }
        }
        Spacer()
            .frame(width: 10)
    }

    @ViewBuilder
    func buttonForOption(optionNo: Int) -> some View {
        Button {
            if options[questionIndex].0.answer == options[questionIndex].1[optionNo] { // correct
                correctQuestions.append(options[questionIndex].0)
                isCorrect = true
            } else { // wrong
                wrongQuestions.append(options[questionIndex].0)
                isCorrect = false
            }
        } label: {
            Text("\(options[questionIndex].1[optionNo])")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(buttonColors[optionNo])
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 10)
        }
    }

    // this arrangement theoretically allows up to 6 options
    let buttonColors: [Color] = [.red, .yellow, .green, .blue, .orange]
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(options: [Question(question: "a", answer: "1", questionType: .character, answerType: .pinYin),
                           Question(question: "b", answer: "2", questionType: .character, answerType: .pinYin),
                           Question(question: "c", answer: "3", questionType: .character, answerType: .pinYin),
                           Question(question: "d", answer: "4", questionType: .character, answerType: .pinYin),
                           Question(question: "e", answer: "5", questionType: .character, answerType: .pinYin)])
    }
}
