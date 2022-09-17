//
//  StudySetGroup.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class StudySetGroup: ObservableObject, Codable, Identifiable {
    var name: String
    var sets: [StudySet]

    var editable: Bool = true {
        didSet {
            for set in sets {
                set.editable = editable
            }
        }
    }

    init(name: String, sets: [StudySet], editable: Bool = true) {
        self.name = name
        self.sets = sets
        self.editable = editable
    }
}
