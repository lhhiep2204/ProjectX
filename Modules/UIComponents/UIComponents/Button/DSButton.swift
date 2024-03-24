//
//  DSButton.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public struct DSButton<S: ButtonStyle>: View {
    let title: String
    let style: S
    let action: () -> Void
    
    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .lineLimit(1)
                .font(.headline)
                .fontWeight(.bold)
        }
        .buttonStyle(style)
    }
}

#Preview {
    VStack(spacing: 16) {
        DSButton(title: "Call to action", style: .filled, action: {})
        DSButton(title: "Call to action", style: .bordered, action: {})
    }
    .padding()
}
