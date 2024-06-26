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
        ScrollView {
            VStack(spacing: DSConstants.Spacing.spacing16) {
                DSButton("Call to action",
                         style: .filled) {}
                    .image(.appIcon(.location))
                    .shadow()
                DSButton("Call to action",
                         style: .borderedDestructive) {}
                DSButton("Call to action",
                         style: .bordered) {}
                    .loading(true)
                DSButton("Call to action",
                         style: .filledSmall) {}
                    .loading(true)
                    .frame(width: 160)
                DSButton("Call to action",
                         style: .filledDestructiveSmallFit) {}
                    .shadow()
                    .disabled(true)
                HStack(spacing: DSConstants.Spacing.spacing20) {
                    DSButton("Small",
                             style: .borderedSmallFit) {}
                        .shadow()
                    DSButton("Medium",
                             style: .borderedFit) {}
                        .shadow()
                    DSButton("Large",
                             style: .borderedLargeFit) {}
                        .shadow()
                }
                HStack(spacing: DSConstants.Spacing.spacing20) {
                    DSButton(image: .appSystemIcon(.apple),
                             style: .borderedCircleIcon) {}
                    DSButton(image: .appSystemIcon(.apple),
                             style: .filledIcon) {}
                        .shadow()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ButtonView()
}
