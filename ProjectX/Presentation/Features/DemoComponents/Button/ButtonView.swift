//
//  ButtonView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        ScrollView {
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
    }
}

#Preview {
    ButtonView()
}
