//
//  PreferencesView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 18/9/22.
//

import SwiftUI

struct PreferencesView: View {
    @State var showAlert: Bool = false
    @State var confirmProcessType: ProcessType = .none

    enum ProcessType {
        case none
        case resetVocab
        case resetVocabSuccess
    }

    var body: some View {
        List {
            Button(role: .destructive) {
                showAlert = true
                confirmProcessType = .resetVocab
            } label: {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("Reset Vocabulary")
                }
            }
        }
        .navigationTitle("Preferences")
        .alert(isPresented: $showAlert) {
            switch confirmProcessType {
            case .resetVocab:
                return Alert(title: Text("Are you sure you want to reset your Vocabulary? This cannot be undone."),
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("Proceed"), action: {
                    switch confirmProcessType {
                    case .resetVocab:
                        StudyGroups.shared.studyGroups = StudyGroups.shared.addBasicGroups(studyGroups: [])
                        StudyGroups.shared.save(forceSave: true)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.showAlert = true
                            self.confirmProcessType = .resetVocabSuccess
                        }
                    default:
                        break
                    }
                }))
            case .resetVocabSuccess:
                return Alert(title: Text("Reset Complete"))
            default:
                return Alert(title: Text("Alert Error"))
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PreferencesView()
        }
    }
}
