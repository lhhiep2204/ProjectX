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
            VStack(spacing: 16) {
                VStack(spacing: 6) {
                    Text("Filled")
                    DSButton("Call to action",
                             style: .filled) {}
                        .image(.appIcon(.location))
                        .shadow()
                }
                VStack(spacing: 6) {
                    Text("Bordered - Loading")
                    DSButton("Call to action",
                             style: .bordered) {}
                        .loading(true)
                }
                VStack(spacing: 6) {
                    Text("Filled - Destructive - Small - Fit")
                    DSButton("Call to action",
                             style: .filledDestructiveSmallFit) {}
                        .shadow()
                        .disabled(true)
                }
                VStack(spacing: 6) {
                    Text("Bordered - Destructive")
                    DSButton("Call to action",
                             style: .borderedDestructive) {}
                }
                VStack(spacing: 6) {
                    Text("Filled - Small")
                    DSButton("Call to action",
                             style: .filledSmall) {}
                        .loading(true)
                        .frame(width: 160)
                }
                VStack(spacing: 6) {
                    Text("Bordered - Small - Fit")
                    DSButton("Call to action",
                             style: .borderedSmallFit) {}
                        .image(.init(systemName: "apple.logo"))
                        .shadow()
                }
                VStack(spacing: 6) {
                    Text("Filled - Circle - Icon")
                    DSButton(image: .appIcon(.location),
                             style: .filledCircleIcon) {}
                }
                VStack(spacing: 6) {
                    Text("Bordered - Icon")
                    DSButton(image: .init(systemName: "apple.logo"),
                             style: .borderedIcon) {}
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
