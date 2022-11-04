//
//  QuizResultsView.swift
//  dragAndMatch
//
//  Created by TAY KAI QUAN on 13/9/22.
//

import SwiftUI

struct QuizResultsView: View {

    var scores: [(Question, Double?)]

    var body: some View {
        List {
            ForEach(scores, id: \.0) { (question, score) in
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(question.question)
                            .font(.system(size: 20))
                        Spacer()
                        Text(question.answer)
                            .font(.system(size: 15))
                            .opacity(0.8)
                        Spacer()
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(
                                score == nil ? Color.gray : Color.red,
                                lineWidth: 10
                            )
                        // turns the Double score into an integer percentage
                        if let score = score {
                            Text("\(Int((score*Double(100)).rounded()))%")
                            Circle()
                                .trim(from: 0, to: score)
                                .stroke(
                                    Color.green,
                                    style: StrokeStyle(
                                        lineWidth: 10,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))
                                .animation(.easeOut, value: score)
                        } else {
                            Text("?")
                        }
                    }
                    .frame(width: 60, height: 60)
                }
            }
        }
        .navigationTitle("Results")
    }
}

struct QuizResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizResultsView(scores: [
                (Question(question: "hi", answer: "bye"), 0.5),
                (Question(question: "hi2", answer: "bye2"), 0.2)
            ])
        }
    }
}

fileprivate func initFromDict(dict: Dictionary<String, String>) -> [Question] {
    return dict.map {
        Question(question: $0.key, answer: $0.value)
    }
}
