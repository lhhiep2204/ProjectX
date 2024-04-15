//
//  Extensions.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 11/04/2024.
//

import Foundation

// MARK: - Bundle
class UIComponentsBundle { }

extension Bundle {
    static var uiComponents: Bundle {
        Bundle(for: UIComponentsBundle.self)
    }
}
