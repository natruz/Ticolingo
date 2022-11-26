//
//  ContentView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct ContentView: View {

    @State
    var showTutorial: Bool = false
    
    var body: some View {
        TabView {
            NavigationView {
                StudyGroupsView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Tutorial") {
                                showTutorial.toggle()
                            }
                        }
                    }
            }
            .tabItem {
                Label("Words", systemImage: "character.book.closed.zh")
            }

            NavigationView {
                PreferencesView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .sheet(isPresented: $showTutorial) {
            TutorialView(showThisView: $showTutorial)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
