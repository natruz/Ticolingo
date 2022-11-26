//
//  Question.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

// in case there is the need for a question to be empty, use emptyIdentifier to denote both the question and answer.
let emptyIdentifier = UUID().uuidString

class Question: Hashable, Identifiable {

    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.question == rhs.question && lhs.answer == rhs.answer
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(question)
        hasher.combine(answer)
    }

    var id = UUID()

    var question: String = ""
    var answer: String = ""

    var questionType: QAType = .unspecified
    var answerType: QAType = .unspecified

    var isEmpty: Bool {
        self.answer == emptyIdentifier || self.question == emptyIdentifier
    }

    init(question: String,
         answer: String,
         questionType: QAType = .unspecified,
         answerType: QAType = .unspecified) {
        self.question = question
        self.answer = answer
        self.questionType = questionType
        self.answerType = answerType
    }

    static func empty() -> Question { Question(question: emptyIdentifier, answer: emptyIdentifier) }
}

enum QAType: CaseIterable {
    case character
    case pinYin
    case definition
    case unspecified
    
    static var allRealCases: [QAType] {
        allCases.filter({ $0 != .unspecified })
    }

    public func questionUsingFormatFor(text: String) -> String {
        switch self {
        case .character:    return "What is the character for \"\(text)\"?"
        case .pinYin:       return "What is the pinYin for \"\(text)\"?"
        case .definition:   return "What is the definition of \"\(text)\"?"
        case .unspecified:  return text
        }
    }
}

extension Array<Question> {
    var existingCount: Int {
        self.map({ $0.question }).existingCount
    }

    var questions: [String] {
        self.map({ $0.question })
    }

    var answers: [String] {
        self.map({ $0.answer })
    }

    subscript(key: String) -> String? {
        self.first(where: {
            $0.question == key
        })?.answer
    }
}

extension Array<String> {
    var existingCount: Int {
        self.filter({ $0 != emptyIdentifier }).count
    }
}
