//
//  ButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public enum ButtonSize {
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
}

// MARK: - FilledButtonStyle
public extension ButtonStyle where Self == FilledButtonStyle {
    static var filled: FilledButtonStyle {
        FilledButtonStyle()
    }

    static var filledSmall: FilledButtonStyle {
        FilledButtonStyle(size: .small)
    }

    static var filledDestructive: FilledButtonStyle {
        FilledButtonStyle(backgroundColor: .red)
    }
}

// MARK: - BorderedButtonStyle
public extension ButtonStyle where Self == BorderedButtonStyle {
    static var bordered: BorderedButtonStyle {
        BorderedButtonStyle()
    }

    static var borderedSmall: BorderedButtonStyle {
        BorderedButtonStyle(size: .small)
    }

    static var borderedDestructive: BorderedButtonStyle {
        BorderedButtonStyle(foregroundColor: .red)
    }
}

// MARK: - IconFilledButtonStyle
public extension ButtonStyle where Self == IconFilledButtonStyle {
    static var filledIcon: IconFilledButtonStyle {
        IconFilledButtonStyle()
    }

    static var filledIconCircle: IconFilledButtonStyle {
        IconFilledButtonStyle(isCircle: true)
    }
}

// MARK: - IconBorderedButtonStyle
public extension ButtonStyle where Self == IconBorderedButtonStyle {
    static var borderedIcon: IconBorderedButtonStyle {
        IconBorderedButtonStyle()
    }

    static var borderedIconCircle: IconBorderedButtonStyle {
        IconBorderedButtonStyle(isCircle: true)
    }
}
