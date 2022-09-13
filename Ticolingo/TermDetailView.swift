//
//  TermDetailView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct TermDetailView: View {
    
    @State var term: Vocab
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("Definition: ")
                            .foregroundColor(.gray)
                            .padding(.bottom, 1)
                        Text(term.definition)
                    }
                    VStack(alignment: .leading) {
                        Text("Example Sentence: ")
                            .foregroundColor(.gray)
                            .padding(.bottom, 1)
                        Text(term.exampleSentence)
                    }
                    VStack(alignment: .leading) {
                        Text("Difficulty: \(term.difficulty)/7")
                            .foregroundColor(.gray)
                            .padding(.bottom, 1)
                        HStack {
                            ForEach(0..<term.difficulty, id: \.self ) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            ForEach(term.difficulty..<7, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                Section {
                    VStack(alignment: .leading) {
                        Text("How familiar are you with this word?")
                            .padding(.bottom, 1)
                    }
                    HStack {
                        Spacer()
                        Button {
                            print("sad")
                            term.familiarity = false
                        } label: {
                           Text("☹️")
                                .font(.title)
                                .padding()
                                .background(.red)
                                .cornerRadius(15)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        Button {
                            print("happy")
                            term.familiarity = true
                        } label: {
                           Text("😃")
                                .font(.title)
                                .padding()
                                .background(.green)
                                .cornerRadius(15)
                        }
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }
                }
            }
            .navigationTitle(term.term)
        }
    }
}

struct TermDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TermDetailView(term: Vocab(term: "a", definition: "b", exampleSentence: "c", difficulty: 4))
    }
}
