//
//  DSText.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 15/4/24.
//

import SwiftUI

/// A customizable text component that supports dynamic styling and localization.
///
/// - Reactive localization: `DSText` reads `LanguageManager` from the environment
///   and automatically re-renders when `currentLanguage` changes.
/// - Usage: Initialize with a raw `String` or a `LocalizedKey` for localized content.
struct DSText: View {
    /// The language manager from the environment used to trigger re-rendering on language changes.
    @Environment(LanguageManager.self) private var languageManager

    /// A closure that returns the current title. It is evaluated at render time to reflect language changes.
    private let titleProvider: () -> String

    /// The font style used for displaying text.
    private let font: DSFont

    /// The text color.
    private let color: Color

    /// Creates a `DSText` instance with a raw string and optional styling.
    ///
    /// - Parameters:
    ///   - title: The raw text content to be displayed.
    ///   - font: The font style. Defaults to `.regular(.medium)`.
    ///   - color: The text color. Defaults to `.appColor(.textPrimary)`.
    init(
        _ title: String,
        font: DSFont = .regular(.medium),
        color: Color = .appColor(.textPrimary)
    ) {
        self.titleProvider = { title }
        self.font = font
        self.color = color
    }

    /// Creates a `DSText` instance using a localized key and optional styling.
    ///
    /// The view automatically updates when the app language changes, because it
    /// depends on `LanguageManager.currentLanguage` via the environment.
    ///
    /// - Parameters:
    ///   - key: A localized key conforming to `LocalizedKey`.
    ///   - font: The font style. Defaults to `.regular(.medium)`.
    ///   - color: The text color. Defaults to `.appColor(.textPrimary)`.
    init(
        _ key: some LocalizedKey,
        font: DSFont = .regular(.medium),
        color: Color = .appColor(.textPrimary)
    ) {
        self.titleProvider = { .localized(key) }
        self.font = font
        self.color = color
    }

    var body: some View {
        // Establish a dependency on the current language so SwiftUI re-renders this view
        // when the language changes. The actual string is produced by `titleProvider()`
        // at render time, which will resolve to the correct localized string.
        let _ = languageManager.currentLanguage

        Text(titleProvider())
            .font(.appFont(font))
            .foregroundStyle(color)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack(spacing: DSSpacing.large) {
            // Regular Font Weight
            DSText(
                "Regular - Small",
                font: .regular(.small),
                color: .appColor(.textPrimary)
            )

            DSText(
                "Regular - Medium",
                font: .regular(.medium),
                color: .appColor(.textSecondary)
            )

            DSText(
                "Regular - Large",
                font: .regular(.large),
                color: .appColor(.accent)
            )

            DSText(
                "Regular - Custom (18pt) with long content that spans multiple lines",
                font: .regular(.custom(18)),
                color: .red
            )
            .multilineTextAlignment(.center)

            // Medium Font Weight
            DSText(
                "Medium - Small",
                font: .medium(.small),
                color: .appColor(.textPrimary)
            )

            DSText(
                "Medium - Medium",
                font: .medium(.medium),
                color: .appColor(.textSecondary)
            )

            DSText(
                "Medium - Large",
                font: .medium(.large),
                color: .appColor(.accent)
            )

            DSText(
                "Medium - Custom (22pt) with long content that is truncated",
                font: .medium(.custom(22)),
                color: .red
            )
            .lineLimit(1)

            // Bold Font Weight
            DSText(
                "Bold - Small",
                font: .bold(.small),
                color: .appColor(.textPrimary)
            )

            DSText(
                "Bold - Medium",
                font: .bold(.medium),
                color: .appColor(.textSecondary)
            )

            DSText(
                "Bold - Large",
                font: .bold(.large),
                color: .appColor(.accent)
            )

            DSText(
                "Bold - Custom (24pt) with very long content that wraps across multiple lines",
                font: .bold(.custom(24)),
                color: .red
            )
            .multilineTextAlignment(.leading)
        }
        .padding()
    }
}
