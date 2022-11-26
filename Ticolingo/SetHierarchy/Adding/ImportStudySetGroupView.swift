//
//  ImportStudySetGroupView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct ImportStudySetGroupView: View {

    @ObservedObject var studyGroups: StudyGroups = .shared

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss

    @State var jsonString: String = ""

    var body: some View {
        List {
            Section {
                TextField("JSON String", text: $jsonString)
                Button("Use Clipboard Value") {
                    if let string = UIPasteboard.general.string {
                        jsonString = string
                    }
                }
            }

            Section {
                HStack {
                    Spacer()
                    Button {
                        _ = studyGroups.importStudyGroup(string: jsonString)
                        dismiss()
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ImportStudySetGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ImportStudySetGroupView()
    }
}
