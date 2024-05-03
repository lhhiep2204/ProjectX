//
//  Extensions.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

// MARK: - UserDefaults
enum UserDefaultsKey {
    static let currentLanguage = "CURRENT_LANGUAGE"
    static let currentTheme = "CURRENT_THEME"
}

extension UserDefaults {
    static var language: Language {
        get {
            let currentLanguage = UserDefaults.standard.object(forKey: UserDefaultsKey.currentLanguage) as? String
            return Language(rawValue: currentLanguage ?? Language.system.rawValue) ?? .system
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKey.currentLanguage)
        }
    }

    static var theme: Theme {
        get {
            let currentTheme = UserDefaults.standard.object(forKey: UserDefaultsKey.currentTheme) as? String
            return Theme(rawValue: currentTheme ?? Theme.system.rawValue) ?? .system
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKey.currentTheme)
        }
    }
}
