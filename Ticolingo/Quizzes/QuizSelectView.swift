//
//  QuizSelectView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 3/11/22.
//

import SwiftUI

struct QuizSelectView: View {
    
    @State var quizType: QuizType
    @State var set: StudySet
    @State var questions: [Question] = []
    
    var body: some View {
        if #available(iOS 16.0, *) {
            content
                .toolbar(.hidden, for: .tabBar)
        } else {
            content
        }
    }
    
    var content: some View {
        List {
            Section("Select Quizzed Aspects") {
                QuizSelectTypeView(vocab: set.terms,
                                   questions: $questions)
            }
            
            Section {
                NavigationLink {
                    ZStack {
                        switch quizType {
                        case .dragAndMatch:
                            DragAndMatchView(options: questions)
                        case .memoryCards:
                            MemoryCardsView(options: questions)
                        case .questionAnswer:
                            QuizView(options: questions)
                        case .flashCards:
                            FlashcardsView(options: questions)
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Start Playing")
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 20)
                        Spacer()
                    }
                }
            }
            
            Section("Questions") {
                ForEach(questions) { question in
                    VStack(alignment: .leading) {
                        Text(question.question)
                            .foregroundColor(secondaryTextColour)
                        Text(question.answer)
                            .foregroundColor(secondaryTextColour)
                    }
                }
            }
        }
        .navigationTitle(quizTypeName)
        .navigationBarTitleDisplayMode(.inline)
    }

    var quizTypeName: String {
        switch quizType {
        case .dragAndMatch:
            return "Drag And Match"
        case .memoryCards:
            return "Memory Cards"
        case .questionAnswer:
            return "Question and Answer"
        case .flashCards:
            return "Flash Cards"
        }
    }
}

struct QuizSelectView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            NavigationView {
                QuizSelectView(quizType: .dragAndMatch,
                               set: StudySet(title: "HI",
                                             terms: []))
            }
            .tabItem {
                Label {
                    Text("HI")
                } icon: {
                    Image(systemName: "circle")
                }
            }
        }
    }
}
