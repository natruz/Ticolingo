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
    @State var definitions: [String] = []
    @State var difficulty: Int = 0
    @State var examples: [String] = []

    @State var newDefinitionPrefix: String = "Verb"

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List {
            Section {
                TextField(text: $term) { Text("Term") }
                Picker(selection: $difficulty) {
                    ForEach(0..<7) { index in
                        Text("\(index+1)")
                    }
                } label: {
                    Text("Difficulty")
                }
            }

            Section(header: ColText("Definitions")) {
                ForEach($definitions, id: \.self) { $definition in
                    TextField(text: $definition) {
                        Text("Definition")
                    }
                }
                .onMove(perform: { index, moveTo in
                    definitions.move(fromOffsets: index, toOffset: moveTo)
                })
                .onDelete(perform: { index in
                    definitions.remove(atOffsets: index)
                })

                HStack {
                    Picker(selection: $newDefinitionPrefix) {
                        ForEach([
                            "Verb",
                            "Noun",
                            "Adjective",
                            "Adverb",
                            "Idiom",
                            "Onomatopoea"
                        ], id: \.self) { type in
                            Text(type)
                        }
                    } label: {
                        Text("New Definition of Type")
                    }
                }

                HStack {
                    Spacer()
                    Button {
                        var newPrefix = verb
                        switch newDefinitionPrefix {
                        case "Verb": newPrefix = verb
                        case "Noun": newPrefix = noun
                        case "Adjective": newPrefix = adj
                        case "Adverb": newPrefix = advb
                        case "Idiom": newPrefix = idiom
                        case "Onomatopoea": newPrefix = sound
                        default: break
                        }
                        definitions.append(newPrefix)
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
            }

            Section(header: ColText("Examples")) {
                ForEach($examples, id: \.self) { $example in
                    TextField(text: $example) { Text("Example Sentence") }
                }
                .onMove(perform: { index, moveTo in
                    examples.move(fromOffsets: index, toOffset: moveTo)
                })
                .onDelete(perform: { index in
                    examples.remove(atOffsets: index)
                })

                HStack {
                    Spacer()
                    Button {
                        if !examples.contains(where: { $0.isEmpty }) {
                            examples.append("")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
            }
        }

        Button("Create Vocabulary") {
            terms.append(Vocab(term: term,
                               definition: definitions.joined(separator: ", "),
                               exampleSentences: examples,
                               difficulty: difficulty))
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(term.isEmpty)
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
