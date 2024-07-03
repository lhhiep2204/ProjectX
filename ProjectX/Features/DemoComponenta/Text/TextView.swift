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
        ScrollView {
            VStack(spacing: DSConstants.Spacing.spacing16) {
                DSText("Default")
                DSText("Bold - Large")
                    .font(.bold(.large))
                    .color(.appColor(.blue100))
                DSText("Medium - Medium")
                    .font(.medium(.medium))
                    .color(.appColor(.blue10))
                DSText("Small - Regular")
                    .font(.regular(.small))
                    .color(.appColor(.blue100))
                DSText("This is a very very very very very very long Bold - Medium")
                    .font(.bold(.medium))
                DSText("This is a very very very very very very very very very long Medium - Small")
                    .font(.medium(.small))
                    .lineLimit(1)
            }
            .padding(.horizontal, DSConstants.Spacing.spacing40)
        }
    }
}

#Preview {
    TextView()
}
