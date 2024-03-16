//
//  LocalizedKey.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

public struct Keys { }
public protocol LocalizedKey { }

extension LocalizedKey {
    var identifier: String {
        (self as? (any RawRepresentable))?.rawValue as? String ?? ""
    }
}

public extension String {
    static func localized(_ key: LocalizedKey) -> String {
        NSLocalizedString(key.identifier, comment: "")
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
