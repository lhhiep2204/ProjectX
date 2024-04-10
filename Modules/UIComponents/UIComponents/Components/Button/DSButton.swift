//
//  DSButton.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public struct DSButton<S: ButtonStyle>: View {
    let title: String?
    let image: String?
    let systemImage: String?
    let style: S
    let action: () -> Void

    public init(title: String, style: S, action: @escaping () -> Void) {
        self.title = title
        self.image = nil
        self.systemImage = nil
        self.style = style
        self.action = action
    }

    public init(title: String? = nil, image: String, style: S, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.systemImage = nil
        self.style = style
        self.action = action
    }

    public init(title: String? = nil, systemImage: String, style: S, action: @escaping () -> Void) {
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
            if let title = title {
                titleView(title)
            } else {
                imageView
            }
        }
        .buttonStyle(style)
    }

    @ViewBuilder
    private func titleView(_ title: String) -> some View {
        if let image = image {
            Label(title, image: image)
        } else if let systemImage = systemImage {
            Label(title, systemImage: systemImage)
        } else {
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

#Preview {
    VStack(spacing: 16) {
        DSButton(title: "Call to action",
                 systemImage: "apple.logo",
                 style: .filled,
                 action: {})
        DSButton(title: "Call to action",
                 style: .borderedSmall,
                 action: {})
        DSButton(systemImage: "apple.logo",
                 style: .filledIcon,
                 action: {})
        DSButton(title: "Call to action",
                 style: .borderedDestructive,
                 action: {})
    }
    .padding()
}
