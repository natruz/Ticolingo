//
//  StudySet.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class StudySet: ObservableObject, Codable, Identifiable {
    var id = UUID()

    @Published var title: String   { didSet { StudyGroups.shared.save() } }
    @Published var terms: [Vocab]  { didSet { StudyGroups.shared.save() } }

    @Published var editable: Bool = true {
        didSet {
            for term in terms {
                term.editable = editable
            }
        }
    }

    init(title: String, terms: [Vocab], editable: Bool = true) {
        self.title = title
        self.terms = terms
        self.editable = editable
    }
}
