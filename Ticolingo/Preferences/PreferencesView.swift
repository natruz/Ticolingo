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
//            Section(header: SecTitle("Color Scheme Picker")) {
//                ColorPicker("Main Header Color",
//                            selection: $colors.primaryTextColour)
//                ColorPicker("Section Header Color",
//                            selection: $colors.secondaryTextColour)
//                ColorPicker("Body Text Colour",
//                            selection: $colors.tertiaryTextColour)
//                ColorPicker("Background Colour (UNUSED)",
//                            selection: $colors.backgroundColour)
//                ColorPicker("Primary Filler Colour (UNUSED)",
//                            selection: $colors.primaryFillerColour)
//                ColorPicker("List Background Color",
//                            selection: $colors.secondaryFillerColour)
//            }

            themeChooser
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

    @ViewBuilder
    var themeChooser: some View {
        Section(header: SecTitle("Theme")) {
            ForEach(ColorTheme.themes, id: \.name) { theme in
                Button {
                    colors.currentTheme = theme
                } label: {
                    HStack {
                        Image(systemName: theme.name == colors.currentTheme?.name ? "circle.fill" : "circle")
                        VStack(alignment: .center) {
                            Text(theme.name)
                            HStack {
                                Group {
                                    Spacer()
                                    Circle()
                                        .foregroundColor(theme.primaryTextColor)
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                                Group {
                                    Circle()
                                        .foregroundColor(theme.secondaryTextColour)
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                                Group {
                                    Circle()
                                        .foregroundColor(theme.tertiaryTextColour)
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                                Group {
                                    Circle()
                                        .foregroundColor(theme.primaryFillerColour)
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                                Group {
                                    Circle()
                                        .foregroundColor(theme.secondaryFillerColour)
                                        .frame(width: 30, height: 30)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
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
