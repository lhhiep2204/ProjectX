//
//  DSText.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 15/4/24.
//

import SwiftUI

final class DSTextObservable: ObservableObject {
    @Published var type: DSTextType = .regular(.medium)
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
            .font(object.type.font)
            .foregroundStyle(object.color)
            .lineLimit(object.lineLimit)
    }
}

public extension DSText {
    func type(_ type: DSTextType) -> Self {
        object.type = type
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
    VStack(spacing: 16) {
        DSText("Default")
        DSText("Bold - Large")
            .type(.bold(.large))
            .color(.appColor(.blue40))
        DSText("Medium - Medium")
            .type(.medium(.medium))
            .color(.appColor(.blue60))
        DSText("Small - Regular")
            .type(.regular(.small))
            .color(.appColor(.blue80))
        DSText("This is a very very very very very very long Bold - Medium")
            .type(.bold(.medium))
        DSText("This is a very very very very very very long Medium - Small")
            .type(.medium(.small))
            .lineLimit(1)
    }
    .padding(.horizontal, 80)
}
