//
//  NewVocabView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct NewVocabView: View {

    @Binding var terms: [Vocab]

    @State var term: String = ""
    @State var definitions: [Definition] = []
    @State var difficulty: Int = 0
    @State var examples: [String] = []

    @State var newDefinitionPrefix: String = "Verb"

    @State var showDefinitionEdit: Bool = false
    @State var showExamplesEdit: Bool = false

    @State var definitionToEdit: Int = 0
    @State var exampleToEdit: Int = 0

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            content
        }

        Button("Create Vocabulary") {
            terms.append(Vocab(term: term,
                               definition: definitions,
                               exampleSentences: examples,
                               difficulty: difficulty))
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(term.isEmpty)
    }

    @ViewBuilder
    var content: some View {
        Section {
            TextField(text: $term) { Text("Term") }
            Picker(selection: $difficulty) {
                ForEach(0..<7) { index in
                    Text("\(index+1)")
                        .foregroundColor(ColorManager.shared.tertiaryTextColour)
                }
            } label: {
                Text("Difficulty")
                    .foregroundColor(ColorManager.shared.tertiaryTextColour)
            }
        }

        Section(header: SecTitle("Definitions") {
            Menu {
                ForEach(Definition.allCases, id: \.self) { type in
                    Button("\(type.defName) Definition") {
                        definitions.append(type.replacingWrappedString(with: ""))
                    }
                }
            } label: {
                Image(systemName: "plus")
            }
        }) {
            ForEach(Array(definitions.enumerated()), id: \.0) { (index, definition) in
                Button {
                    definitionToEdit = index
                    showDefinitionEdit = true
                } label: {
                    HStack {
                        Text("\(definition.defName):\n\(definition.wrappedString)")
                    }
                    .foregroundColor(ColorManager.shared.tertiaryTextColour)
                }
            }
            .onMove(perform: { index, moveTo in
                definitions.move(fromOffsets: index, toOffset: moveTo)
            })
            .onDelete(perform: { index in
                definitions.remove(atOffsets: index)
            })
        }
        .sheet(isPresented: $showDefinitionEdit) {
            List {
                Picker("Definition Type", selection: .init(get: { () -> Definition in
                    definitions[definitionToEdit]
                }, set: { newValue in
                    definitions[definitionToEdit] = definitions[definitionToEdit]
                        .changingDefinitionType(to: newValue)
                })) {
                    ForEach(Definition.allCases, id: \.self) { defType in
                        Text(defType.defName)
                    }
                }

                TextField("Definition", text: .init(get: {
                    print("Read value: \(definitions[definitionToEdit].wrappedString) for \(definitionToEdit)")
                    return definitions[definitionToEdit].wrappedString
                }, set: { newValue in
                    print("New value: \(newValue)")
                    definitions[definitionToEdit] = definitions[definitionToEdit]
                        .replacingWrappedString(with: newValue)
                    print("Value afterward: \(definitions[definitionToEdit].wrappedString)")
                }))
                .onSubmit {
                    showDefinitionEdit = false
                }
            }
        }

        Section(header: SecTitle("Examples") {
            Button {
                if !examples.contains(where: { $0.isEmpty }) {
                    examples.append("")
                }
            } label: {
                Image(systemName: "plus")
            }
        }) {
            ForEach(Array(examples.enumerated()), id: \.0) { (index, example) in
                Button {
                    exampleToEdit = index
                    showExamplesEdit = true
                } label: {
                    Text(example)
                }
            }
            .onMove(perform: { index, moveTo in
                examples.move(fromOffsets: index, toOffset: moveTo)
            })
            .onDelete(perform: { index in
                examples.remove(atOffsets: index)
            })
        }
        .sheet(isPresented: $showExamplesEdit) {
            List {
                Section {
                    TextField("Example", text: .init(get: {
                        examples[exampleToEdit]
                    }, set: { newValue in
                        examples[exampleToEdit] = newValue
                    }))
                    .onSubmit {
                        showExamplesEdit = false
                    }
                }
            }
        }
    }
}

struct NewVocabView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

        }
        .sheet(isPresented: .constant(true)) {
            NewVocabView(terms: .constant([]))
        }
    }
}
