//
//  Extensions.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

// MARK: - Bundle
public extension Bundle {
    static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        LanguageManager.bundle = Bundle(path: path!)!
    }
}

// MARK: - String
public extension String {
    static func localized(_ key: LocalizedKey) -> String {
        NSLocalizedString(key.identifier, bundle: LanguageManager.bundle, comment: "")
    }
}

// MARK: - Text
public extension Text {
    init(_ key: LocalizedKey) {
        self.init(String.localized(key))
    }
}

// MARK: - Button
public extension Button where Label == Text {
    init(_ key: LocalizedKey, action: @escaping () -> Void) {
        self.init(String.localized(key), action: action)
    }
}

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
