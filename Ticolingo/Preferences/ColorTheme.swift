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
    var primaryFillerColour: Color
    var secondaryFillerColour: Color

    init(_ name: String,
         primaryTextColor: Color,
         secondaryTextColour: Color,
         tertiaryTextColour: Color,
         primaryFillerColour: Color,
         secondaryFillerColour: Color) {
        self.name = name
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColour = secondaryTextColour
        self.tertiaryTextColour = tertiaryTextColour
        self.primaryFillerColour = primaryFillerColour
        self.secondaryFillerColour = secondaryFillerColour
    }
}

extension ColorTheme {
    static let themes: [ColorTheme] = [
        .defaultPurple,
        .defaultiOS,
        .defaultDark,
        .defaultBeach,
        .defaultForest
    ]

    static let defaultPurple: ColorTheme = .init("Default Purple",
                                                 primaryTextColor: Color(red: 246/255, green: 198/255, blue: 106/255),
                                                 secondaryTextColour: Color(red: 120/255, green: 120/255, blue: 216/255),
                                                 tertiaryTextColour: Color(red: 194/255, green: 70/255, blue: 123/255),
                                                 primaryFillerColour: Color(red: 170/255, green: 137/255, blue: 191/255),
                                                 secondaryFillerColour: Color(red: 202/255, green: 183/255, blue: 206/255))

    static let defaultiOS: ColorTheme = .init("Default iOS",
                                              primaryTextColor: .black,
                                              secondaryTextColour: .gray,
                                              tertiaryTextColour: .black,
                                              primaryFillerColour: .yellow,
                                              secondaryFillerColour: .white)
    
    static let defaultDark: ColorTheme = .init("Dark",
                                               primaryTextColor: Color(red: 184/255, green: 188/225, blue: 194/255),
                                               secondaryTextColour: Color(red: 113/255, green: 110/255, blue: 119/255),
                                               tertiaryTextColour: Color(red: 242/255, green: 242/255, blue: 242/255),
                                               primaryFillerColour: Color(red: 170/255, green: 137/255, blue: 191/255),
                                               secondaryFillerColour: Color(red: 69/255, green: 70/255, blue: 71/255))
    
    static let defaultBeach: ColorTheme = .init("Beach",
                                                primaryTextColor: Color(red: 85/255, green: 155/225, blue: 163/255),
                                                secondaryTextColour: Color(red: 79/255, green: 110/255, blue: 123/255),
                                                tertiaryTextColour: Color(red: 8/255, green: 65/255, blue: 139/255),
                                                primaryFillerColour: Color(red: 170/255, green: 137/255, blue: 191/255),
                                                secondaryFillerColour: Color(red: 238/255, green: 204/255, blue: 154/255))
     
    static let defaultForest: ColorTheme = .init("Forest",
                                                primaryTextColor: Color(red: 76/255, green: 142/225, blue: 23/255),
                                                secondaryTextColour: Color(red: 79/255, green: 110/255, blue: 123/255),
                                                tertiaryTextColour: Color(red: 32/255, green: 61/255, blue: 20/255),
                                                primaryFillerColour: Color(red: 170/255, green: 137/255, blue: 191/255),
                                                secondaryFillerColour: Color(red: 145/255, green: 191/255, blue: 109/255))
}
