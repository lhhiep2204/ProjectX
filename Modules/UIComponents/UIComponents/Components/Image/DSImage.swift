//
//  DSImage.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 7/5/24.
//

import SwiftUI

final class DSImageObservable: ObservableObject {
    @Published var font: DSFont = .regular(.medium)
    @Published var color: Color = .appColor(.bgPrimaryReverse)
}

public struct DSImage: View {
    @ObservedObject private var object = DSImageObservable()

    private let image: Image

    public init(_ image: Image) {
        self.image = image
    }

    public var body: some View {
        image
            .font(.appFont(object.font))
            .foregroundStyle(object.color)
    }
}

// MARK: - Public methods
public extension DSImage {
    /// Sets the font of the image.
    /// - Parameter font: The desired DSFont for the image.
    /// - Returns: The updated DSImage.
    func font(_ font: DSFont) -> Self {
        object.font = font
        return self
    }

    /// Sets the color of the image.
    /// - Parameter color: The desired color for the image.
    /// - Returns: The updated DSImage.
    func color(_ color: Color) -> Self {
        object.color = color
        return self
    }
}

#Preview {
    DSImage(.appSystemIcon(.apple))
}
