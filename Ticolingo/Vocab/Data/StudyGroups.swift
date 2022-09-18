//
//  StudyGroups.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class StudyGroups: ObservableObject {
    static let shared: StudyGroups = .init()

    @Published
    var studyGroups: [StudySetGroup] {
        didSet {
            // the save function checks if it should save or not, so no need to do it here.
            save()
        }
    }

    var saveToMemory: Bool = false

    /// Creates a ``StudyGroups`` instance. If `studyGroups` is given, the `StudyGroups` is created with the studyGroups as the initial value.
    /// If `includeDefaults` is `false`, the default items are not included. If `studyGroups` is not given, the code will attempt to read from memory,
    /// ignoring the value of `includeDefaults`.
    ///
    /// - Parameters:
    ///   - studyGroups: The initial value of the StudyGroups. If not provided, the last saved studyGroups are read from memory.
    ///   - includeDefaults: If the StudyGroups should include the default items. Ignored if studyGroups is not provided.
    init(studyGroups: [StudySetGroup]? = nil, includeDefaults: Bool = true) {
        self.studyGroups = []

        // If is being run in previews, don't bother with loading since it will just use up memory.
        // Previews should only be used for rapid UI or small scale UX development, so persistence is not needed.
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            let studyGroups = studyGroups ?? []
            self.studyGroups = includeDefaults ? addBasicGroups(studyGroups: studyGroups) : studyGroups
            return
        }

        // If studygroups were specified, do not load and use those instead.
        if let studyGroups = studyGroups {
            self.studyGroups = addBasicGroups(studyGroups: studyGroups)
        } else {
            // If no study groups were specified, try to load from memory.
            // In this case, includeDefaults is ignored.
            load()
            self.saveToMemory = true
        }
    }

    func addBasicGroups(studyGroups: [StudySetGroup] = []) -> [StudySetGroup] {
        var mutableStudyGroups = studyGroups
        mutableStudyGroups.append(contentsOf: StudyGroups.textBookSets)
        mutableStudyGroups.append(contentsOf: StudyGroups.otherData)
        return mutableStudyGroups
    }
}
