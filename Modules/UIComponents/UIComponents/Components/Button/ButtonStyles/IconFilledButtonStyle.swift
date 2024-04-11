//
//  IconFilledButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 08/04/2024.
//

import SwiftUI

public struct IconFilledButtonStyle: ButtonStyle {
    let size: CGFloat
    let isCircle: Bool
    let foregroundColor: Color
    let backgroundColor: Color

    public init(size: CGFloat = 44,
                isCircle: Bool = false,
                foregroundColor: Color = .white,
                backgroundColor: Color = .appColor(.blue100)) {
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
            .cornerRadius(isCircle ? size / 2 : 8)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
