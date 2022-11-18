//
//  TermDetailView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct TermDetailView: View {

    @Binding var set: StudySet
    
    @ObservedObject var term: Vocab

    @State var editing: Bool = false

    @ObservedObject var colors: ColorManager = .shared
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    if editing {
                        TextField("Enter Term", text: $term.term)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .foregroundColor(colors.secondaryTextColour)
                            .font(.system(size: 30))
                    } else {
                        Text(term.term)
                            .font(.system(size: 30))
                            .foregroundColor(colors.tertiaryTextColour)
                    }
                    Text(term.pinyin)
                        .foregroundColor(colors.tertiaryTextColour)
                        .padding(.top, 3)
                }
            }

            Section(header: SecTitle("Definitions")) {
                VStack(alignment: .leading) {
                    ForEach(term.definition, id: \.hashValue) { definition in
                        Text(definition.defName)
                        .foregroundColor(colors.tertiaryTextColour)
                        Text(definition.wrappedString)
                            .foregroundColor(colors.tertiaryTextColour)
                            .padding(.bottom, 5)
                    }
                }
            }

            Section(header: SecTitle("Examples")) {
                ForEach(Array(term.exampleSentences.enumerated()), id: \.offset.self) { index, exampleSentence in
                    HStack {
                        Image(systemName: "\(index + 1).circle")
                            .foregroundColor(colors.tertiaryTextColour)
                        Text("\(exampleSentence)")
                            .foregroundColor(colors.tertiaryTextColour)
                        Spacer()
                    }
                }
            }

            Section {
                // TODO: Find a way to get difficulty modifiable
                VStack(alignment: .leading) {
                    Text("Difficulty: \(term.difficulty)/7")
                        .foregroundColor(colors.tertiaryTextColour)
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

                VStack(alignment: .leading) {
                    Text("Are you familiar with this word?")
                        .foregroundColor(colors.tertiaryTextColour)
                        .padding(.bottom, 1)
                }
                HStack {
                    Spacer()
                    Button {
                        print("sad")
                        term.familiarity = false
                        set.objectWillChange.send()
                    } label: {
                        Text("☹️")
                            .font(.title)
                            .padding()
                            .background(.red.opacity(term.familiarity ? 0.5 : 1))
                            .cornerRadius(15)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button {
                        print("happy")
                        term.familiarity = true
                        set.objectWillChange.send()
                    } label: {
                        Text("😃")
                            .font(.title)
                            .padding()
                            .background(.green.opacity(term.familiarity ? 1 : 0.5))
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
            TermDetailView(set: .constant(StudySet(title: "hi", terms: [])),
                           term: Vocab(term: "中文",
                                       definition: "\(noun) Chinese, \(adj) IDK man",
                                       exampleSentences: ["我的家人都讲中文", "中文是最难的课"],
                                       difficulty: 1))
        }
    }
}
