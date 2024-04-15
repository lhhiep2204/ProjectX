//
//  DSFont.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 14/4/24.
//

import SwiftUI

public enum DSFont {
    case regular(CGFloat), medium(CGFloat), bold(CGFloat)

    var weight: String {
        switch self {
        case .regular: "RoundedMplus1c-Regular"
        case .medium: "RoundedMplus1c-Medium"
        case .bold: "RoundedMplus1c-Bold"
        }
    }

    var size: CGFloat {
        switch self {
        case .regular(let size), .medium(let size), .bold(let size): size
        }
    }
}

public enum DSSystemFont {
    case regular(CGFloat), medium(CGFloat), bold(CGFloat)

    var weight: Font.Weight {
        switch self {
        case .regular: .regular
        case .medium: .medium
        case .bold: .bold
        }
    }

    var size: CGFloat {
        switch self {
        case .regular(let size), .medium(let size), .bold(let size): size
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
