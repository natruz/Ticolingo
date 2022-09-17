//
//  StudyGroups.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class StudyGroups: ObservableObject {
    // TODO: Read from memory
    static let shared: StudyGroups = .init(studyGroups: [])

    @Published
    var studyGroups: [StudySetGroup]

    init(studyGroups: [StudySetGroup]) {
        self.studyGroups = studyGroups
        self.studyGroups.append(contentsOf: StudyGroups.textBookSets)
        self.studyGroups.append(contentsOf: StudyGroups.otherData)
    }
}
