//
//  DSColor.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 10/04/2024.
//

import SwiftUI

public enum DSColor: String {
    // MARK: - Background
    case bgPrimary = "background.primary"
    case bgPrimaryReverse = "background.primary.reverse"
    case bgSecondary = "background.secondary"
    case bgSecondaryReverse = "background.secondary.reverse"

    // MARK: - Text
    case textPrimary = "text.primary"
    case textSecondary = "text.secondary"

    // MARK: - Shade
    case blue10 = "blue.10"
    case blue100 = "blue.100"

    case gray10 = "gray.10"
    case gray20 = "gray.20"
    case gray40 = "gray.40"
    case gray60 = "gray.60"
    case gray80 = "gray.80"
    case gray100 = "gray.100"

    // MARK: - Other
    case divider = "divider"
}

public extension Color {
    static func appColor(_ color: DSColor) -> Self {
        .init(color.rawValue, bundle: .uiComponents)
    }
}

#if os(iOS)
public extension UIColor {
    static func appColor(_ color: DSColor) -> UIColor {
        guard let color = UIColor(named: color.rawValue, 
                                  in: .uiComponents,
                                  compatibleWith: .current) else {
            return .clear
        }

        return color
    }
}
#endif
