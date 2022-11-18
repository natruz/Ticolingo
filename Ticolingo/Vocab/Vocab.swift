//
//  Vocab.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 17/9/22.
//

import Foundation

class Vocab: ObservableObject, Codable, Identifiable {

    var id = UUID()

    @Published var term: String                { didSet {
        if term.hasChineseCharacter {
            pinyin = term.toPinyin(withFormat: pyOutputFormat).transformDiacritics()
        } else {
            pinyin = "Non-chinese character"
        }
        StudyGroups.shared.save()
    }}
    @Published var pinyin: String              { didSet { StudyGroups.shared.save() } }
    @Published var definition: [Definition]    { didSet { StudyGroups.shared.save() } }
    @Published var exampleSentences: [String]  { didSet { StudyGroups.shared.save() } }
    @Published var difficulty: Int             { didSet { StudyGroups.shared.save() } }
    @Published var familiarity = false         { didSet { StudyGroups.shared.save() } }

    @Published var editable: Bool = true

    init(term: String,
         pinyin: String? = nil,
         definition: [Definition],
         exampleSentences: [String],
         difficulty: Int,
         editable: Bool = true
    ) {
        self.term = term
        if let pinyin = pinyin {
            self.pinyin = pinyin
        } else {
            if term.hasChineseCharacter {
                self.pinyin = term.toPinyin(withFormat: pyOutputFormat).transformDiacritics()
            } else {
                self.pinyin = "Non-chinese character"
            }
        }
        self.definition = definition
        self.exampleSentences = exampleSentences
        self.difficulty = difficulty
        self.editable = editable
    }

    convenience init(term: String,
                     pinyin: String? = nil,
                     definition: String,
                     exampleSentences: [String],
                     difficulty: Int,
                     editable: Bool = true
    ) {
        let definition = definition.toDefinition()
        self.init(term: term,
                  pinyin: pinyin,
                  definition: definition,
                  exampleSentences: exampleSentences,
                  difficulty: difficulty,
                  editable: editable)
    }

    convenience init(term: String,
                     pinyin: String? = nil,
                     definition: String,
                     exampleSentence: String,
                     difficulty: Int,
                     editable: Bool = true
    ) {
        self.init(term: term,
                  pinyin: pinyin,
                  definition: definition,
                  exampleSentences: [exampleSentence],
                  difficulty: difficulty,
                  editable: editable)
    }
}

// the v character in chinese denotes the u with two dots on top
let vowels: [String] = ["a", "e", "i", "o", "u", "v"]

// using the ABC Extended keyboard, do the following to get each tone:
// 0: just type it, or option+u, u for that weird u character
// 1: option+a, then type the character
// 2: option+e, then type the character
// 3: option+v, then type the character
// 4: option+`, then type the character
let diacritics: [String: [String]] = [
    "a": ["a", "ā", "á", "ǎ", "à"],
    "e": ["e", "ē", "é", "ě", "è"],
    "i": ["i", "ī", "í", "ǐ", "ì"],
    "o": ["o", "ō", "ó", "ǒ", "ò"],
    "u": ["u", "ū", "ú", "ǔ", "ù"],
    "v": ["ü", "ǖ", "ǘ", "ǚ", "ǜ"]
]

let pyOutputFormat = PinyinOutputFormat(toneType: .toneNumber, vCharType: .vCharacter, caseType: .lowercased)

extension String {
    // function that takes pinyin (eg. nv3) and turns it into its py form (eg. nǚ)
    func transformDiacritics(separator: String = " ") -> String {
        var pyForm = ""

        // split the string
        for word in self.components(separatedBy: separator) {
            // for each string, get the main py and its tone, continuing if none found
            let mainBody = String(word.dropLast())
            guard let lastChar = word.last,
                  let toneNumber = Int(String(lastChar)) else {
                pyForm += word + separator
                continue
            }

            // loop over each possible vowel and transform it if needed
            var modifiedBody = mainBody
            for vowel in vowels {
                if mainBody.contains(vowel) {
                    modifiedBody = mainBody.stringByReplacingFirstOccurrenceOfString(of: vowel, with: diacritics[vowel]![toneNumber%5]) + separator
                    break
                }
            }

            pyForm += modifiedBody
        }

        // turn v into ǖ
        return pyForm.replacingOccurrences(of: "v", with: "ü")
    }

    // replaces the first occurrence of a string
    func stringByReplacingFirstOccurrenceOfString(of target: String,
                                                  with replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }
}
