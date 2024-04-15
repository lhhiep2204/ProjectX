//
//  DSTextType.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 15/4/24.
//

import SwiftUI

public enum DSTextType {
    case regular(DSTextSize), medium(DSTextSize), bold(DSTextSize)

    var font: Font {
        switch self {
        case .regular(let size): .appFont(.regular(size.size))
        case .medium(let size): .appFont(.medium(size.size))
        case .bold(let size): .appFont(.bold(size.size))
        }
    }
}

public enum DSTextSize {
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
