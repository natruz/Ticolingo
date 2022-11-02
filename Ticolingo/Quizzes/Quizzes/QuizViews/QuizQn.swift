//
//  QuizQn.swift
//  Ticolingo
//
//  Created by T Krobot on 2/11/22.
//

struct AQuestion {
    var qn: String
    var options: [String]
    var word: String
    var answer: Int
}

let Quiz = [
    AQuestion(qn: "What is the definition of: ", options:["Happy", "Sad", "Angry", "Disappointed"], word: "开心", answer: 1),
    AQuestion(qn: "What is the definition of: ", options: ["Delighted", "Excited", "Sad", "Disappointed"], word: "伤心", answer: 2),
]
