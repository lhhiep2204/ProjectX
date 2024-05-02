//
//  LanguageManager.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 26/4/24.
//

import SwiftUI

public struct Keys {}
public protocol LocalizedKey {}

extension LocalizedKey {
    var identifier: String {
        (self as? (any RawRepresentable))?.rawValue as? String ?? ""
    }
}

@propertyWrapper
struct LocalizedBundle {
    private var bundle: Bundle?

    var wrappedValue: Bundle {
        mutating get {
            if bundle == nil {
                let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
                let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
                bundle = Bundle(path: path!)
            }
            return bundle!
        }
        set {
            bundle = newValue
        }
    }
}

public class LanguageManager: ObservableObject {
    @LocalizedBundle static var bundle: Bundle

    @Published public var currentLanguage: Language {
        didSet {
            UserDefaults.language = currentLanguage
            Bundle.setLanguage(lang: currentLanguage.code)
        }
    }

    public init() {
        currentLanguage = UserDefaults.language
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
