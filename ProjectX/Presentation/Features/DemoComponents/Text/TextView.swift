//
//  TextView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: DSSpacing.spacing16) {
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
}

#Preview {
    TextView()
}
