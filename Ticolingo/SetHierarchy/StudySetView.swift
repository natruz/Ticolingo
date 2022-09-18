//
//  StudySetView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct StudySetView: View {
    
    @State var set: StudySet
    
    var body: some View {
        List {
            ForEach(set.terms) { term in
                NavigationLink(destination: TermDetailView(term: term)) {
                    Text(term.familiarity ? "😃" : "☹️")
                    Text(term.term)
                    Text(term.pinyin)
                        .opacity(0.8)
                }
                .deleteDisabled(!set.editable)
                .moveDisabled(!set.editable)
            }
            .onMove(perform: { index, moveTo in
                print("Tried to move \(index) to \(moveTo)")
            })
            .onDelete(perform: { index in
                print("Tried to delete \(index)")
            })
        }
        .navigationTitle(set.title)
    }
}

struct StudySetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StudySetView(set: StudySet(title: "Happy Terms", terms: [
                Vocab(term: "高兴", definition: "happy", exampleSentence: "我很高兴认识你。", difficulty: 0),
                Vocab(term: "快乐", definition: "happiness", exampleSentence: "小学的时候我很快乐。", difficulty: 0),
            ]))
        }
    }
}
