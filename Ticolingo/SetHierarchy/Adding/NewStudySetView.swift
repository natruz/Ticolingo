//
//  NewStudySetView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct NewStudySetView: View {

    @Binding var studySets: [StudySet]

    @Environment(\.presentationMode) var presentationMode

    @State var studySetTitle: String = ""
    @State var terms: [Vocab] = []

    @State var showDefinitions: Bool = false

    var body: some View {
        List {
            Section {
                TextField(text: $studySetTitle) {
                    Text("Name of Set")
                }
            }

            Section(header: ColText("Vocabulary")) {
                ForEach($terms) { $term in
                    VStack(alignment: .leading) {
                        Text(term.term)
                        Text(term.definition)
                        Text("\(term.exampleSentences.count) Examples")
                        Picker(selection: $term.difficulty) {
                            ForEach(0..<7) { index in
                                Text("\(index+1)")
                            }
                        } label: {
                            Text("Difficulty")
                        }
                    }
                }
                .onMove(perform: { index, moveTo in
                    terms.move(fromOffsets: index, toOffset: moveTo)
                })
                .onDelete(perform: { index in
                    terms.remove(atOffsets: index)
                })

                HStack {
                    Spacer()
                    Button {
                        if  let last = terms.last,
                            last.term.isEmpty &&
                            last.definition.isEmpty &&
                            last.exampleSentences.isEmpty {
                            return
                        }
                        showDefinitions.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
                .sheet(isPresented: $showDefinitions) {
                    NewVocabView(terms: $terms)
                }
            }
        }

        Button("Create Study Set") {
            studySets.append(StudySet(title: studySetTitle,
                                      terms: terms.filter({ !$0.term.isEmpty })))
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(studySetTitle.isEmpty)
    }
}

struct NewStudySetView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

        }
        .sheet(isPresented: .constant(true)) {
            NewStudySetView(studySets: .constant([]))
        }
    }
}
