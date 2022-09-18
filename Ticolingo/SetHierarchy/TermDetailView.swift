//
//  TermDetailView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct TermDetailView: View {
    
    @State var term: Vocab

    @State var editing: Bool = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    if editing {
                        TextField("Enter Term", text: $term.term)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .font(.system(size: 30))
                    } else {
                        Text(term.term)
                            .font(.system(size: 30))
                    }
                    Text(term.pinyin)
                        .padding(.top, 3)
                }
                VStack(alignment: .leading) {
                    Text("Definition: ")
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                    if editing {
                        TextField("Enter Definition", text: $term.definition)
                    } else {
                        Text(term.definition)
                    }
                }
                // TODO: Find a way to get example sentences modifiable
                VStack(alignment: .leading) {
                    Text("Example Sentence: ")
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                    ForEach(Array(term.exampleSentences.enumerated()), id: \.offset.self) { index, exampleSentence in
                        Text("\(index + 1). \(exampleSentence)")
                    }
                }
                // TODO: Find a way to get difficulty modifiable
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
        .toolbar {
            ToolbarItem(id: "edit", placement: .navigationBarTrailing) {
                Button(editing ? "Finish" : "Edit") {
                    editing.toggle()
                }
                .disabled(!term.editable)
            }
        }
    }
}

struct TermDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TermDetailView(term: Vocab(term: "中文",
                                       definition: "Chinese",
                                       exampleSentences: ["我的家人都讲中文", "中文是最难的课"],
                                       difficulty: 1))
        }
    }
}
