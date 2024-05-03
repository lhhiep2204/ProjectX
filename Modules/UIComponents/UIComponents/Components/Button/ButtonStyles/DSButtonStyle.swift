//
//  DSButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public struct DSButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    private let type: DSButtonType
    private let primaryColor: Color
    private let secondaryColor: Color

    public init(type: DSButtonType,
                primaryColor: Color = .appColor(.blue100),
                secondaryColor: Color = .appColor(.backgroundPrimary)) {
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
                    .if(type.sizeMode == .fill) { $0.frame(maxWidth: 400) }
            }
            .if(isIcon) { $0.frame(width: type.height, height: type.height) }
            .foregroundStyle(isBordered ? primaryColor : secondaryColor)
            .background(isBordered ? secondaryColor : primaryColor)
            .if(isBordered) {
                $0.overlay(
                    RoundedRectangle(cornerRadius: isCircleIcon ? type.height / 2 : DSConstants.Radius.large)
                        .strokeBorder(lineWidth: 2)
                        .foregroundStyle(isBordered ? primaryColor : secondaryColor)
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: isCircleIcon ? type.height / 2 : DSConstants.Radius.large))
            .opacity(configuration.isPressed || !isEnabled ? 0.85 : 1)
    }
}

private extension DSButtonStyle {
    var isFilled: Bool {
        switch type {
        case .filled(_), .icon(.normal(.filled(_))), .icon(.circle(.filled(_))): true
        default: false
        }
    }

    var isBordered: Bool {
        switch type {
        case .bordered(_), .icon(.normal(.bordered(_))), .icon(.circle(.bordered(_))): true
        default: false
        }
    }

    var isIcon: Bool {
        switch type {
        case .icon(_): true
        default: false
        }
    }

    var isCircleIcon: Bool {
        switch type {
        case .icon(.circle(_)): true
        default: false
        }
    }
}
