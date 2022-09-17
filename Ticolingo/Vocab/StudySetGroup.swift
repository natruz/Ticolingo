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

    init(name: String, sets: [StudySet]) {
        self.name = name
        self.sets = sets
    }
}
