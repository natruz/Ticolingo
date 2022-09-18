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
        let plistName = "StudyGroupss.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        return documentsDirectory.appendingPathComponent(plistName)
    }

    func save() {
        if saveToMemory {
            let archiveURL = getArchiveURL()
            let propertyListEncoder = PropertyListEncoder()
            let encodedStudyGroupsItems = try? propertyListEncoder.encode(studyGroups)
            try? encodedStudyGroupsItems?.write(to: archiveURL, options: .noFileProtection)
        }
    }

    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()

        var finalStudyGroupsItems: [StudySetGroup]!

        if let retrievedStudyGroupsItemData = try? Data(contentsOf: archiveURL),
            let decodedStudyGroupsItems = try? propertyListDecoder.decode([StudySetGroup].self, from: retrievedStudyGroupsItemData) {
                finalStudyGroupsItems = decodedStudyGroupsItems
        } else {
            finalStudyGroupsItems = addBasicGroups()
        }

        studyGroups = finalStudyGroupsItems
    }
}
