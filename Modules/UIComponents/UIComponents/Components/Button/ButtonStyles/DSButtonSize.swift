//
//  DSButtonSize.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 12/4/24.
//

import SwiftUI

public enum DSButtonSize: Equatable {
    case small, medium

    var fontSize: Font {
        switch self {
        case .small: .system(size: 12, weight: .bold)
        case .medium: .system(size: 16, weight: .bold)
        }
    }

    var padding: CGFloat {
        switch self {
        case .small: 10
        case .medium: 16
        }
    }

    var height: CGFloat {
        switch self {
        case .small: 36
        case .medium: 48
        }
    }
}
