//
//  NewStudySetGroupView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct NewStudySetGroupView: View {

    @ObservedObject
    var studyGroups: StudyGroups = .shared

    @Environment(\.presentationMode) var presentationMode

    @State var studyGroupName: String = ""
    @State var studySets: [StudySet] = []
    @State var isEditable: Bool = true

    @State private var showAddStudySet: Bool = false

    var body: some View {
        List {
            Section {
                TextField(text: $studyGroupName) {
                    Text("Name of Study Group")
                }
                Toggle(isOn: $isEditable) {
                    Text("Is Editable")
                }
            }

            Section(header: ColText("Study Sets")) {
                ForEach(studySets) { studySet in
                    VStack {
                        Text(studySet.title)
                    }
                }
                HStack {
                    Spacer()
                    Button {
                        showAddStudySet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showAddStudySet) {
            NewStudySetView(studySets: $studySets)
        }

        Button("Create Study Group") {
            studyGroups.studyGroups.append(StudySetGroup(name: studyGroupName,
                                                         sets: studySets,
                                                         editable: isEditable))
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(studyGroupName.isEmpty)
    }
}

struct NewStudySetGroupView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("HI")
        }
        .sheet(isPresented: .constant(true)) {
            NewStudySetGroupView()
        }
    }
}
