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
        DSButtonStyle(type: .filled(.medium(.fill)))
    }

    static var filledSmall: DSButtonStyle {
        DSButtonStyle(type: .filled(.small(.fill)))
    }

    static var filledDestructiveSmallFit: DSButtonStyle {
        DSButtonStyle(type: .filled(.small(.fit)), primaryColor: .red)
    }
}

// MARK: - BorderedButtonStyle
public extension ButtonStyle where Self == DSButtonStyle {
    static var bordered: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium(.fill)))
    }

    static var borderedSmallFit: DSButtonStyle {
        DSButtonStyle(type: .bordered(.small(.fit)))
    }

    static var borderedDestructive: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium(.fill)), primaryColor: .red)
    }
}

// MARK: - IconButtonStyle
public extension ButtonStyle where Self == DSButtonStyle {
    static var borderedCircleSmallIcon: DSButtonStyle {
        DSButtonStyle(type: .icon(.circle(.bordered(.small(.fill)))))
    }

    static var filledIcon: DSButtonStyle {
        DSButtonStyle(type: .icon(.normal(.filled(.medium(.fill)))))
    }
}
