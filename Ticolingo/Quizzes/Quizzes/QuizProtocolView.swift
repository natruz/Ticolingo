//
//  QuizProtocolView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 3/11/22.
//

import SwiftUI

protocol QuizProtocolView: View {
    /// The total number of questions in the quiz. MUST BE MARKED `@State`
    var total: Int { get set }
    /// The total number of completed questions in the quiz. MUST BE MARKED `@State`
    var completed: Int { get set }
    /// The total number of wrong questions in the quiz. MUST BE MARKED `@State`
    var wrong: Int? { get set }
    /// The total number of correct questions in the quiz. MUST BE MARKED `@State`
    var correct: Int? { get set }

    /// Which stats to show in the stat screen
    var statsToShow: [Stat] { get set }

    /// The questions for the quiz view
    var questions: [Question] { get set }

    /// If the questions are randomised or not
    var randomised: Bool { get set }

    /// The number of times the user wrongly answers a question to the total attempts made
    var attempts: [Question: (Int, Int)] { get set }

    /// A function that dismisses the view
    func exit()

    /// A function that restarts the quiz
    func restart()
}

enum Stat: CaseIterable {
    /// The number of questions in the quiz
    case total
    /// The number of questions completed in the quiz
    case completed
    /// The remaining questions
    case remaining
    /// How many wrong answers were given
    case wrong
    /// How many correct answers were given
    case correct

    /// The colors for each stat, used in the stats view of ``QuizProtocolView``
    static let colors: [Stat: Color] = [
        .total: Color.orange,
        .completed: Color.indigo,
        .remaining: Color.cyan,
        .wrong: Color.red,
        .correct: Color.green
    ]

    /// The color for the `Stat`, which redirects to the ``colors`` static property of `Stat`.
    var color: Color {
        Stat.colors[self] ?? Color.clear
    }
}

extension QuizProtocolView {
    @ViewBuilder
    /// A stat view, which provides statistics according to the ``statsToShow`` variable.
    /// Does not wrap the stats in a `HStack`, `VStack`, etc. so it is up to the developer
    /// to decide what to wrap it with, when appropriate.
    var stats: some View {
        ForEach(statsToShow, id: \.self) { stat in
            ZStack {
                stat.color
                    .frame(height: 50)
                    .cornerRadius(10)
                    .opacity(0.5)
                HStack {
                    switch stat {
                    case .total:
                        Text("Total")
                            .padding(.bottom, 0)
                        Text("\(total)")
                            .font(.system(size: 30))
                    case .completed:
                        Text("Done")
                            .padding(.bottom, 0)
                        Text("\(completed)")
                            .font(.system(size: 30))
                    case .remaining:
                        Text("Left")
                            .padding(.bottom, 0)
                        Text("\(total-completed)")
                            .font(.system(size: 30))
                    case .wrong:
                        Text("Wrong")
                            .padding(.bottom, 0)
                        Text("\(wrong ?? 0)")
                            .font(.system(size: 30))
                    case .correct:
                        Text("Right")
                            .padding(.bottom, 0)
                        Text("\(correct ?? 0)")
                            .font(.system(size: 30))
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    var endView: some View {
        List {
            Section("Statistics") {
                stats
            }

            Section {
                Button {
                    restart()
                } label: {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .frame(width: 25)
                        Text("Restart")
                    }
                }
                Button {
                    exit()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward.square")
                            .frame(width: 25)
                        Text("Exit")
                    }
                }
                NavigationLink {
                    QuizResultsView(scores: turnAttemptsToScores())
                } label: {
                    HStack {
                        Image(systemName: "list.star")
                            .frame(width: 25)
                        Text("Results")
                    }
                    .foregroundColor(.accentColor)
                }
            }
        }
    }

    private func turnAttemptsToScores() -> [(Question, Double?)] {
        var scores: [(Question, Double?)] = []

        for question in questions {
            if let attempt = attempts[question] {
                scores.append((question, 1 - Double(attempt.0) / Double(attempt.1)))
            }
        }

        return scores
    }
}

private struct TestQuizView: QuizProtocolView {
    @State var total: Int = 0
    @State var completed: Int = 0
    @State var wrong: Int? = 0
    @State var correct: Int? = 0
    @State var statsToShow: [Stat] = [
        .total,
        .completed,
        .remaining,
        .wrong,
        .correct
    ]

    @State var questions: [Question] = [
        Question(question: "HI", answer: "BYE")
    ]
    @State var randomised: Bool = false
    @State var attempts: [Question : (Int, Int)] = [
        Question(question: "HI", answer: "BYE"): (2, 3)
    ]

    @Environment(\.presentationMode) var presentationMode

    func exit() {
        presentationMode.wrappedValue.dismiss()
    }

    func restart() {
        total = 0
        completed = 0
        wrong = 0
        correct = 0
    }

    var body: some View {
//        VStack {
//            stats
//            HStack {
//                VStack {
//                    Button("Increase total") { total += 1 }
//                    Button("Increase completed") { completed += 1 }
//                    Button("Increase wrong") { wrong = (wrong ?? 0) + 1 }
//                    Button("Increase right") { correct = (correct ?? 0) + 1 }
//                }
//                VStack {
//                    Button("Decrease total") { total -= 1 }
//                    Button("Decrease completed") { completed -= 1 }
//                    Button("Decrease wrong") { wrong = (wrong ?? 0) - 1 }
//                    Button("Decrease right") { correct = (correct ?? 0) - 1 }
//                }
//            }
//        }
        endView
            .navigationTitle("HI")
    }
}

struct QuizProtocolView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TestQuizView()
        }
    }
}
