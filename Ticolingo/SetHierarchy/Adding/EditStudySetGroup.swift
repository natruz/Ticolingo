//
//  EditStudySetGroup.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct EditStudySetGroup: View {

    @ObservedObject
    var studyGroups: StudyGroups = .shared

    @State
    var showNewGroups: Bool = false

    var body: some View {
        List {
            Section {
                ForEach($studyGroups.studyGroups) { $studyGroup in
                    HStack {
                        Text(studyGroup.name)
                        Image(systemName: "lock.fill")
                            .opacity(studyGroup.editable ? 0.01 : 1)
                        Spacer()
                        Text("\(studyGroup.sets.count) Sets")
                    }
                    .contextMenu {
                        Button("Duplicate") {
                            guard let index = studyGroups.studyGroups.firstIndex(where: { $0.id == studyGroup.id })
                            else { return }

                            studyGroups.studyGroups.insert(StudySetGroup(name: studyGroup.name,
                                                                         sets: studyGroup.sets.map {
                                StudySet(title: $0.title, terms: $0.terms.map {
                                    Vocab(term: $0.term,
                                          definition: $0.definition,
                                          exampleSentences: $0.exampleSentences,
                                          difficulty: $0.difficulty)
                                })
                            }, editable: studyGroup.editable), at: index+1)
                        }
                        if !studyGroup.editable {
                            Button("Unlock and Duplicate") {
                                guard let index = studyGroups.studyGroups.firstIndex(where: { $0.id == studyGroup.id })
                                else { return }

                                studyGroups.studyGroups.insert(StudySetGroup(name: studyGroup.name,
                                                                             sets: studyGroup.sets.map {
                                    StudySet(title: $0.title, terms: $0.terms.map {
                                        Vocab(term: $0.term,
                                              definition: $0.definition,
                                              exampleSentences: $0.exampleSentences,
                                              difficulty: $0.difficulty)
                                    })
                                }, editable: true), at: index+1)
                            }
                        }
                        Button("Delete", role: .destructive) {
                            studyGroups.studyGroups.removeAll(where: { $0.id == studyGroup.id })
                        }
                    }
                }
                .onDelete { index in
                    studyGroups.studyGroups.remove(atOffsets: index)
                }
                .onMove { index, moveTo in
                    studyGroups.studyGroups.move(fromOffsets: index, toOffset: moveTo)
                }
            }

            Section {
                HStack {
                    Spacer()
                    Button {
                        showNewGroups.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showNewGroups) {
                NewStudySetGroupView()
            }
        }
    }
}

struct EditStudySetGroup_Previews: PreviewProvider {
    static var previews: some View {
        EditStudySetGroup()
    }
}
