//
//  StudyGroupsManager.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 18/9/22.
//

import Foundation
import SwiftUI

extension StudyGroups {

    func getArchiveURL() -> URL {
        let jsonName = "StudyGroups.json"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        return documentsDirectory.appendingPathComponent(jsonName)
    }

    func save(forceSave: Bool = false) {
        if saveToMemory || forceSave {
            let archiveURL = getArchiveURL()
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodedStudyGroupsItems = try? encoder.encode(studyGroups)
            try? encodedStudyGroupsItems?.write(to: archiveURL, options: .noFileProtection)
        }
    }

    func load() {
        let archiveURL = getArchiveURL()
        let decoder = JSONDecoder()

        var finalStudyGroupsItems: [StudySetGroup]!

        if let retrievedStudyGroupsItemData = try? Data(contentsOf: archiveURL),
            let decodedStudyGroupsItems = try? decoder.decode([StudySetGroup].self, from: retrievedStudyGroupsItemData) {
                finalStudyGroupsItems = decodedStudyGroupsItems
        } else {
            finalStudyGroupsItems = addBasicGroups()
        }

        studyGroups = finalStudyGroupsItems
    }

    /// Wrapper around ``importStudyGroup(data:)`` to allow for decoding from string.
    /// Decodes a ``StudySetGroup`` from a `String` value and adds it to the `StudyGroup`'s ``studyGroups``
    /// - Parameter string: The string containing the data to decode from in JSON format
    /// - Returns: If it was successful or not
    func importStudyGroup(string: String) -> Bool {
        return importStudyGroup(data: Data(string.utf8))
    }

    /// Wrapper around ``importStudyGroup(data:)`` to allow for decoding from URL.
    /// Decodes a ``StudySetGroup`` from a `URL` value and adds it to the `StudyGroup`'s ``studyGroups``
    /// - Parameter url: The URL containing the data to decode from in JSON format
    /// - Returns: If it was successful or not
    func importStudyGroup(url: URL) -> Bool {
        if let data = try? Data(contentsOf: url) {
            return importStudyGroup(data: data)
        }
        return false
    }

    /// Decodes a ``StudySetGroup`` from a `Data` value and adds it to the `StudyGroup`'s ``studyGroups``
    /// - Parameter data: The data to decode from in JSON format
    /// - Returns: If it was successful or not
    func importStudyGroup(data: Data) -> Bool {
        let decoder = JSONDecoder()
        if let decodedStudyItem = try? decoder.decode(StudySetGroup.self, from: data) {
            self.studyGroups.append(decodedStudyItem)
            return true
        }
        return false
    }
}
