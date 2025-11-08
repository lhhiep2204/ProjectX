//
//  DSButton.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

/// A customizable button component supporting various styles, loading states, images, and reactive localization.
///
/// The title can be provided as a raw `String` or as a `LocalizedKey`. When using a `LocalizedKey`,
/// the button automatically updates when the app language changes via `LanguageManager` in the environment.
struct DSButton<Style: ButtonStyle>: View {
    @Environment(LanguageManager.self) private var languageManager

    /// Provides the button title at render time. Returns `nil` for image-only buttons.
    private let titleProvider: () -> String?

    /// The button image (optional).
    private let image: Image?

    /// The button style.
    private let style: Style

    /// Indicates whether the button is in a loading state.
    private let loading: Bool

    /// The action executed when the button is tapped.
    private let action: () -> Void

    /// Creates a `DSButton` with the specified properties.
    ///
    /// - Parameters:
    ///   - title: The button text (optional).
    ///   - image: An optional image displayed alongside the text.
    ///   - style: The button style.
    ///   - loading: Whether the button shows a loading indicator. Defaults to `false`.
    ///   - action: The closure executed when the button is tapped.
    init(
        _ title: String? = nil,
        image: Image? = nil,
        style: Style,
        loading: Bool = false,
        _ action: @escaping () -> Void
    ) {
        self.titleProvider = { title }
        self.image = image
        self.style = style
        self.loading = loading
        self.action = action
    }
    
    /// Creates a `DSButton` with a localized key for the title. The button updates when language changes.
    /// - Parameters:
    ///   - key: The localized key for the button title.
    ///   - image: An optional image displayed alongside the text.
    ///   - style: The button style.
    ///   - loading: Whether the button shows a loading indicator. Defaults to `false`.
    ///   - action: The closure executed when the button is tapped.
    init(
        _ key: some LocalizedKey,
        image: Image? = nil,
        style: Style,
        loading: Bool = false,
        _ action: @escaping () -> Void
    ) {
        self.titleProvider = { .localized(key) }
        self.image = image
        self.style = style
        self.loading = loading
        self.action = action
    }

    var body: some View {
        let _ = languageManager.currentLanguage
        Button(action: action) {
            ZStack {
                HStack {
                    image
                    titleProvider().map { Text($0) }
                }
                if loading {
                    ProgressView()
                        .tint(.appColor(.textPrimary))
                }
            }
        }
        .buttonStyle(style)
        .disabled(loading)
    }
}

// MARK: - Preview
#Preview {
    ScrollView {
        VStack(spacing: DSSpacing.large) {
            // Filled Buttons
            DSButton(
                "Filled Small",
                style: .filledSmall
            ) {}
            DSButton(
                "Filled Small Fit",
                style: .filledSmallFit
            ) {}
            DSButton(
                "Filled Medium",
                style: .filled
            ) {}
            DSButton(
                "Filled Large",
                style: .filledLarge
            ) {}
                .disabled(true)
            DSButton(
                "Filled Large Fit",
                style: .filledLargeFit
            ) {}
            DSButton(
                "Filled Destructive",
                style: .filledDestructive,
                loading: true
            ) {}
            DSButton(
                "Filled Destructive Large Fit",
                style: .filledDestructiveLargeFit
            ) {}

            // Bordered Buttons
            DSButton(
                "Bordered Small",
                style: .borderedSmall
            ) {}
            DSButton(
                "Bordered Small Fit",
                style: .borderedSmallFit
            ) {}
            DSButton(
                "Bordered Medium",
                style: .bordered
            ) {}
            DSButton(
                "Bordered Medium Fit",
                style: .borderedFit
            ) {}
            DSButton(
                "Bordered Large",
                style: .borderedLarge
            ) {}
                .disabled(true)
            DSButton(
                "Bordered Large Fit",
                style: .borderedLargeFit
            ) {}
            DSButton(
                "Bordered Destructive",
                style: .borderedDestructiveLarge,
                loading: true
            ) {}
            DSButton(
                "Bordered Destructive Fit",
                style: .borderedDestructiveFit
            ) {}

            // Icon Buttons
            HStack(spacing: DSSpacing.xLarge) {
                DSButton(
                    image: .appSystemIcon(.apple),
                    style: .borderedCircularIcon
                ) {}
                DSButton(
                    image: .appSystemIcon(.apple),
                    style: .filledCircularIcon
                ) {}
                DSButton(
                    image: .appSystemIcon(.apple),
                    style: .filledIcon
                ) {}
                DSButton(
                    image: .appSystemIcon(.apple),
                    style: .borderedIcon
                ) {}
                DSButton(
                    image: .appSystemIcon(.apple),
                    style: .borderedDestructiveIcon
                ) {}
            }
        }
        .padding()
    }
}
