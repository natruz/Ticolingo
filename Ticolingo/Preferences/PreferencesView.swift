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
            Section {
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
            Section("Color Scheme Picker") {
                ColorPicker("Primary Text Colour \(primaryTextColour.description)", selection: .init(get: {
                    primaryTextColour
                }, set: {
                    primaryTextColour = $0
                }))
                ColorPicker("Secondary Text Colour \(secondaryTextColour.description)", selection: .init(get: {
                    secondaryTextColour
                }, set: {
                    secondaryTextColour = $0
                }))
                ColorPicker("Tertiary Text Colour \(tertiaryTextColour.description)", selection: .init(get: {
                    tertiaryTextColour
                }, set: {
                    tertiaryTextColour = $0
                }))
                ColorPicker("Background Colour \(backgroundColour.description)", selection: .init(get: {
                    backgroundColour
                }, set: {
                    backgroundColour = $0
                }))
                ColorPicker("Primary Filler Colour \(primaryFillerColour.description)", selection: .init(get: {
                    primaryFillerColour
                }, set: {
                    primaryFillerColour = $0
                }))
                ColorPicker("Secondary Filler Colour \(secondaryFillerColour.description)", selection: .init(get: {
                    secondaryFillerColour
                }, set: {
                    secondaryFillerColour = $0
                }))
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
