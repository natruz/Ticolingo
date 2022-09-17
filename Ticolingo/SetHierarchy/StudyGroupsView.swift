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

    init() {
        UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
    }

    var body: some View {
        VStack {
            List {
                ForEach(studyGroups.studyGroups) { studyGroup in
                    Section(header: SectionHeader(name: studyGroup.name)) {
                        ForEach(studyGroup.sets) { studyset in
                            NavigationLink(destination: StudySetView(set: studyset)) {
                                Text(studyset.title)
                                    .bold()
                                    .foregroundColor(tertiaryTextColour)

                            }
                            .listRowBackground(secondaryFillerColour)
                        }
                    }
                }
            }
            .navigationTitle("Study Sets")
        }
    }
}

struct StudyGroupsView_Previews: PreviewProvider {
    static var previews: some View {
        StudyGroupsView()
    }
}

struct SectionHeader: View {
    @State var name: String

    var body: some View {
        Text(name)
            .foregroundColor(secondaryTextColour)
    }
}

struct TestRow: View {
    var body: some View {
        Text("This is a row!")
            .listRowBackground(Color.green)
    }
}

