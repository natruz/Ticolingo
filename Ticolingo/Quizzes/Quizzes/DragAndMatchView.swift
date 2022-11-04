//
//  DragAndMatchView.swift
//  dragAndMatch
//
//  Created by TAY KAI QUAN on 13/9/22.
//

import SwiftUI

struct DragAndMatchView: View {

    let options: [Question]
    @State var scores: [Question: Double?] = [:]
    
    let cardSize: CGFloat = 40.0
    let topBarSize: CGFloat = 50.0

    init(options: [Question]) {
        self.options = options
        let empty: [Double?] = options.map({ _ in nil })
        self.scores = Dictionary(uniqueKeysWithValues: zip(options, empty))
    }

    @State var leftOptions: [String] = []
    @State var rightOptions: [String] = []

    @State var translation: CGSize = .zero
    @State var draggedCard: Int = -1
    @State var pairedIndexes: [Int] = []

    @State var wrongAnswers: Int = 0

    var body: some View {
        ZStack {
            if pairedIndexes.count == options.existingCount {
                VStack {
                    stats
                }
                .frame(width: 200)
                VStack {
                    Button("Restart") {
                        withAnimation {
                            restart()
                        }
                    }
                    .padding(.bottom, 20)
                    NavigationLink("Finish") {
                        // TODO: Reimplement QuizResultsView
//                        QuizResultsView(scores: scores)
                    }
                }
                .offset(y: 200)
            } else {
                VStack {
                    HStack {
                        stats
                    }
                    .frame(height: topBarSize)
                    .padding(.bottom, 15)

                    GeometryReader { proxy in
                        if pairedIndexes.count != options.existingCount {
                            actions
                        }

                        Color.white
                            .opacity(0.000001)
                            .gesture(makeDragGesture(size: proxy.size))
                    }
                }
                .onAppear {
                    var fullLeftOptions = Array(options.questions.shuffled())
                    if fullLeftOptions.count < 5 {
                        for _ in fullLeftOptions.count..<5 {
                            fullLeftOptions.append(emptyIdentifier)
                        }
                    }
                    let fullRightOptions = fullLeftOptions.map {
                        if $0 == emptyIdentifier {
                            return emptyIdentifier
                        } else {
                            return options[$0]!
                        }
                    }
                    leftOptions = Array(Array(fullLeftOptions)[0..<5])
                    rightOptions = Array(fullRightOptions)[0..<5].shuffled()
                }
            }
        }
        .navigationTitle("Drag and Match")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    var actions: some View {
        GeometryReader { proxy in
            ZStack { // this is so that the left options are on top of the right options when dragged
                // right options
                HStack {
                    Spacer()
                        .frame(width: proxy.size.width/5*3.5)
                    VStack {
                        ForEach(Array(rightOptions.enumerated()), id: \.offset) { index, option in
                            SingleFlipCardView(front: .constant(option),
                                               back: .constant(""),
                                               frontColor: .pink,
                                               onFlip: { _ in .reject })
                            .opacity(option == emptyIdentifier ? 0 : (
                                pairedIndexes.contains(Array(options.answers).firstIndex(of: option)!) ? 0 : 1
                            ))
                        }
                    }
                    .offset(x: -10)
                }
                // left options
                HStack {
                    VStack {
                        ForEach(Array(leftOptions.enumerated()), id: \.offset) { index, option in
                            SingleFlipCardView(front: .constant(option),
                                               back: .constant(""),
                                               frontColor: .purple,
                                               onFlip: { _ in .reject })
                            .opacity(option == emptyIdentifier ? 0 : (
                                pairedIndexes.contains(Array(options.questions).firstIndex(of: option)!) ? 0 : 1
                            ))
                            .offset(x: draggedCard == index ? translation.width : 0,
                                    y: draggedCard == index ? translation.height : 0)
                        }
                    }
                    .offset(x: 10)
                    Spacer()
                        .frame(width: proxy.size.width/5*3.5)
                }
            }
        }
    }

    @ViewBuilder
    var stats: some View {
        Spacer()
            .frame(width: 10)
        ZStack {
            Color.cyan
                .frame(height: 50)
                .cornerRadius(10)
                .opacity(0.5)
            HStack {
                Text("Left")
                    .padding(.bottom, 0)
                Text("\(options.existingCount-pairedIndexes.count)")
                    .font(.system(size: 30))
            }
        }

        ZStack {
            Color.green
                .frame(height: 50)
                .cornerRadius(10)
                .opacity(0.5)
            HStack {
                Text("Matched")
                    .padding(.bottom, 0)
                Text("\(pairedIndexes.count)")
                    .font(.system(size: 30))
            }
        }

        ZStack {
            Color.indigo
                .frame(height: 50)
                .cornerRadius(10)
                .opacity(0.5)
            HStack {
                Text("Wrong")
                    .padding(.bottom, 0)
                Text("\(wrongAnswers)")
                    .font(.system(size: 30))
            }
        }
        Spacer()
            .frame(width: 10)
    }

    func makeDragGesture(size: CGSize) -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                guard gesture.startLocation.x < size.width/3 else { return }
                var clickedIndex = -1
                // NOTE: This card height is hard coded to fit the iPhone 13 Pro. May not work
                // with other models so may need reworking.
                let cardHeight = size.height/5
                for location in 0..<leftOptions.count {
                    guard leftOptions[location] != emptyIdentifier else { continue }
                    if !pairedIndexes.contains(Array(options.questions).firstIndex(of:
                            leftOptions[location])!) &&
                        gesture.startLocation.y > CGFloat(location) * cardHeight &&
                        gesture.startLocation.y < CGFloat(location+1) * cardHeight {
                        clickedIndex = location
                    }
                }
                if clickedIndex != -1 {
                    draggedCard = clickedIndex
                    translation = gesture.translation
                }
            }
            .onEnded { gesture in
                if gesture.startLocation.x < size.width/3 && gesture.location.x > size.width/3*2 {
                    let cardHeight = size.height/5

                    // get the index of the start card
                    var startIndex = -1
                    for location in 0..<leftOptions.count {
                        guard leftOptions[location] != emptyIdentifier else { continue }
                        if !pairedIndexes.contains(Array(options.questions).firstIndex(of:
                                leftOptions[location])!) &&
                            gesture.startLocation.y > CGFloat(location) * cardHeight &&
                            gesture.startLocation.y < CGFloat(location+1) * cardHeight {
                            startIndex = location
                        }
                    }

                    // get the index of the end card
                    var endIndex = -1
                    for location in 0..<leftOptions.count {
                        if  gesture.location.y > CGFloat(location) * cardHeight &&
                            gesture.location.y < CGFloat(location+1) * cardHeight {
                            endIndex = location
                        }
                    }

                    if startIndex != -1 && endIndex != -1 {
                        let startName = leftOptions[startIndex]
                        let endName = rightOptions[endIndex]
                        if options[startName] == endName {
                            pairedIndexes.append(Array(options.questions).firstIndex(of: startName)!)
                            translation = .zero
                            draggedCard = -1
                            if let score = scores[options[startIndex]] as? Double, score > 0 {
                                scores[options[startIndex]] = 1 - (score / (score+1))
                            } else {
                                scores[options[startIndex]] = 1
                            }
                            generateNewOption()
                            return
                        } else {
                            wrongAnswers += 1
                            // add 1 to the score. When the user finally gets it correct, this score
                            // will be inverted, ending up with the percentage of times this was wrong.
                            if let score = scores[options[startIndex]] as? Double {
                                scores[options[startIndex]] = score + 1
                            } else {
                                scores[options[startIndex]] = 1
                            }
                        }
                    }
                }

                // default: animate back
                withAnimation(.easeInOut(duration: 0.2)) {
                    translation = .zero
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02, execute: {
                    self.draggedCard = -1
                })
            }
    }

    func generateNewOption() {
        let leftovers = options.questions.enumerated().filter { index, string in
            return !pairedIndexes.contains(index) && !leftOptions.contains(string)
        }.map({ index, string in
            return String(string)
        })
        for (index, option) in leftOptions.enumerated() {
            let optionIndex = Array(options.questions).firstIndex(of: option)!
            if pairedIndexes.contains(optionIndex) {
                guard !leftovers.isEmpty else { return }

                // this index has just been matched, find a new one
                if let newOption = leftovers.randomElement() {
                    let rightOption = options[newOption]!
                    let correspondingRightOptionIndex = rightOptions.firstIndex(of: options[option]!)!
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        withAnimation {
                            self.leftOptions[index] = newOption
                            self.rightOptions[correspondingRightOptionIndex] = rightOption
                            self.rightOptions.shuffle()
                        }
                    })
                }
            }
        }
    }

    func restart() {
        generateNewOption()
        pairedIndexes = []
        let empty: [Double?] = options.map({ _ in nil })
        self.scores = Dictionary(uniqueKeysWithValues: zip(options, empty))
    }
}

struct DragAndMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DragAndMatchView(options: [
                Question(question: "a", answer: "1"),
                Question(question: "b", answer: "2"),
                Question(question: "c", answer: "3"),
                Question(question: "d", answer: "4"),
                Question(question: "e", answer: "5"),
                Question(question: "f", answer: "6"),
                Question(question: "g", answer: "7"),
                Question(question: "h", answer: "8"),
                Question(question: "i", answer: "9"),
                Question(question: "j", answer: "10"),
                Question(question: "k", answer: "11"),
                Question(question: "l", answer: "12")
            ])
        }
    }
}
