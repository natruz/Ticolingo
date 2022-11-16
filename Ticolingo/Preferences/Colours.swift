//
//  Colours.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import Foundation
import SwiftUI

private var defaults = UserDefaults.standard

class ColorManager: ObservableObject {
    static let shared: ColorManager = .init()

    private init() {
        UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
        if let savedTheme = defaults.string(forKey: "currentTheme"),
           let theme = ColorTheme.themes.first(where: { $0.name == savedTheme }) {
            print("Saved theme loaded: \(savedTheme)")
            currentTheme = theme
        } else {
            currentTheme = ColorTheme.themes.first!
        }
    }

    @Published var currentTheme: ColorTheme = ColorTheme.themes.first! {
        didSet {
            defaults.set(currentTheme.name, forKey: "currentTheme")
            print("Set current theme to \(currentTheme.name)")
            print("Current theme: \(defaults.string(forKey: "currentTheme") ?? "none")")
            self.primaryTextColour = currentTheme.primaryTextColor
            self.secondaryTextColour = currentTheme.secondaryTextColour
            self.tertiaryTextColour = currentTheme.tertiaryTextColour
            self.primaryFillerColour = currentTheme.primaryFillerColour
            self.secondaryFillerColour = currentTheme.secondaryFillerColour
        }
    }
    @Published private(set) var primaryTextColour: Color = .clear {
        didSet {
            UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
        }
    }
    @Published private(set) var secondaryTextColour: Color = .clear
    @Published private(set) var tertiaryTextColour: Color = .clear
    @Published private(set) var primaryFillerColour: Color = .clear
    @Published private(set) var secondaryFillerColour: Color = .clear
}

struct SecTitle<Content: View>: View {
    @State var content: String
    @State var trailing: () -> Content
    @ObservedObject var colors: ColorManager = .shared

    init(_ content: String,
         @ViewBuilder _ trailing: @escaping () -> Content = { EmptyView() }) {
        self.content = content
        self.trailing = trailing
    }

    var body: some View {
        HStack {
            Text(content)
                .foregroundColor(colors.secondaryTextColour)
            Spacer()
            trailing()
        }
    }
}
