//
//  StudySet.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class StudySet: ObservableObject, Codable, Identifiable {

    var id = UUID()

    var title: String
    var terms: [Vocab]

    init(title: String, terms: [Vocab]) {
        self.title = title
        self.terms = terms
    }
}
