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

    @State var questionFormat: QAType = .character
    @State var answerFormat: QAType = .pinYin

    var body: some View {
        VStack {
            Picker("Question Format", selection: $questionFormat, content: {
                ForEach(QAType.allRealCases, id: \.self) { format in
                    switch format {
                    case .character: Text("Character")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    case .pinYin: Text("PinYin")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    case .definition: Text("Definition")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    default: EmptyView()
                    }
                }
            })
            .pickerStyle(.menu)
        }
        .onChange(of: questionFormat) { _ in
            if questionFormat == answerFormat {
                let questionIndex = QAType.allRealCases.firstIndex(of: questionFormat)!
                let newIndex = (questionIndex+1) % QAType.allRealCases.count
                answerFormat = QAType.allRealCases[newIndex]
            }
            changeQuestions()
        }

        VStack {
            Picker("Answer Format", selection: $answerFormat, content: {
                ForEach(QAType.allRealCases, id: \.self) { format in
                    switch format {
                    case .character: Text("Character")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    case .pinYin: Text("PinYin")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    case .definition: Text("Definition")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    default: EmptyView()
                    }
                }
            })
            .pickerStyle(.menu)
        }
        .onChange(of: answerFormat) { _ in
            if questionFormat == answerFormat {
                let questionIndex = QAType.allRealCases.firstIndex(of: answerFormat)!
                let newIndex = (questionIndex+1) % QAType.allRealCases.count
                questionFormat = QAType.allRealCases[newIndex]
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
            case .character:
                question = vocab.term
            case .pinYin:
                question = vocab.pinyin
            case .definition:
                question = vocab.definition.randomElement()?.asString() ?? "No Definition"
            default: break
            }

            switch answerFormat {
            case .character:
                answer = vocab.term
            case .pinYin:
                answer = vocab.pinyin
            case .definition:
                answer = vocab.definition.randomElement()?.asString() ?? "No Definition"
            default: break
            }

            return Question(question: question,
                            answer: answer,
                            questionType: questionFormat,
                            answerType: answerFormat)
        }
    }
}

struct QuizSelectTypeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            QuizSelectTypeView(vocab: [
                Vocab(term: "高兴", definition: "happy", exampleSentence: "我很高兴认识你。", difficulty: 0),
                Vocab(term: "快乐", definition: "happiness", exampleSentence: "小学的时候我很快乐。", difficulty: 0),
            ], questions: .constant([]))
        }
    }
}
