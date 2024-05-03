//
//  Extensions.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

// MARK: - UserDefaults
enum UserDefaultKey {
    static let currentLanguage = "CURRENT_LANGUAGE"
    static let currentTheme = "CURRENT_THEME"
}

public extension UserDefaults {
    static var language: Language {
        get {
            let currentLanguage = UserDefaults.get(forKey: UserDefaultKey.currentLanguage) as? String
            return Language(rawValue: currentLanguage ?? Language.system.rawValue) ?? .system
        }
        set {
            UserDefaults.set(newValue.rawValue, forKey: UserDefaultKey.currentLanguage)
        }
    }
    
    static var theme: Theme {
        get {
            let currentTheme = UserDefaults.get(forKey: UserDefaultKey.currentTheme) as? String
            return Theme(rawValue: currentTheme ?? Theme.system.rawValue) ?? .system
        }
        set {
            UserDefaults.set(newValue.rawValue, forKey: UserDefaultKey.currentTheme)
        }
    }
}
