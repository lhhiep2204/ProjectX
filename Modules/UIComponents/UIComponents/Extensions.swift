//
//  Extensions.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 11/04/2024.
//

import Extensions
import SwiftUI

// MARK: - Color
public extension Color {
    static func appColor(_ named: AppColor) -> Color {
        return .init(named.rawValue, bundle: .uiComponents)
    }
}

// MARK: - Bundle
class UIComponentsBundle { }

extension Bundle {
    static var uiComponents: Bundle {
        Bundle(for: UIComponentsBundle.self)
    }
}
