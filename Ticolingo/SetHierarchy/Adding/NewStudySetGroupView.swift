//
//  NewStudySetGroupView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct NewStudySetGroupView: View {

    @ObservedObject
    var studyGroup: StudySetGroup

    @Environment(\.presentationMode) var presentationMode

    @State private var showAddStudySet: Bool = false

    var body: some View {
        List {
            Section {
                TextField(text: $studyGroup.name) {
                    Text("Name of Study Group")
                        .foregroundColor(ColorManager.shared.tertiaryTextColour)
                }
                Toggle(isOn: $studyGroup.editable) {
                    Text("Is Editable")
                        .foregroundColor(ColorManager.shared.tertiaryTextColour)
                }
            }

            Section(header: SecTitle("Study Sets")) {
                ForEach(studyGroup.sets) { studySet in
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
            NewStudySetView(studySets: $studyGroup.sets)
        }
        .onDisappear {
            StudyGroups.shared.objectWillChange.send()
        }

        Button("Finish") {
            print("\(studyGroup.name) + \(studyGroup.sets) + \(studyGroup.editable)")
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct NewStudySetGroupView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("HI")
        }
        .sheet(isPresented: .constant(true)) {
            NewStudySetGroupView(studyGroup: StudySetGroup(name: "test", sets: []))
        }
    }
}
