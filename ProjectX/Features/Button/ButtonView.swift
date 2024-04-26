//
//  ButtonView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI
import UIComponents

struct ButtonView: View {
    var body: some View {
        VStack(spacing: DSConstants.Spacing.spacing16) {
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Filled")
                DSButton("Call to action",
                         style: .filled) {}
                    .image(.appIcon(.location))
                    .shadow()
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Bordered - Loading")
                DSButton("Call to action",
                         style: .bordered) {}
                    .loading(true)
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Filled - Destructive - Small - Fit")
                DSButton("Call to action",
                         style: .filledDestructiveSmallFit) {}
                    .shadow()
                    .disabled(true)
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Bordered - Destructive")
                DSButton("Call to action",
                         style: .borderedDestructive) {}
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Filled - Small")
                DSButton("Call to action",
                         style: .filledSmall) {}
                    .loading(true)
                    .frame(width: 160)
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Bordered - Small - Fit")
                DSButton("Call to action",
                         style: .borderedSmallFit) {}
                    .image(.appSystemIcon(.apple))
                    .shadow()
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Filled - Circle - Icon")
                DSButton(image: .appSystemIcon(.apple),
                         style: .borderedCircleSmallIcon) {}
            }
            VStack(spacing: DSConstants.Spacing.spacing8) {
                Text("Bordered - Icon")
                DSButton(image: .appSystemIcon(.apple),
                         style: .filledIcon) {}
                    .shadow()
            }
        }
        .padding()
    }
}

#Preview {
    ButtonView()
}
