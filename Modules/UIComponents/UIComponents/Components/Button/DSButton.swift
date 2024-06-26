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
                    .tint(.appColor(.bgSecondaryReverse))
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

// MARK: - Public methods
public extension DSButton {
    /// Sets the disabled state of the button.
    /// - Parameter disabled: A Boolean value indicating whether the button is disabled.
    /// - Returns: The updated DSButton.
    func disabled(_ disabled: Bool) -> Self {
        object.disabled = disabled
        return self
    }

    /// Sets an image to be displayed in the button.
    /// - Parameter image: The image to be displayed.
    /// - Returns: The updated DSButton.
    func image(_ image: Image) -> Self {
        object.image = image
        return self
    }

    /// Sets the loading state of the button.
    /// - Parameter state: A Boolean value indicating whether the button is in a loading state.
    /// - Returns: The updated DSButton.
    func loading(_ state: Bool) -> Self {
        object.loading = state
        return self
    }

    /// Sets the shadow radius of the button.
    /// - Parameter radius: The shadow radius. Default is DSConstants.Radius.medium.
    /// - Returns: The updated DSButton.
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
