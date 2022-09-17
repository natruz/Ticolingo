//
//  ContentView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject
    var studyGroups: StudyGroups = .shared
    
    init() {
        UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(studyGroups.studyGroups) { studyGroup in
                        Section(header: SectionHeader(name: studyGroup.name)) {
                            ForEach(studyGroup.sets) { studyset in
                                NavigationLink(destination: StudySetDetailView(set: studyset)) {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
