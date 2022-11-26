//
//  NewStudySetView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct NewStudySetView: View {

    @ObservedObject
    var studyGroup: StudySetGroup

    @ObservedObject
    var studySet: StudySet

    @Environment(\.presentationMode) var presentationMode

    @State var newTerm: Vocab = Vocab(term: "Unnamed Term",
                                      definition: "",
                                      exampleSentences: [],
                                      difficulty: 0)

    @State var showDefinitions: Bool = false

    var body: some View {
        List {
            Section {
                TextField(text: $studySet.title) {
                    Text("Name of Set")
                        .foregroundColor(ColorManager.shared.tertiaryTextColour)
                }
            }

            Section(header: SecTitle("Vocabulary")) {
                ForEach($studySet.terms) { $term in
                    VStack(alignment: .leading) {
                        Text(term.term)
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                        ForEach(term.definition, id: \.hashValue) { definition in
                            Text(definition.wrappedString)
                                .foregroundColor(ColorManager.shared.tertiaryTextColour)
                        }
                        Text("\(term.exampleSentences.count) Examples")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                        Picker(selection: $term.difficulty) {
                            ForEach(0..<7) { index in
                                Text("\(index+1)")
                                    .foregroundColor(ColorManager.shared.tertiaryTextColour)
                            }
                        } label: {
                            Text("Difficulty")
                                .foregroundColor(ColorManager.shared.tertiaryTextColour)
                        }
                    }
                }
                .onMove(perform: { index, moveTo in
                    studySet.terms.move(fromOffsets: index, toOffset: moveTo)
                })
                .onDelete(perform: { index in
                    studySet.terms.remove(atOffsets: index)
                })

                HStack {
                    Spacer()
                    Button {
                        if  let last = studySet.terms.last,
                            last.term.isEmpty &&
                            last.definition.isEmpty &&
                            last.exampleSentences.isEmpty {
                            return
                        }
                        newTerm = Vocab(term: "Unnamed Term",
                                        definition: "",
                                        exampleSentences: [],
                                        difficulty: 0)
                        studySet.terms.append(newTerm)
                        showDefinitions.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
                .sheet(isPresented: $showDefinitions) {
                    NewVocabView(studyGroup: studyGroup,
                                 studySet: studySet,
                                 vocab: newTerm)
                }
            }
        }
        .navigationTitle(studySet.title)
        .onDisappear {
            StudyGroups.shared.objectWillChange.send()
            studyGroup.objectWillChange.send()
        }

        Button("Finish") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct NewStudySetView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

        }
        .sheet(isPresented: .constant(true)) {
            NewStudySetView(studyGroup: StudySetGroup(name: "hi", sets: []),
                            studySet: StudySet(title: "Untitled Study Set", terms: []))
        }
    }
}
