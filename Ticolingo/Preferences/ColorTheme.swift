//
//  ColorTheme.swift
//  Ticolingo
//
//  Created by Kai Quan Tay on 16/11/22.
//

import Foundation
import SwiftUI

class ColorTheme {
    var name: String
    var primaryTextColor: Color
    var secondaryTextColour: Color
    var tertiaryTextColour: Color
    var backgroundColour: Color
    var primaryFillerColour: Color
    var secondaryFillerColour: Color

    init(_ name: String,
         primaryTextColor: Color,
         secondaryTextColour: Color,
         tertiaryTextColour: Color,
         backgroundColour: Color,
         primaryFillerColour: Color,
         secondaryFillerColour: Color) {
        self.name = name
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColour = secondaryTextColour
        self.tertiaryTextColour = tertiaryTextColour
        self.backgroundColour = backgroundColour
        self.primaryFillerColour = primaryFillerColour
        self.secondaryFillerColour = secondaryFillerColour
    }
}

extension ColorTheme {
    static let themes: [ColorTheme] = [
        .defaultPurple
    ]

    static let defaultPurple: ColorTheme = .init("Default Purple",
                                                 primaryTextColor: Color(red: 246/255, green: 198/255, blue: 106/255),
                                                 secondaryTextColour: Color(red: 120/255, green: 120/255, blue: 216/255),
                                                 tertiaryTextColour: Color(red: 194/255, green: 70/255, blue: 123/255),
                                                 backgroundColour: Color(red: 249/255, green: 241/255, blue: 251/255),
                                                 primaryFillerColour: Color(red: 170/255, green: 137/255, blue: 191/255),
                                                 secondaryFillerColour: Color(red: 202/255, green: 183/255, blue: 206/255))
}
