//
//  ThemeManager.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 26/4/24.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme {
        didSet {
            UserDefaultsManager.theme = currentTheme
        }
    }

    init() {
        currentTheme = UserDefaultsManager.theme
    }
}

enum Theme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

#if os(macOS)
    var userInterfaceStyle: NSAppearance.Name? {
        switch self {
        case .system: nil
        case .light: .aqua
        case .dark: .darkAqua
        }
    }
#else
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: .unspecified
        case .light: .light
        case .dark: .dark
        }
    }
#endif

    var colorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}
