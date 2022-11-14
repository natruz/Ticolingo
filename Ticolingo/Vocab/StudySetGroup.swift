//
//  StudySetGroup.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class StudySetGroup: ObservableObject, Codable, Identifiable {
    @Published var name: String        { didSet { StudyGroups.shared.save() } }
    @Published var sets: [StudySet]    { didSet { StudyGroups.shared.save() } }

    @Published var editable: Bool = true {
        didSet {
            for set in sets {
                set.editable = editable
            }

            StudyGroups.shared.save()
        }
    }

    init(name: String, sets: [StudySet], editable: Bool = true) {
        self.name = name
        self.sets = sets
        self.editable = editable

        for set in sets {
            set.editable = editable
        }
    }

    func export(pretty: Bool = false) -> String? {
        let encoder = JSONEncoder()
        if pretty {
            encoder.outputFormatting = .prettyPrinted
        }
        if let encodedStudyGroup = try? encoder.encode(self) {
            return String(data: encodedStudyGroup, encoding: .utf8)
        }
        return nil
    }
}
