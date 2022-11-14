//
//  Colours.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import Foundation
import SwiftUI

var primaryTextColour = Color(red: 246/255, green: 198/255, blue: 106/255)
var secondaryTextColour = Color(red: 120/255, green: 120/255, blue: 216/255)
var tertiaryTextColour = Color(red: 194/255, green: 70/255, blue: 123/255)
var backgroundColour = Color(red: 249/255, green: 241/255, blue: 251/255)
var primaryFillerColour = Color(red: 170/255, green: 137/255, blue: 191/255)
var secondaryFillerColour = Color(red: 202/255, green: 183/255, blue: 206/255)

func setColours() {
    UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
}
