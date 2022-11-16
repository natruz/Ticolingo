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

    @State var showDetail: Bool = false
    @State var detailTheme: ColorTheme = .themes.first! // NOTE: UNRELIABLE

    @ViewBuilder
    var themeChooser: some View {
        Section(header: SecTitle("Theme")) {
            ForEach(ColorTheme.themes, id: \.name) { theme in
                Button {
                    colors.currentTheme = theme
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                            HStack {
                                Circle()
                                    .foregroundColor(theme.primaryTextColor)
                                    .overlay { Circle().stroke(lineWidth: 1) }
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .foregroundColor(theme.secondaryTextColour)
                                    .overlay { Circle().stroke(lineWidth: 1) }
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .foregroundColor(theme.tertiaryTextColour)
                                    .overlay { Circle().stroke(lineWidth: 1) }
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .foregroundColor(theme.primaryFillerColour)
                                    .overlay { Circle().stroke(lineWidth: 1) }
                                    .frame(width: 15, height: 15)
                                Circle()
                                    .foregroundColor(theme.secondaryFillerColour)
                                    .overlay { Circle().stroke(lineWidth: 1) }
                                    .frame(width: 15, height: 15)
                            }
                        }
                        .foregroundColor(Color.primary)
                        Spacer()
                        if theme.name == colors.currentTheme.name {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contextMenu {
                        Button("Show Color Details") {
                            detailTheme = theme
                            showDetail = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showDetail) {
            if #available(iOS 16.0, *) {
                List {
                    ColorText("Main Header Color", color: detailTheme.primaryTextColor)
                    ColorText("Section Header Color", color: detailTheme.secondaryTextColour)
                    ColorText("Body Text Colour", color: detailTheme.tertiaryTextColour)
                    ColorText("Primary Filler Colour (UNUSED)", color: detailTheme.primaryFillerColour)
                    ColorText("List Background Color", color: detailTheme.secondaryFillerColour)
                }
                .presentationDetents([.medium])
            } else {
                // Fallback on earlier versions
                List {
                    ColorText("Main Header Color", color: detailTheme.primaryTextColor)
                    ColorText("Section Header Color", color: detailTheme.secondaryTextColour)
                    ColorText("Body Text Colour", color: detailTheme.tertiaryTextColour)
                    ColorText("Primary Filler Colour (UNUSED)", color: detailTheme.primaryFillerColour)
                    ColorText("List Background Color", color: detailTheme.secondaryFillerColour)
                }
            }
        }
    }
}

private struct ColorText: View {
    var text: String
    var color: Color

    init(_ text: String, color: Color) {
        self.text = text
        self.color = color
    }

    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Circle()
                .foregroundColor(color)
                .overlay { Circle().stroke(lineWidth: 1) }
                .frame(width: 15, height: 15)
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
