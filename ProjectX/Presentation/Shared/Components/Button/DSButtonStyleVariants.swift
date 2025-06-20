//
//  ButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

// MARK: - FilledButtonStyle
extension ButtonStyle where Self == DSButtonStyle {
    static var filled: DSButtonStyle {
        DSButtonStyle(type: .filled(.medium(.expanded)))
    }
    
    static var filledSmall: DSButtonStyle {
        DSButtonStyle(type: .filled(.small(.expanded)))
    }
    
    static var filledLarge: DSButtonStyle {
        DSButtonStyle(type: .filled(.large(.expanded)))
    }
    
    static var filledDestructiveSmallFit: DSButtonStyle {
        DSButtonStyle(type: .filled(.small(.adaptive)), primaryColor: .red)
    }
}

// MARK: - BorderedButtonStyle
extension ButtonStyle where Self == DSButtonStyle {
    static var bordered: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium(.expanded)))
    }
    
    static var borderedFit: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium(.adaptive)))
    }
    
    static var borderedSmallFit: DSButtonStyle {
        DSButtonStyle(type: .bordered(.small(.adaptive)))
    }
    
    static var borderedLargeFit: DSButtonStyle {
        DSButtonStyle(type: .bordered(.large(.adaptive)))
    }
    
    static var borderedDestructive: DSButtonStyle {
        DSButtonStyle(type: .bordered(.medium(.expanded)), primaryColor: .red)
    }
}

// MARK: - IconButtonStyle
extension ButtonStyle where Self == DSButtonStyle {
    static var borderedCircularIcon: DSButtonStyle {
        DSButtonStyle(type: .icon(.circular(.bordered(.small(.expanded)))))
    }
    
    static var filledIcon: DSButtonStyle {
        DSButtonStyle(type: .icon(.normal(.filled(.medium(.expanded)))))
    }
}
