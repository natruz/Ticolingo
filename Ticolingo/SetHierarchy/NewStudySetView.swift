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

    @State var showExamples: Bool = false
    @State var currentTerm: Vocab?

    var body: some View {
        List {
            Section {
                TextField(text: $studySetTitle) {
                    Text("Name of Set")
                }
            }

            Section {
                ForEach($terms) { $term in
                    VStack {
                        TextField(text: $term.term) { Text("Term") }
                        TextField(text: $term.definition) { Text("Definition") }
                        // TODO: Example sentence
                        Picker(selection: $term.difficulty) {
                            ForEach(0..<7) { index in
                                Text("\(index+1)")
                            }
                        } label: {
                            Text("Difficulty")
                        }
                    }
                }

                HStack {
                    Spacer()
                    Button {
                        if  let last = terms.last,
                            last.term.isEmpty &&
                            last.definition.isEmpty &&
                            last.exampleSentences.isEmpty {
                            return
                        }
                        terms.append(Vocab(term: "",
                                           definition: "",
                                           exampleSentences: [],
                                           difficulty: 0))
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
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
