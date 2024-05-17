//
//  DSDialog.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 23/4/24.
//

import SwiftUI

public struct DSDialog: View {
    @Binding private var isPresented: Bool

    private let title: String?
    private let subtitle: String?
    private let image: Image?
    private let buttonType: DSDialogButtonType

    public init(_ isPresented: Binding<Bool>,
                title: String?,
                subtitle: String?,
                image: Image?,
                buttonType: DSDialogButtonType) {
        _isPresented = isPresented
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.buttonType = buttonType
    }

    public var body: some View {
        VStack(spacing: DSConstants.Spacing.spacing8) {
            titleView
            subtitleView
            imageView
            buttonsView
                .padding(.top)
        }
        .frame(maxWidth: 300)
        .padding(DSConstants.Spacing.spacing24)
        .background(.backgroundPrimary)
        .cornerRadius(DSConstants.Radius.xxLarge)
        .shadow(radius: DSConstants.Radius.xxLarge, y: 3)
    }

    @ViewBuilder
    private var titleView: some View {
        if let title = title {
            DSText(title)
                .font(.bold(.large))
        }
    }

    @ViewBuilder
    private var subtitleView: some View {
        if let subtitle = subtitle {
            DSText(subtitle)
                .font(.medium(.medium))
        }
    }

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.vertical)
        }
    }

    @ViewBuilder
    private var buttonsView: some View {
        switch buttonType {
        case .alert(let button):
            DSButton(button.title, style: .filled) {
                withAnimation {
                    isPresented.toggle()
                }
                button.action()
            }
        case .confirmation(let leftButton, let rightButton):
            HStack {
                DSButton(leftButton.title, style: .borderedDestructive) {
                    withAnimation {
                        isPresented.toggle()
                    }
                    leftButton.action()
                }
                DSButton(rightButton.title, style: .filled) {
                    withAnimation {
                        isPresented.toggle()
                    }
                    rightButton.action()
                }
            }
        case .option(let leftButton, let rightButton):
            HStack {
                DSButton(leftButton.title, style: .filled) {
                    withAnimation {
                        isPresented.toggle()
                    }
                    leftButton.action()
                }
                DSButton(rightButton.title, style: .bordered) {
                    withAnimation {
                        isPresented.toggle()
                    }
                    rightButton.action()
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: DSConstants.Spacing.spacing16) {
            DSDialog(.constant(true),
                     title: "Dialog",
                     subtitle: "Dialog text goes here",
                     image: .appSystemIcon(.apple),
                     buttonType: .alert(.init(title: "Call to action",
                                              action: {})))
            DSDialog(.constant(true),
                     title: "Dialog",
                     subtitle: "Dialog text goes here",
                     image: .appSystemIcon(.apple),
                     buttonType: .confirmation(.init(title: "Cancel",
                                                     action: {}),
                                               .init(title: "Call to action",
                                                     action: {})))
            DSDialog(.constant(true),
                     title: "Dialog",
                     subtitle: "Dialog text goes here",
                     image: .appSystemIcon(.apple),
                     buttonType: .option(.init(title: "Call to action",
                                               action: {}),
                                         .init(title: "Call to action",
                                               action: {})))
        }
    }
}
