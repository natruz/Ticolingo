//
//  QuizView.swift
//  Ticolingo
//
//  Created by T Krobot on 2/11/22.
//

import SwiftUI

struct QuizView: View {
    @State var questionIndex = 0
    @State var correctans = false
    @State var wrongans = false
    @State var qnCorrect = 0
    @State var isSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                ProgressView(value: Double(questionIndex + 1), total: Double(Quiz.count))
                    .padding()
                
                Text("\(Quiz[questionIndex].qn)")
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
                Spacer()
                HStack {
                    VStack {
                        Text("\(Quiz[questionIndex].word)")
                            .padding()
                            .font(.system(size: 100))
                        Spacer()
                        Button {
                            if Quiz[questionIndex].answer == 0 {
                                correctans = true
                                qnCorrect += 1
                                questionIndex += 1
                            }
                            else {
                                wrongans = true
                                questionIndex += 1
                            }
                        } label: {
                            Text("▲ \(Quiz[questionIndex].options[0])")
                                .frame(width: 280, height: 10)
                                .font(.system(size: 17))
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button {
                            if Quiz[questionIndex].answer == 0 {
                                correctans = true
                                qnCorrect += 1
                                questionIndex += 1
                            }
                            else {
                                wrongans = true
                                questionIndex += 1
                            }
                        } label: {
                            Text("■ \(Quiz[questionIndex].options[1])")
                                .frame(width: 280, height: 10)
                                .font(.system(size: 17))
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button {
                            if Quiz[questionIndex].answer == 0 {
                                correctans = true
                                qnCorrect += 1
                                questionIndex += 1
                            }
                            else {
                                wrongans = true
                                questionIndex += 1
                            }
                        } label: {
                            Text("◆ \(Quiz[questionIndex].options[2])")
                                .frame(width: 280, height: 10)
                                .font(.system(size: 17))
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button {
                            if Quiz[questionIndex].answer == 0 {
                                correctans = true
                                qnCorrect += 1
                                questionIndex += 1
                            }
                            else {
                                wrongans = true
                                questionIndex += 1
                            }
                        } label: {
                            Text("● \(Quiz[questionIndex].options[3])")
                                .frame(width: 280, height: 10)
                                .font(.system(size: 17))
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
    }
    
    struct QuizView_Previews: PreviewProvider {
        static var previews: some View {
            QuizView()
        }
    }
}
