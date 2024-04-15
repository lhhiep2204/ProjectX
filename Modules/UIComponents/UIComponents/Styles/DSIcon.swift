//
//  DSIcon.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 15/4/24.
//

import SwiftUI

public enum DSIcon: String {
    case location = "ic.location"
}

public enum DSSystemIcon: String {
    case apple = "apple.logo"
}

public extension Image {
    static func appIcon(_ icon: DSIcon) -> Self {
        .init(icon.rawValue, bundle: .uiComponents)
    }

    static func appSystemIcon(_ icon: DSSystemIcon) -> Self {
        .init(systemName: icon.rawValue)
    }
}
