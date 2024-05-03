//
//  LanguageManager.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 26/4/24.
//

import SwiftUI

// MARK: - Localization
public struct Keys {}
public protocol LocalizedKey {}

extension LocalizedKey {
    var identifier: String {
        (self as? (any RawRepresentable))?.rawValue as? String ?? ""
    }
}

public extension String {
    static func localized(_ key: LocalizedKey) -> String {
        NSLocalizedString(key.identifier, bundle: LanguageManager.bundle, comment: "")
    }
}

public extension Text {
    init(_ key: LocalizedKey) {
        self.init(String.localized(key))
    }
}

public extension Button where Label == Text {
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
                let language = UserDefaults.language
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

public extension Bundle {
    static func setLanguage(_ language: Language) {
        UserDefaults.language = language
        if let path = Bundle.main.path(forResource: language.code, ofType: "lproj") {
            LanguageManager.bundle = Bundle(path: path) ?? Bundle.main
        } else {
            LanguageManager.bundle = Bundle.main
        }
    }
}

public enum Language: String, CaseIterable {
    case system = "System"
    case english = "English"
    case french = "French"
    case vietnamese = "Vietnamese"

    public var code: String {
        switch self {
        case .system: Locale.preferredLanguages.first ?? "en"
        case .english: "en"
        case .french: "fr"
        case .vietnamese: "vi"
        }
    }
}

public class LanguageManager: ObservableObject {
    @LocalizedBundle static var bundle: Bundle

    @Published public var currentLanguage: Language {
        didSet {
            Bundle.setLanguage(currentLanguage)
        }
    }

    public init() {
        currentLanguage = UserDefaults.language
    }
}
