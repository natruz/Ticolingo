//
//  StudySetView.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import SwiftUI

struct StudySetView: View {
    
    @State var set: StudySet
    @State var questions: [Question] = []
    
    var body: some View {
        List {
            Section {
                NavigationLink {
                    QuizSelectTypeView(vocab: set.terms,
                                       questions: $questions)
                    NavigationLink {
                        DragAndMatchView(options: questions)
                    } label: {
                        ZStack(alignment: .center) {
                            Color.accentColor
                                .frame(width: 240, height: 80)
                                .cornerRadius(10)
                            Text("Start Playing")
                                .foregroundColor(Color(uiColor: UIColor.label.inverted))
                        }
                    }
                    .navigationTitle("Select Quiz Type")
                } label: {
                    Text("Drag and Match Quiz")
                }
            }
            Section {
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

extension UIColor {
    var inverted: UIColor {
        var alpha: CGFloat = 1.0

        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }

        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }

        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }

        return self
    }
}
