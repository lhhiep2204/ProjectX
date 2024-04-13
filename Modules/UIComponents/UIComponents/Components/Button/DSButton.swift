//
//  DSButton.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

final class DSButtonObservable: ObservableObject {
    @Published var shadow: CGFloat = 0
    @Published var loading: Bool = false
}

public struct DSButton<S: ButtonStyle>: View {
    @ObservedObject private var object = DSButtonObservable()

    private let title: String?
    private let image: String?
    private let systemImage: String?
    private let style: S
    private let action: () -> Void

    public init(_ title: String,
                style: S,
                _ action: @escaping () -> Void) {
        self.title = title
        self.image = nil
        self.systemImage = nil
        self.style = style
        self.action = action
    }

    public init(_ title: String? = nil,
                image: String,
                style: S,
                _ action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.systemImage = nil
        self.style = style
        self.action = action
    }

    public init(_ title: String? = nil,
                systemImage: String,
                style: S,
                _ action: @escaping () -> Void) {
        self.title = title
        self.image = nil
        self.systemImage = systemImage
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
                    imageView
                    titleView
                }
            }
        }
        .buttonStyle(style)
        .if(object.shadow > 0) {
            $0.shadow(radius: object.shadow, y: 3)
        }
        .disabled(object.loading)
    }

    @ViewBuilder
    private var titleView: some View {
        if let title = title {
            Text(title)
        }
    }

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }

        if let systemImage = systemImage {
            Image(systemName: systemImage)
        }
    }
}

public extension DSButton {
    func shadow(_ radius: CGFloat = 5) -> Self {
        object.shadow = radius
        return self
    }

    func loading(_ state: Bool) -> Self {
        object.loading = state
        return self
    }
}

#Preview {
    VStack(spacing: 16) {
        VStack(spacing: 6) {
            Text("Filled")
            DSButton("Call to action",
                     systemImage: "apple.logo",
                     style: .filled) {}
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
                     systemImage: "apple.logo",
                     style: .borderedSmallFit) {}
                .shadow()
        }
        VStack(spacing: 6) {
            Text("Filled - Circle - Icon")
            DSButton(systemImage: "apple.logo",
                     style: .filledCircleIcon) {}
        }
        VStack(spacing: 6) {
            Text("Bordered - Icon")
            DSButton(systemImage: "apple.logo",
                     style: .borderedIcon) {}
                .shadow()
        }
    }
    .padding()
}
