//
//  TextView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI
import UIComponents

struct TextView: View {
    var body: some View {
        VStack(spacing: DSConstants.Spacing.spacing16) {
            DSText("Default")
            DSText("Bold - Large")
                .type(.bold(.large))
                .color(.appColor(.blue100))
            DSText("Medium - Medium")
                .type(.medium(.medium))
                .color(.appColor(.blue10))
            DSText("Small - Regular")
                .type(.regular(.small))
                .color(.appColor(.blue100))
            DSText("This is a very very very very very very long Bold - Medium")
                .type(.bold(.medium))
            DSText("This is a very very very very very very very very very long Medium - Small")
                .type(.medium(.small))
                .lineLimit(1)
        }
        .padding(.horizontal, DSConstants.Spacing.spacing40)
    }
}

#Preview {
    TextView()
}
