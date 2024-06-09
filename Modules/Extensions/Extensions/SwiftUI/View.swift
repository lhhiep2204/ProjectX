//
//  View.swift
//  Extensions
//
//  Created by Hoàng Hiệp Lê on 07/04/2024.
//

import SwiftUI

public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - CustomBorder ViewModifier

/// A view modifier that adds a border with a specified corner radius, border color, and line width to any view.
struct CustomBorder: ViewModifier {
    let cornerRadius: CGFloat
    let borderColor: Color
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            }
    }
}

public extension View {
    /// Adds a border with a specified corner radius, border color, and line width to the view.
    ///
    /// - Parameters:
    ///   - cornerRadius: The radius of the border's corners. Default is 8.
    ///   - borderColor: The color of the border. Default is clear.
    ///   - lineWidth: The width of the border line. Default is 0.
    ///
    /// - Returns: A view with the specified border applied.
    func border(cornerRadius: CGFloat = 8,
                borderColor: Color = .clear,
                lineWidth: CGFloat = 0) -> some View {
        modifier(CustomBorder(cornerRadius: cornerRadius,
                              borderColor: borderColor,
                              lineWidth: lineWidth))
    }
}
