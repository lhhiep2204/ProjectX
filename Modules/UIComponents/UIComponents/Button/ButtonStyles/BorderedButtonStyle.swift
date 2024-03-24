//
//  BorderedButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public struct BorderedButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color

    public init(foregroundColor: Color = .blue, backgroundColor: Color = .white) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor)
            .padding()
            .frame(maxWidth: .infinity)
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
