//
//  DSText.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 15/4/24.
//

import SwiftUI

final class DSTextObservable: ObservableObject {
    @Published var font: DSFont = .regular(.medium)
    @Published var color: Color = .appColor(.textPrimary)
    @Published var lineLimit: Int? = nil
}

public struct DSText: View {
    @ObservedObject private var object = DSTextObservable()

    private let title: String

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
            .font(.appFont(object.font))
            .foregroundStyle(object.color)
            .lineLimit(object.lineLimit)
    }
}

public extension DSText {
    func font(_ font: DSFont) -> Self {
        object.font = font
        return self
    }

    func color(_ color: Color) -> Self {
        object.color = color
        return self
    }

    func lineLimit(_ number: Int) -> Self {
        object.lineLimit = number
        return self
    }
}

#Preview {
    VStack(spacing: DSConstants.Spacing.spacing16) {
        DSText("Default")
        DSText("Bold - Large")
            .font(.bold(.large))
            .color(.appColor(.blue100))
        DSText("Medium - Medium")
            .font(.medium(.medium))
            .color(.appColor(.blue10))
        DSText("Small - Regular")
            .font(.regular(.small))
            .color(.appColor(.blue100))
        DSText("This is a very very very very very very long Bold - Medium")
            .font(.bold(.medium))
        DSText("This is a very very very very very very very very very long Medium - Small")
            .font(.medium(.small))
            .lineLimit(1)
    }
    .padding(.horizontal, DSConstants.Spacing.spacing40)
}
