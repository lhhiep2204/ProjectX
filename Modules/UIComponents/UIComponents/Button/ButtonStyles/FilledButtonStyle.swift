//
//  FilledButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public struct FilledButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color

    public init(foregroundColor: Color = .white, backgroundColor: Color = .blue) {
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
