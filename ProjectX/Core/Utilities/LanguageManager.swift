//
//  LanguageManager.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 26/4/24.
//

import SwiftUI

// MARK: - Localization
struct Keys {}
protocol LocalizedKey {}

extension LocalizedKey {
    var identifier: String {
        (self as? (any RawRepresentable))?.rawValue as? String ?? ""
    }
}

extension String {
    static func localized(_ key: LocalizedKey) -> String {
        NSLocalizedString(key.identifier, bundle: LanguageManager.bundle, comment: "")
    }
}

extension Text {
    init(_ key: LocalizedKey) {
        self.init(String.localized(key))
    }
}

extension Button where Label == Text {
    init(_ key: LocalizedKey, action: @escaping () -> Void) {
        self.init(String.localized(key), action: action)
    }
}

// MARK: - Language manager
@propertyWrapper
struct LocalizedBundle {
    private var bundle: Bundle?

    var wrappedValue: Bundle {
        mutating get {
            if bundle == nil {
                let language = UserDefaultsManager.language
                if let path = Bundle.main.path(forResource: language.code, ofType: "lproj") {
                    bundle = Bundle(path: path)
                }
            }
            return bundle ?? Bundle.main
        }
        set {
            bundle = newValue
        }
    }
}

extension Bundle {
    static func setLanguage(_ language: Language) {
        UserDefaultsManager.language = language
        if let path = Bundle.main.path(forResource: language.code, ofType: "lproj") {
            LanguageManager.bundle = Bundle(path: path) ?? Bundle.main
        } else {
            LanguageManager.bundle = Bundle.main
        }
    }
}

enum Language: String, CaseIterable {
    case system = "System"
    case english = "English"
    case french = "French"
    case vietnamese = "Vietnamese"

    var code: String {
        switch self {
        case .system: Locale.preferredLanguages.first ?? "en"
        case .english: "en"
        case .french: "fr"
        case .vietnamese: "vi"
        }
    }
}

class LanguageManager: ObservableObject {
    @LocalizedBundle static var bundle: Bundle

    @Published var currentLanguage: Language {
        didSet {
            Bundle.setLanguage(currentLanguage)
        }
    }

    init() {
        currentLanguage = UserDefaultsManager.language
    }
}
