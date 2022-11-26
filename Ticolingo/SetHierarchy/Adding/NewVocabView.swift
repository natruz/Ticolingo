//
//  NewVocabView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 29/10/22.
//

import SwiftUI

struct NewVocabView: View {

    @ObservedObject
    var studyGroup: StudySetGroup

    @ObservedObject
    var studySet: StudySet

    @ObservedObject
    var vocab: Vocab

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
        .navigationTitle(vocab.term)
        .onDisappear {
            studySet.objectWillChange.send()
            studyGroup.objectWillChange.send()
            StudyGroups.shared.objectWillChange.send()
        }

        Button("Finish") {
            presentationMode.wrappedValue.dismiss()
        }
    }

    @ViewBuilder
    var content: some View {
        Section {
            TextField(text: $vocab.term) { Text("Term") }
            VStack(alignment: .leading) {
                Text("Difficulty: \(vocab.difficulty)/7")
                    .foregroundColor(ColorManager.shared.tertiaryTextColour)
                    .padding(.bottom, 1)
                HStack {
                    ForEach(0..<7) { index in
                        Image(systemName: "star.fill")
                            .foregroundColor(vocab.difficulty <= index ? .gray : .yellow)
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
                                        vocab.difficulty = max(0, min(location+1, 7))
                                    }
                                }
                                .onEnded { gesture in
                                    let segmentWidth = geometry.size.width/7
                                    let location = Int(gesture.location.x/segmentWidth)
                                    withAnimation(.linear(duration: 0.1)) {
                                        vocab.difficulty = max(0, min(location+1, 7))
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
                        vocab.definition.append(type.replacingWrappedString(with: ""))
                    }
                }
            } label: {
                Image(systemName: "plus")
            }
        }) {
            ForEach(Array(vocab.definition.enumerated()), id: \.0) { (index, definition) in
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
                vocab.definition.move(fromOffsets: index, toOffset: moveTo)
            })
            .onDelete(perform: { index in
                vocab.definition.remove(atOffsets: index)
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
                if !vocab.exampleSentences.contains(where: { $0.isEmpty }) {
                    vocab.exampleSentences.append("")
                }
            } label: {
                Image(systemName: "plus")
            }
        }) {
            ForEach(Array(vocab.exampleSentences.enumerated()), id: \.0) { (index, example) in
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
                vocab.exampleSentences.move(fromOffsets: index, toOffset: moveTo)
            })
            .onDelete(perform: { index in
                vocab.exampleSentences.remove(atOffsets: index)
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
                vocab.definition[definitionToEdit]
            }, set: { newValue in
                vocab.definition[definitionToEdit] = vocab.definition[definitionToEdit]
                    .changingDefinitionType(to: newValue)
            })) {
                ForEach(Definition.allCases, id: \.self) { defType in
                    Text(defType.defName)
                }
            }

            TextField("Definition", text: .init(get: {
                print("Read value: \(vocab.definition[definitionToEdit].wrappedString) for \(definitionToEdit)")
                return vocab.definition[definitionToEdit].wrappedString
            }, set: { newValue in
                print("New value: \(newValue)")
                vocab.definition[definitionToEdit] = vocab.definition[definitionToEdit]
                    .replacingWrappedString(with: newValue)
                print("Value afterward: \(vocab.definition[definitionToEdit].wrappedString)")
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
                    vocab.exampleSentences[exampleToEdit]
                }, set: { newValue in
                    vocab.exampleSentences[exampleToEdit] = newValue
                }))
                .onSubmit {
                    showExamplesEdit = false
                }
            }
        }
    }
}
