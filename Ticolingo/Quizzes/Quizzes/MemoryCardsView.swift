//
//  MemoryCardsView.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 22/10/22.
//

import SwiftUI

struct MemoryCardsView: View {

    let options: [Question]
    @State var scores: [Question: Double?] = [:]

    let cardSize: CGFloat = 40.0
    let topBarSize: CGFloat = 50.0

    init(options: [Question]) {
        self.options = options
        let empty: [Double?] = options.map({ _ in nil })
        self.scores = Dictionary(uniqueKeysWithValues: zip(options, empty))
    }

    var body: some View {
        VStack {
            Text("Hello World!")
        }
    }
}

struct MemoryCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCardsView(options: [])
    }
}
