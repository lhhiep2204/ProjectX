//
//  DSText.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 15/4/24.
//

import SwiftUI

/// A customizable text component that supports dynamic styling.
struct DSText: View {
    /// The text content to be displayed.
    private let title: String

    /// The font style used for displaying text.
    private let font: DSFont

    /// The text color.
    private let color: Color

    /// Creates a `DSText` instance with the specified content and styling.
    ///
    /// - Parameters:
    ///   - title: The text content to be displayed.
    ///   - font: The font style. Defaults to `.regular(.medium)`.
    ///   - color: The text color. Defaults to `.appColor(.textPrimary)`.
    init(
        _ title: String,
        font: DSFont = .regular(.medium),
        color: Color = .appColor(.textPrimary)
    ) {
        self.title = title
        self.font = font
        self.color = color
    }

    /// The SwiftUI body that defines the view hierarchy.
    var body: some View {
        Text(title)
            .font(.appFont(font))
            .foregroundStyle(color)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: DSSpacing.spacing16) {
        DSText("Default")

        DSText(
            "Bold - Large",
            font: .bold(.large)
        )

        DSText(
            "Medium - Medium",
            font: .medium(.medium),
            color: .teal
        )

        DSText(
            "Small - Regular",
            font: .regular(.small)
        )

        DSText(
            "Bold - Medium with a very very very very very very long content",
            font: .bold(.medium)
        )
        .multilineTextAlignment(.center)

        DSText(
            "Medium - Small with a very very very very very very long content",
            font: .medium(.small)
        )
        .lineLimit(1)
    }
    .padding(.horizontal, DSSpacing.spacing40)
}
