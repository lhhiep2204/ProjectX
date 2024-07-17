//
//  DSFont.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 14/4/24.
//

import SwiftUI

public enum DSFont {
    case regular(DSFontSize), medium(DSFontSize), bold(DSFontSize)

    var weight: String {
        switch self {
        case .regular: "RoundedMplus1c-Regular"
        case .medium: "RoundedMplus1c-Medium"
        case .bold: "RoundedMplus1c-Bold"
        }
    }

    var size: CGFloat {
        switch self {
        case .regular(let size), .medium(let size), .bold(let size): size.size
        }
    }
}

public enum DSSystemFont {
    case regular(DSFontSize), medium(DSFontSize), bold(DSFontSize)

    var weight: Font.Weight {
        switch self {
        case .regular: .regular
        case .medium: .medium
        case .bold: .bold
        }
    }

    var size: CGFloat {
        switch self {
        case .regular(let size), .medium(let size), .bold(let size): size.size
        }
    }
}

public enum DSFontSize {
    case small, medium, large, other(CGFloat)

    var size: CGFloat {
        switch self {
        case .small: 12
        case .medium: 16
        case .large: 20
        case .other(let size): size
        }
    }
}

public extension Font {
    static func appFont(_ font: DSFont) -> Self {
        .custom(font.weight, size: font.size)
    }

    static func appSystemFont(_ font: DSSystemFont) -> Self {
        .system(size: font.size, weight: font.weight)
    }
}

#if os(iOS)
public extension UIFont {
    static func appFont(_ font: DSFont) -> UIFont {
        guard let font = UIFont(name: font.weight, size: font.size) else {
            return .systemFont(ofSize: 16.0)
        }

        return font
    }
}
#endif
