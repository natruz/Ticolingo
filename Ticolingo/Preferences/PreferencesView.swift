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

    @ObservedObject var colors: ColorManager = .shared

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
                ColorPicker("Primary Text Colour \n\(colors.primaryTextColour.description)", selection: .init(get: {
                    colors.primaryTextColour
                }, set: {
                    colors.primaryTextColour = $0
                }))
                ColorPicker("Secondary Text Colour \n\(colors.secondaryTextColour.description)", selection: .init(get: {
                    colors.secondaryTextColour
                }, set: {
                    colors.secondaryTextColour = $0
                }))
                ColorPicker("Tertiary Text Colour \n\(colors.tertiaryTextColour.description)", selection: .init(get: {
                    colors.tertiaryTextColour
                }, set: {
                    colors.tertiaryTextColour = $0
                }))
                ColorPicker("Background Colour \n\(colors.backgroundColour.description)", selection: .init(get: {
                    colors.backgroundColour
                }, set: {
                    colors.backgroundColour = $0
                }))
                ColorPicker("Primary Filler Colour \n\(colors.primaryFillerColour.description)", selection: .init(get: {
                    colors.primaryFillerColour
                }, set: {
                    colors.primaryFillerColour = $0
                }))
                ColorPicker("Secondary Filler Colour \n\(colors.secondaryFillerColour.description)", selection: .init(get: {
                    colors.secondaryFillerColour
                }, set: {
                    colors.secondaryFillerColour = $0
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
