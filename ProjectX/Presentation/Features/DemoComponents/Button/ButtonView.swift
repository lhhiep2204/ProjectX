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
                    style: .borderedDestructive,
                    loading: true
                ) {}
                DSButton(
                    "Bordered Destructive Fit",
                    style: .borderedDestructiveFit
                ) {}
                
                // Icon Buttons
                HStack(spacing: DSSpacing.spacing24) {
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
}

#Preview {
    ButtonView()
}
