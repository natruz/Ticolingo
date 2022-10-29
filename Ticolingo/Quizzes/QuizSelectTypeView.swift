//
//  QuizSelectTypeView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 22/10/22.
//

import SwiftUI

struct QuizSelectTypeView: View {

    @State var vocab: [Vocab]
    @Binding var questions: [Question]

    @State var questionFormat: String = "Character"
    @State var answerFormat: String = "PinYin"

    let qnaFormatOptions = [
        "Character",
        "PinYin",
        "Definition"
    ]

    var body: some View {
        VStack {
            Picker("Question Format", selection: $questionFormat, content: {
                ForEach(qnaFormatOptions, id: \.self) { format in
                    Text(format)
                }
            })
            .pickerStyle(.menu)
        }
        .onChange(of: questionFormat) { _ in
            if questionFormat == answerFormat {
                let questionIndex = qnaFormatOptions.firstIndex(of: questionFormat)!
                let newIndex = (questionIndex+1) % qnaFormatOptions.count
                answerFormat = qnaFormatOptions[newIndex]
            }
            changeQuestions()
        }

        VStack {
            Picker("Answer Format", selection: $answerFormat, content: {
                ForEach(qnaFormatOptions, id: \.self) { format in
                    Text(format)
                }
            })
            .pickerStyle(.menu)
        }
        .onChange(of: answerFormat) { _ in
            if questionFormat == answerFormat {
                let questionIndex = qnaFormatOptions.firstIndex(of: answerFormat)!
                let newIndex = (questionIndex+1) % qnaFormatOptions.count
                questionFormat = qnaFormatOptions[newIndex]
            }
            changeQuestions()
        }
        .onAppear {
            changeQuestions()
        }
    }

    func changeQuestions() {
        guard questionFormat != answerFormat else { return }

        questions = []
        questions = vocab.map { vocab in
            var question = "unknown question"
            var answer = "unknown answer"

            switch questionFormat {
            case "Character":
                question = vocab.term
            case "PinYin":
                question = vocab.pinyin
            case "Definition":
                question = vocab.definition
            default: break
            }

            switch answerFormat {
            case "Character":
                answer = vocab.term
            case "PinYin":
                answer = vocab.pinyin
            case "Definition":
                answer = vocab.definition
            default: break
            }

            return Question(question: question, answer: answer)
        }
    }
}

struct QuizSelectTypeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            QuizSelectTypeView(vocab: [
                Vocab(term: "高兴", definition: "happy", exampleSentence: "我很高兴认识你。", difficulty: 0),
                Vocab(term: "快乐", definition: "happiness", exampleSentence: "小学的时候我很快乐。", difficulty: 0),
            ],
                               questions: .constant([]))
        }
    }
}
