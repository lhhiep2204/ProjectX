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
            VStack(spacing: 16) {
                DSText("Default")
                DSText("Bold - Large")
                    .type(.bold(.large))
                    .color(.appColor(.blue40))
                DSText("Medium - Medium")
                    .type(.medium(.medium))
                    .color(.appColor(.blue60))
                DSText("Small - Regular")
                    .type(.regular(.small))
                    .color(.appColor(.blue80))
                DSText("This is a very very very very very very long Bold - Medium")
                    .type(.bold(.medium))
                DSText("This is a very very very very very very long Medium - Small")
                    .type(.medium(.small))
                    .lineLimit(1)
            }
            .padding(.horizontal, 80)
        }
    }
}

#Preview {
    TextView()
}
