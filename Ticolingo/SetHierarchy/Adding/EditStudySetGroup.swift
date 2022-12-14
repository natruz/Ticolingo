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

    @State var showNewGroups: Bool = false
    @State var newGroup: StudySetGroup = StudySetGroup(name: "", sets: [])

    @State var showImport: Bool = false

    @State var showExport: Bool = false
    @State var exportedStudyGroup: StudySetGroup? = StudyGroups.shared.studyGroups.first
    @State var prettyExport: Bool = false

    var body: some View {
        List {
            Section {
                ForEach($studyGroups.studyGroups) { $studyGroup in
                    NavigationLink {
                        NewStudySetGroupView(studyGroup: studyGroup)
                    } label: {
                        HStack {
                            Text(studyGroup.name)
                                .foregroundColor(ColorManager.shared.tertiaryTextColour)
                            Image(systemName: "lock.fill")
                                .opacity(studyGroup.editable ? 0.01 : 1)
                            Spacer()
                            Text("\(studyGroup.sets.count) Sets")
                                .foregroundColor(ColorManager.shared.tertiaryTextColour)
                        }
                    }
                    .disabled(!studyGroup.editable)
                    .contextMenu {
                        Button("Export") {
                            exportedStudyGroup = studyGroup
                            showExport = true
                        }
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
            .sheet(isPresented: $showExport) {
                if let exportedStudyGroup {
                    if let export = exportedStudyGroup.export(pretty: prettyExport) {
                        List {
                            Section {
                                VStack(alignment: .leading) {
                                    Toggle("Pretty Formatting", isOn: $prettyExport)
                                    Text("Note: May take a while")
                                        .font(.system(.footnote))
                                }
                            }

                            Section(header: SecTitle("Preview")) {
                                ScrollView(.vertical, showsIndicators: true) {
                                    Text(export)
                                }
                                .frame(height: 160)
                            }

                            Section(header: SecTitle("Export Options")) {
                                Button("Save to Clipboard") {
                                    UIPasteboard.general.string = export
                                    showExport = false
                                }
                            }
                        }
                    } else {
                        Text("Failed to export")
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    }
                } else {
                    Text("No selected study group")
                        .foregroundColor(ColorManager.shared.tertiaryTextColour)
                }
            }

            Section {
                Button("Create New Study Group") {
                    newGroup = StudySetGroup(name: "Untitled Study Set", sets: [])
                    studyGroups.studyGroups.append(newGroup)
                    showNewGroups.toggle()
                }
                Button("Import Study Group") {
                    showImport.toggle()
                }
            }
            .sheet(isPresented: $showNewGroups) {
                NewStudySetGroupView(studyGroup: newGroup)
            }
            .sheet(isPresented: $showImport) {
                ImportStudySetGroupView()
            }
        }
        .onDisappear {
            studyGroups.objectWillChange.send()
        }
    }
}

struct EditStudySetGroup_Previews: PreviewProvider {
    static var previews: some View {
        EditStudySetGroup()
    }
}
