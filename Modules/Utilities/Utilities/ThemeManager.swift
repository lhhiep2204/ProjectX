//
//  ThemeManager.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 26/4/24.
//

import Extensions
import SwiftUI

public class ThemeManager: ObservableObject {
    @Published public var currentTheme: Theme {
        didSet {
            UserDefaults.theme = currentTheme
        }
    }

    public init() {
        currentTheme = UserDefaults.theme
    }
}

public enum Theme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

#if os(macOS)
    public var userInterfaceStyle: NSAppearance.Name? {
        switch self {
        case .system: nil
        case .light: .aqua
        case .dark: .darkAqua
        }
    }
#else
    public var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: .unspecified
        case .light: .light
        case .dark: .dark
        }
    }
#endif

    public var colorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}
