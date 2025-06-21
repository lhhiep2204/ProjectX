//
//  DSButton.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

/// A customizable button component supporting various styles, loading states, and images.
struct DSButton<Style: ButtonStyle>: View {
    /// The button text.
    private let title: String?

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
        self.title = title
        self.image = image
        self.style = style
        self.loading = loading
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                HStack {
                    image
                    title.map { Text($0) }
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
    VStack(spacing: DSSpacing.spacing16) {
        DSButton(
            "Call to action",
            image: .appSystemIcon(.apple),
            style: .filledLarge
        ) {}
            .dsShadow()

        DSButton(
            "Call to action",
            style: .borderedDestructive,
            loading: true
        ) {}

        DSButton(
            "Call to action",
            style: .borderedSmallFit
        ) {}
            .frame(width: 160)

        DSButton(
            "Call to action",
            style: .filledDestructiveLargeFit
        ) {}
            .dsShadow()
            .disabled(true)

        HStack(spacing: DSSpacing.spacing20) {
            DSButton(
                "Small",
                style: .borderedSmallFit
            ) {}
                .dsShadow()
            DSButton(
                "Medium",
                style: .borderedFit
            ) {}
                .dsShadow()
            DSButton(
                "Large",
                style: .borderedLargeFit
            ) {}
                .dsShadow()
        }

        HStack(spacing: DSSpacing.spacing20) {
            DSButton(
                image: .appSystemIcon(.apple),
                style: .borderedCircularIcon
            ) {}
            DSButton(
                image: .appSystemIcon(.apple),
                style: .filledIcon
            ) {}
                .dsShadow()
        }
    }
    .padding()
}
