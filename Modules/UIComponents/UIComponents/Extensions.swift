//
//  Extensions.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 11/04/2024.
//

import SwiftUI

// MARK: - Bundle
class UIComponentsBundle { }

extension Bundle {
    static var uiComponents: Bundle {
        .init(for: UIComponentsBundle.self)
    }
}

// MARK: - View
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
