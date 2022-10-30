//
//  FlashcardsView.swift
//  Ticolingo
//
//  Created by T Krobot on 29/10/22.
//

import SwiftUI

struct FlashcardsView: View {
    
    let options: [Question]
    @State var questionNumber = 0
    @State var currentQuestion: Question = Question(question: emptyIdentifier,
                                                    answer: emptyIdentifier)
        
    init(options: [Question]) {
        self.options = options.shuffled()
    }
    
    var body: some View {
        if questionNumber < options.count {
            VStack {
                stats
                Spacer()
                if currentQuestion.question != emptyIdentifier {
                    SingleFlipCardView(front: $currentQuestion.question,
                                       back: $currentQuestion.answer)
                }
                Spacer()
                    .frame(width: 5, height: 30)
                HStack {
                    Button {
                        questionNumber -= 1
                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    Spacer()
                    Button {
                        questionNumber += 1
                        if questionNumber < options.count {
                            self.currentQuestion = options[questionNumber]
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                }
            }
            .onAppear {
                self.currentQuestion = options[questionNumber]
            }
            .frame(width: 250, height: 400)
        } else {
            HStack {
                Spacer()
                ZStack {
                    VStack {
                        stats
                    }
                    .frame(width: 200)
                    VStack {
                        Button("Restart") {
                            withAnimation {
                                restart()
                            }
                        }
                        .padding(.bottom, 20)
                        Button("Exit") {
                            // TODO: Exit
                        }
                    }
                    .offset(y: 200)
                }
                Spacer()
            }
        }
    }
    
    func restart() {
        
    }
    
    @ViewBuilder
    var stats: some View {
        VStack {
            ZStack {
                Color.cyan
                    .frame(height: 50)
                    .cornerRadius(10)
                    .opacity(0.5)
                HStack {
                    Text("Left")
                        .padding(.bottom, 0)
                    Text("\(options.count-questionNumber)")
                        .font(.system(size: 30))
                }
            }
        }
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView(options: [
            Question(question: "who is the best team", answer: "ticolingo"),
            Question(question: "who is the best team2", answer: "ticolingo"),
            Question(question: "who is the best team3", answer: "ticolingo"),
            Question(question: "who is the best team4", answer: "ticolingo"),
            Question(question: "who is the best team5", answer: "ticolingo"),
        ])
    }
}

