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
                // progress indicator
                ProgressView(value: Double(questionIndex), total: Double(options.count))
                    .scaleEffect(x: 1, y: 4, anchor: .center)
                    .padding()

                // question
                // this view reuses the single flip card view for its auto
                // resizing text. It does not flip.
                SingleFlipCardView(front: $options[questionIndex].0.question,
                                   back: .constant(""),
                                   frontColor: .clear,
                                   onFlip: { _ in .reject })
                    .frame(height: geometry.size.height/2)

                // answer options
                VStack {
                    ForEach(0..<options[questionIndex].1.count, id: \.self) { index in
                        buttonForOption(optionNo: index)
                    }
                } // no need to set the frame here since it'll automatically fill the
                  // rest of the view
            }}
        }
    }

    @ViewBuilder
    func buttonForOption(optionNo: Int) -> some View {
        Button {
            if options[questionIndex].0.answer == options[questionIndex].1[optionNo] { // correct
                correctQuestions.append(options[questionIndex].0)
                questionIndex += 1
            } else { // wrong
                wrongQuestions.append(options[questionIndex].0)
                questionIndex += 1
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
        QuizView(options: [Question(question: "a", answer: "1"),
                           Question(question: "b", answer: "2"),
                           Question(question: "c", answer: "3"),
                           Question(question: "d", answer: "4"),
                           Question(question: "e", answer: "5")])
    }
}
