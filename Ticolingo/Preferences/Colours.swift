//
//  Colours.swift
//  Ticolingo
//
//  Created by NATALIE CHEN HUI REGINA RUZSICSK stu on 13/9/22.
//

import Foundation
import SwiftUI

class ColorManager: ObservableObject {
    static let shared: ColorManager = .init()

    private init() {
        UISearchBar.appearance().tintColor = UIColor.init(primaryTextColour)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(primaryTextColour)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.init(primaryTextColour)
        currentTheme = ColorTheme.themes.first!
    }

    @Published var currentTheme: ColorTheme? {
        didSet {
            if let colorTheme = currentTheme {
                self.primaryTextColour = colorTheme.primaryTextColor
                self.secondaryTextColour = colorTheme.secondaryTextColour
                self.tertiaryTextColour = colorTheme.tertiaryTextColour
                self.primaryFillerColour = colorTheme.primaryFillerColour
                self.secondaryFillerColour = colorTheme.secondaryFillerColour
            }
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
