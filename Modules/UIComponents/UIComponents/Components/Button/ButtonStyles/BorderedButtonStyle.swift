//
//  BorderedButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import Extensions
import SwiftUI

public struct BorderedButtonStyle: ButtonStyle {
    let size: ButtonSize
    let foregroundColor: Color
    let backgroundColor: Color

    public init(size: ButtonSize = .medium,
                foregroundColor: Color = .blue,
                backgroundColor: Color = .white) {
        self.size = size
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .lineLimit(1)
            .font(size.fontSize)
            .foregroundStyle(foregroundColor)
            .padding(size.padding)
            .if(size == .medium) { $0.frame(maxWidth: .infinity) }
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(foregroundColor)
            )
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
