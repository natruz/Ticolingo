//
//  StudyGroupsView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import SwiftUI

struct StudyGroupsView: View {

    @ObservedObject
    var studyGroups: StudyGroups = .shared

    @State
    var showEditGroups: Bool = false

    init() {
        UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
    }

    var body: some View {
        VStack {
            List {
                ForEach(studyGroups.studyGroups) { studyGroup in
                    Section(header: SectionHeader(studyGroup: studyGroup)) {
                        ForEach(studyGroup.sets) { studyset in
                            NavigationLink(destination: StudySetView(set: studyset)) {
                                Text(studyset.title)
                                    .bold()
                                    .foregroundColor(tertiaryTextColour)
                            }
                            .listRowBackground(secondaryFillerColour)
                            .deleteDisabled(!studyGroup.editable)
                            .moveDisabled(!studyGroup.editable)
                        }
                        .onMove(perform: { index, moveTo in
                            studyGroup.sets.move(fromOffsets: index, toOffset: moveTo)
                            print("Tried to move \(index) to \(moveTo)")
                        })
                        .onDelete(perform: { index in
                            studyGroup.sets.remove(atOffsets: index)
                            if studyGroup.sets.isEmpty {
                                studyGroups.studyGroups.removeAll(where: { $0.id == studyGroup.id })
                            }
                            print("Tried to delete \(index)")
                        })
                    }
                }
            }
        }
        .navigationTitle("Study Sets")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditGroups.toggle()
                } label: {
                    Image(systemName: "pencil.circle")
                }
            }
        }
        .sheet(isPresented: $showEditGroups) {
            EditStudySetGroup()
        }
    }
}

struct StudyGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StudyGroupsView()
        }
    }
}

struct SectionHeader: View {
    @State var studyGroup: StudySetGroup

    var body: some View {
        HStack {
            Text(studyGroup.name)
                .foregroundColor(secondaryTextColour)
            if !studyGroup.editable {
                Image(systemName: "lock.fill")
            }
        }
    }
}

struct TestRow: View {
    var body: some View {
        Text("This is a row!")
            .listRowBackground(Color.green)
    }
}

