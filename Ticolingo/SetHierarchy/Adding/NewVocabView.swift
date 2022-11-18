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
        List {
            content
        }

        Button("Create Vocabulary") {
            terms.append(Vocab(term: term,
                               definition: definitions.filter({ !$0.wrappedString.isEmpty }),
                               exampleSentences: examples.filter({ !$0.isEmpty }),
                               difficulty: difficulty))
            presentationMode.wrappedValue.dismiss()
        }
        .disabled(term.isEmpty)
    }

    @ViewBuilder
    var content: some View {
        Section {
            TextField(text: $term) { Text("Term") }
            VStack(alignment: .leading) {
                Text("Difficulty: \(difficulty)/7")
                    .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    .padding(.bottom, 1)
                HStack {
                    ForEach(0..<7) { index in
                        Image(systemName: "star.fill")
                            .foregroundColor(difficulty <= index ? .gray : .yellow)
                    }
                }
                .overlay {
                    GeometryReader { geometry in
                        Color.white.opacity(0.001)
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged{ gesture in
                                    let segmentWidth = geometry.size.width/7
                                    let location = Int(gesture.location.x/segmentWidth)
                                    withAnimation(.linear(duration: 0.1)) {
                                        difficulty = max(0, min(location+1, 7))
                                    }
                                }
                                .onEnded { gesture in
                                    let segmentWidth = geometry.size.width/7
                                    let location = Int(gesture.location.x/segmentWidth)
                                    withAnimation(.linear(duration: 0.1)) {
                                        difficulty = max(0, min(location+1, 7))
                                    }
                                })
                    }
                }
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
                        if definition.wrappedString.isEmpty {
                            Text("Definition")
                                .foregroundColor(Color(UIColor.tertiaryLabel))
                        } else {
                            Text("\(definition.wrappedString)")
                        }
                        Spacer()
                        Text("\(definition.defName)")
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
            if #available(iOS 16.0, *) {
                definitionEditView
                    .presentationDetents([.fraction(0.3), .medium])
            } else {
                // Fallback on earlier versions
                definitionEditView
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
                    if example.isEmpty {
                        Text("Example")
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                    } else {
                        Text(example)
                            .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    }
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
            if #available(iOS 16.0, *) {
                exampleEditView
                    .presentationDetents([.fraction(0.3), .medium])
            } else {
                // Fallback on earlier versions
                exampleEditView
            }
        }
    }

    @ViewBuilder
    var definitionEditView: some View {
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

    @ViewBuilder
    var exampleEditView: some View {
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

struct NewVocabView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

        }
        .sheet(isPresented: .constant(true)) {
            NewVocabView(terms: .constant([]))
        }
    }
}
