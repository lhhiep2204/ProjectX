//
//  ButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

// MARK: - FilledButtonStyle
public extension ButtonStyle where Self == DSButtonStyle {
    static var filled: DSButtonStyle {
        DSButtonStyle(type: .filled(.medium))
    }

    static var filledSmall: DSButtonStyle {
        DSButtonStyle(type: .bordered(.small))
    }

    static var filledDestructive: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium), primaryColor: .red)
    }
}

// MARK: - BorderedButtonStyle
public extension ButtonStyle where Self == DSButtonStyle {
    static var bordered: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium))
    }

    static var borderedSmall: DSButtonStyle {
        DSButtonStyle(type: .bordered(.small))
    }

    static var borderedDestructive: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium), primaryColor: .red)
    }
}

// MARK: - IconButtonStyle
public extension ButtonStyle where Self == DSButtonStyle {
    static var filledIcon: DSButtonStyle {
        DSButtonStyle(type: .icon(.filled(.medium)))
    }

    static var borderedIcon: DSButtonStyle {
        DSButtonStyle(type: .icon(.bordered(.medium)))
    }
}
