//
//  DialogView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 23/4/24.
//

import SwiftUI
import UIComponents

struct DialogView: View {
    @State private var showDialog: Bool = false
    @State private var showConfirmationDialog: Bool = false
    @State private var showOptionDialog: Bool = false

    var body: some View {
        VStack(spacing: DSConstants.Spacing.spacing16) {
            DSButton("Show dialog", style: .filled) {
                withAnimation {
                    showDialog = true
                }
            }
            DSButton("Show confirmation dialog", style: .filled) {
                withAnimation {
                    showConfirmationDialog = true
                }
            }
            DSButton("Show option dialog", style: .filled) {
                withAnimation {
                    showOptionDialog = true
                }
            }
        }
        .padding(.horizontal)
        .showDialog($showDialog,
                    title: "Dialog",
                    button: .init(title: "Call to action",
                                  action: {}))
        .showConfirmationDialog($showConfirmationDialog,
                                title: "Dialog",
                                subtitle: "Alert text goes here",
                                leftButton: .init(title: "Cancel",
                                                  action: {}),
                                rightButton: .init(title: "Call to action",
                                                   action: {}))
        .showOptionDialog($showOptionDialog,
                          title: "Dialog",
                          subtitle: "Alert text goes here",
                          image: .appSystemIcon(.apple),
                          leftButton: .init(title: "Call to action",
                                            action: {}),
                          rightButton: .init(title: "Call to action",
                                             action: {}))
    }
}

#Preview {
    DialogView()
}
