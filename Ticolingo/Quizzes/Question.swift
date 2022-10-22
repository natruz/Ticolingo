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

    var question: String = ""
    var answer: String = ""
    var id = UUID()

    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }

    static func initFromDict(dict: Dictionary<String, String>) -> [Question] {
        return dict.map {
            Question(question: $0.key, answer: $0.value)
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
