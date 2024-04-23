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
                    .tint(.appColor(.gray40))
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

    func shadow(_ radius: CGFloat = 5) -> Self {
        object.shadow = radius
        return self
    }
}

#Preview {
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
                .image(.appSystemIcon(.apple))
                .shadow()
        }
        VStack(spacing: 6) {
            Text("Filled - Circle - Icon")
            DSButton(image: .appIcon(.location),
                     style: .filledCircleIcon) {}
        }
        VStack(spacing: 6) {
            Text("Bordered - Icon")
            DSButton(image: .appSystemIcon(.apple),
                     style: .borderedIcon) {}
                .shadow()
        }
    }
    .padding()
}
