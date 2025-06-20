//
//  DSButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

/// A custom button style for `DSButton` that defines the appearance based on the button's type.
struct DSButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled  // Access to the button's enabled state
    
    private let type: DSButtonType  // The type of the button
    private let primaryColor: Color  // The primary color used for the button
    private let secondaryColor: Color  // The secondary color used for the button
    
    /// Initializes a new `DSButtonStyle` with a specific type and optional color values.
    /// - Parameters:
    ///   - type: The type of the button (e.g., filled, bordered, icon, etc.)
    ///   - primaryColor: The primary color for the button (default is `.teal`)
    ///   - secondaryColor: The secondary color for the button (default is `.appColor(.bgPrimary)`)
    init(
        type: DSButtonType,
        primaryColor: Color = .teal,
        secondaryColor: Color = .appColor(.bgPrimary)
    ) {
        self.type = type
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
    }
    
    /// Builds the body of the button style, configuring its appearance based on the button's state.
    /// - Parameter configuration: The configuration containing the button's label and state.
    /// - Returns: The view representing the button with its defined style.
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .if(isIcon) {  // Custom modifier to handle icon-specific styling
                $0.frame(width: type.height, height: type.height)
            } else: {
                $0.lineLimit(1)
                    .font(type.fontSize)
                    .padding(.horizontal, type.padding)
                    .frame(height: type.height)
                    .if(type.sizeMode == .expanded) {
                        $0.frame(maxWidth: 400)
                    }
            }
            .foregroundStyle(isBordered ? primaryColor : secondaryColor)  // Set text color based on button type
            .background(isBordered ? secondaryColor : primaryColor)  // Set background color based on button type
            .if(isBordered) {  // Apply border for bordered button types
                $0.overlay(
                    RoundedRectangle(
                        cornerRadius: isCircularIcon ? type.height / 2 : DSRadius.large
                    )
                    .strokeBorder(lineWidth: DSStroke.thick)
                    .foregroundStyle(isBordered ? primaryColor : secondaryColor)  // Border color
                )
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: isCircularIcon ? type.height / 2 : DSRadius.large
                )
            )  // Rounded corners
            .opacity(configuration.isPressed || !isEnabled ? 0.6 : 1)  // Dim the button when pressed or disabled
    }
}

private extension DSButtonStyle {
    /// Checks if the button type is a filled button.
    var isFilled: Bool {
        switch type {
        case .filled, .icon(.normal(.filled)), .icon(.circular(.filled)): true
        default: false
        }
    }
    
    /// Checks if the button type is a bordered button.
    var isBordered: Bool {
        switch type {
        case .bordered, .icon(.normal(.bordered)), .icon(.circular(.bordered)): true
        default: false
        }
    }
    
    /// Checks if the button type is an icon button.
    var isIcon: Bool {
        switch type {
        case .icon: true
        default: false
        }
    }
    
    /// Checks if the button type is a circular icon button.
    var isCircularIcon: Bool {
        switch type {
        case .icon(.circular): true
        default: false
        }
    }
}
