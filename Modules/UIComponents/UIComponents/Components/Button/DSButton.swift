//
//  DSButton.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

final class DSButtonObservable: ObservableObject {
    @Published var disabled: Bool = false
    @Published var image: Image? = nil
    @Published var loading: Bool = false
    @Published var shadow: CGFloat = 0
}

public struct DSButton<S: ButtonStyle>: View {
    @ObservedObject private var object = DSButtonObservable()

    private let title: String?
    private let image: Image?
    private let style: S
    private let action: () -> Void

    public init(_ title: String,
                style: S,
                _ action: @escaping () -> Void) {
        self.title = title
        self.image = nil
        self.style = style
        self.action = action
    }

    public init(image: Image,
                style: S,
                _ action: @escaping () -> Void) {
        self.title = nil
        self.image = image
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            if object.loading {
                ProgressView()
                    .tint(.appColor(.backgroundSecondaryReverse))
            } else {
                HStack {
                    image ?? object.image
                    titleView
                }
            }
        }
        .buttonStyle(style)
        .if(object.shadow > 0) {
            $0.shadow(radius: object.shadow, y: 3)
        }
        .disabled(object.disabled || object.loading)
    }

    @ViewBuilder
    private var titleView: some View {
        if let title = title {
            Text(title)
        }
    }
}

public extension DSButton {
    func disabled(_ disabled: Bool) -> Self {
        object.disabled = disabled
        return self
    }

    func image(_ image: Image) -> Self {
        object.image = image
        return self
    }

    func loading(_ state: Bool) -> Self {
        object.loading = state
        return self
    }

    func shadow(_ radius: CGFloat = DSConstants.Radius.medium) -> Self {
        object.shadow = radius
        return self
    }
}

#Preview {
    VStack(spacing: DSConstants.Spacing.spacing16) {
        DSButton("Call to action",
                 style: .filled) {}
            .image(.appIcon(.location))
            .shadow()
        DSButton("Call to action",
                 style: .bordered) {}
            .loading(true)
        DSButton("Call to action",
                 style: .filledDestructiveSmallFit) {}
            .shadow()
            .disabled(true)
        DSButton("Call to action",
                 style: .borderedDestructive) {}
        DSButton("Call to action",
                 style: .filledSmall) {}
            .loading(true)
            .frame(width: 160)
        DSButton("Call to action",
                 style: .borderedSmallFit) {}
            .image(.appSystemIcon(.apple))
            .shadow()
        DSButton(image: .appSystemIcon(.apple),
                 style: .borderedCircleSmallIcon) {}
        DSButton(image: .appSystemIcon(.apple),
                 style: .filledIcon) {}
            .shadow()
    }
    .padding()
}
