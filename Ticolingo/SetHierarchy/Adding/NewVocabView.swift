//
//  NewVocabView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

private let vocabTypes = [
    "Verb",
    "Noun",
    "Adjective",
    "Adverb",
    "Idiom",
    "Onomatopoea"
]

struct NewVocabView: View {

    @Binding var terms: [Vocab]

    @State var term: String = ""
    @State var definitions: [(String, String)] = []
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
                               definition: definitions.map({ "\($0)\($1)" })
                                    .joined(separator: ", "),
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
                ForEach(vocabTypes, id: \.self) { type in
                    Button("\(type) Definition") {
                        var newPrefix = verb
                        switch type {
                        case "Verb": newPrefix = verb
                        case "Noun": newPrefix = noun
                        case "Adjective": newPrefix = adj
                        case "Adverb": newPrefix = advb
                        case "Idiom": newPrefix = idiom
                        case "Onomatopoea": newPrefix = sound
                        default: return
                        }
                        definitions.append((newPrefix, ""))
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
                        Text("\(definition.1)")
                        Spacer()
                        Text("\(definition.0)")
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
                Picker("Definition Type", selection: .init(get: { () -> String in
                    let type = definitions[definitionToEdit].0
                    switch type {
                    case verb: return "Verb"
                    case noun: return "Noun"
                    case adj: return "Adjective"
                    case advb: return "Adverb"
                    case idiom: return "Idiom"
                    case sound: return "Onomatopoea"
                    default: return "ERROR"
                    }
                }, set: { newValue in
                    var actualValue = "ERROR"
                    switch newValue {
                    case "Verb": actualValue = verb
                    case "Noun": actualValue = noun
                    case "Adjective": actualValue = adj
                    case "Adverb": actualValue = advb
                    case "Idiom": actualValue = idiom
                    case "Onomatopoea": actualValue = sound
                    default: actualValue = "ERROR"
                    }
                    definitions[definitionToEdit].0 = actualValue
                })) {
                    ForEach(vocabTypes, id: \.self) { defType in
                        Text(defType)
                    }
                }

                TextField("Definition", text: .init(get: {
                    definitions[definitionToEdit].1
                }, set: { newValue in
                    definitions[definitionToEdit].1 = newValue
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
