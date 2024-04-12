//
//  DSButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import Extensions
import SwiftUI

public struct DSButtonStyle: ButtonStyle {
    private let type: DSButtonType
    private let primaryColor: Color
    private let secondaryColor: Color

    public init(type: DSButtonType,
                primaryColor: Color = .appColor(.blue100),
                secondaryColor: Color = .white) {
        self.type = type
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .if(!isIcon) {
                $0.lineLimit(1)
                    .font(type.fontSize)
                    .padding(.horizontal, type.padding)
                    .frame(height: type.height)
                    .if(isMediumSize) { $0.frame(maxWidth: .infinity) }
            }
            .if(isIcon) { $0.frame(width: type.height, height: type.height) }
            .foregroundStyle(isBordered ? primaryColor : secondaryColor)
            .background(isBordered ? secondaryColor : primaryColor)
            .if(isBordered) {
                $0.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 2)
                        .foregroundStyle(isBordered ? primaryColor : secondaryColor)
                )
            }
            .if(isFilled) { $0.cornerRadius(8) }
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

private extension DSButtonStyle {
    var isFilled: Bool {
        switch type {
        case .filled(_), .icon(.filled(_)): true
        default: false
        }
    }

    var isBordered: Bool {
        switch type {
        case .bordered(_), .icon(.bordered(_)): true
        default: false
        }
    }

    var isIcon: Bool {
        switch type {
        case .icon(_): true
        default: false
        }
    }

    var isMediumSize: Bool {
        switch type {
        case .filled(.medium), .bordered(.medium), .icon(.filled(.medium)), .icon(.bordered(.medium)): true
        default: false
        }
    }
}
