//
//  Definition.swift
//  Ticolingo
//
//  Created by TAY KAI QUAN on 18/9/22.
//

import Foundation

enum Definition: Hashable {
    case verb(String)
    case noun(String)
    case adj(String)
    case advb(String)
    case idiom(String)

    case unknown(String)

    func asString() -> String {
        var asString = ""
        switch self {
        case .verb(let string):
            asString = string
        case .noun(let string):
            asString = string
        case .adj(let string):
            asString = string
        case .advb(let string):
            asString = string
        case .idiom(let string):
            asString = string
        case .unknown(let string):
            asString = string
        }
        return asString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

let verb:  String = "--verb--"
let noun:  String = "--noun--"
let adj:   String = "--adj--"
let advb:  String = "--advb--"
let idiom: String = "--idiom--"

extension String {
    // function to take a string and turn it into an array of definitions
    func toDefinition() -> [Definition] {

        // split by definition
        let definitionComponents: [String] = componentsWithSeparator(separatedBy: verb)
            .reduce([String](), { result, element in
                result + element.componentsWithSeparator(separatedBy: noun)
            })
            .reduce([String](), { result, element in
                result + element.componentsWithSeparator(separatedBy: adj)
            })
            .reduce([String](), { result, element in
                result + element.componentsWithSeparator(separatedBy: advb)
            })
            .reduce([String](), { result, element in
                result + element.componentsWithSeparator(separatedBy: idiom)
            })
            .filter({ !$0.isEmpty })

        // parse into Definitions
        return definitionComponents.map({ definitionString in
            var mutableDefinition = definitionString
            if definitionString.hasPrefix(verb) {
                mutableDefinition.removeFirst(verb.count)
                return .verb(mutableDefinition)
            } else if definitionString.hasPrefix(noun) {
                mutableDefinition.removeFirst(noun.count)
                return .noun(mutableDefinition)
            } else if definitionString.hasPrefix(adj) {
                mutableDefinition.removeFirst(adj.count)
                return .adj(mutableDefinition)
            } else if definitionString.hasPrefix(advb) {
                mutableDefinition.removeFirst(advb.count)
                return .advb(mutableDefinition)
            } else if definitionString.hasPrefix(idiom) {
                mutableDefinition.removeFirst(idiom.count)
                return .idiom(mutableDefinition)
            } else {
                return .unknown(definitionString)
            }
        })
    }

    func componentsWithSeparator(separatedBy separator: String, as sepReplacement: String? = nil) -> [String] {
        let separated: [String] = components(separatedBy: separator)
        return separated.enumerated().map({ index, element in
            if index == 0 {
                return element
            }
            return "\(sepReplacement ?? separator)\(element)"
        })
    }
}