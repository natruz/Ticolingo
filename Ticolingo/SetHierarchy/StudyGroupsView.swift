//
//  StudyGroupsView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import SwiftUI

struct StudyGroupsView: View {

    @ObservedObject var studyGroups: StudyGroups = .shared
    @ObservedObject var colors: ColorManager = .shared

    @State var showEditGroups: Bool = false
    @State var showDefault: Bool = UIDevice.current.userInterfaceIdiom == .pad

    var body: some View {
        VStack {
            NavigationLink(destination: {
                VStack {
                    Text("No Study Group Selected")
                        .font(Font.system(Font.TextStyle.largeTitle))
                    Spacer()
                        .frame(height: 20)
                    Text("Choose one from the sidebar")
                }
            }(), isActive: $showDefault, label: {})
            List {
                ForEach(studyGroups.studyGroups) { studyGroup in
                    Section(header: SectionHeader(studyGroup: studyGroup)) {
                        ForEach(studyGroup.sets) { studyset in
                            NavigationLink(destination: StudySetView(set: studyset)) {
                                Text(studyset.title)
                                    .foregroundColor(colors.tertiaryTextColour)
                            }
                            .listRowBackground(colors.secondaryFillerColour)
                            .deleteDisabled(!studyGroup.editable)
                            .moveDisabled(!studyGroup.editable)
                            .contextMenu {
                                if studyGroup.editable {
                                    Button("Delete", role: .destructive) {
                                        studyGroups.studyGroups.removeAll(where: { $0.id == studyGroup.id })
                                    }
                                }
                            }
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

    @ObservedObject
    var colors: ColorManager = .shared

    var body: some View {
        HStack {
            SecTitle(studyGroup.name)
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

