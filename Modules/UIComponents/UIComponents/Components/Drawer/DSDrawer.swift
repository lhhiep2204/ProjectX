//
//  DSDrawer.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/5/24.
//

import SwiftUI

public struct DSDrawer<Menu: View, Content: View>: View {
    @Binding private var isOpened: Bool
    private let menu: Menu
    private let content: Content

    public init(isOpened: Binding<Bool>,
                menu: () -> Menu,
                content: () -> Content) {
        _isOpened = isOpened
        self.menu = menu()
        self.content = content()
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            content

            if isOpened {
                Color.gray.opacity(0.2)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isOpened.toggle()
                    }
                menu
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
        }
        .animation(.spring(), value: isOpened)
    }
}

#Preview {
    struct DSPreview: View {
        @State private var isOpened = true

        var body: some View {
            DSDrawer(isOpened: $isOpened,
                     menu: {
                Color.gray
                    .frame(width: 250)
            },
                     content: {
                ZStack {
                    Color.white
                    
                    Button("Open") {
                        withAnimation {
                            isOpened = true
                        }
                    }
                }
            })
            .ignoresSafeArea()
        }
    }

    return DSPreview()
}
