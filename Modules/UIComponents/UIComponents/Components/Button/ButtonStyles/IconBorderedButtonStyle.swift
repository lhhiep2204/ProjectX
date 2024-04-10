//
//  CircleButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 07/04/2024.
//

import SwiftUI

public struct IconBorderedButtonStyle: ButtonStyle {
    let size: CGFloat
    let isCircle: Bool
    let foregroundColor: Color
    let backgroundColor: Color

    public init(size: CGFloat = 44,
                isCircle: Bool = false,
                foregroundColor: Color = .blue,
                backgroundColor: Color = .white) {
        self.size = size
        self.isCircle = isCircle
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size, height: size)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: isCircle ? size / 2 : 8)
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(foregroundColor)
            )
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
