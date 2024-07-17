//
//  BottomSheetView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 25/6/24.
//

import SwiftUI
import UIComponents

struct BottomSheetView: View {
    @State private var showBottonSheet: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: DSConstants.Spacing.spacing16) {
                DSButton("Show bottom sheet", style: .filled) {
                    showBottonSheet = true
                }
            }
            .padding()
        }
        .sheet(isPresented: $showBottonSheet) {
            bottomSheet
        }
    }
}

extension BottomSheetView {
    private var bottomSheet: some View {
        DSBottomSheet(detents: [.fraction(0.3), .medium]) {
            DSText("Bottom sheet content")
                .padding()
        }
        .backgroundInteraction(.disabled)
        .dismissible()
    }
}

#Preview {
    BottomSheetView()
}
