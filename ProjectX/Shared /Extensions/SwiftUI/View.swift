//
//  View.swift
//  Extensions
//
//  Created by Hoàng Hiệp Lê on 07/04/2024.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the given transform if the given condition evaluates to `true`, otherwise applies the `elseTransform`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: A closure that modifies the `View` if the condition is met.
    ///   - elseTransform: A closure that modifies the `View` if the condition is not met.
    /// - Returns: Either the transformed `View` based on the `condition`.
    @ViewBuilder
    func `if`<IfContent: View, ElseContent: View>(
        _ condition: Bool,
        transform: (Self) -> IfContent,
        else elseTransform: (Self) -> ElseContent
    ) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}

// MARK: - Border

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

extension View {
    /// Adds a border with a specified corner radius, border color, and line width to the view.
    ///
    /// - Parameters:
    ///   - radius: The radius of the border's corners. Default is 8.
    ///   - color: The color of the border. Default is clear.
    ///   - lineWidth: The width of the border line. Default is 0.
    ///
    /// - Returns: A view with the specified border applied.
    func border(
        radius: CGFloat = 8,
        color: Color = .clear,
        lineWidth: CGFloat = 0
    ) -> some View {
        modifier(CustomBorder(cornerRadius: radius,
                              borderColor: color,
                              lineWidth: lineWidth))
    }
}

// MARK: - Shadow

/// A view modifier that applies a shadow with configurable color, radius, and offset.
struct DSShadowModifier: ViewModifier {
    let color: Color
    let radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(
                color: color,
                radius: radius,
                y: 3
            )
    }
}

extension View {
    /// Applies a design system shadow to the view.
    /// - Parameters:
    ///   - color: The shadow color. Default is `.gray.opacity(0.3)`.
    ///   - radius: The shadow radius. Default is `DSRadius.medium`.
    /// - Returns: A view modified with shadow styling.
    func dsShadow(
        color: Color = .gray.opacity(0.3),
        radius: CGFloat = DSRadius.small
    ) -> some View {
        self.modifier(DSShadowModifier(color: color, radius: radius))
    }
}
