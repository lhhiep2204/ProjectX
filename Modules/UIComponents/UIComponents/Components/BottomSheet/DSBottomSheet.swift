//
//  DSBottomSheet.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 16/5/24.
//

import SwiftUI

public struct DSBottomSheet<Content: View>: View {
    private let content: Content
    private let detents: Set<PresentationDetent>
    @Binding private var selectedDetent: PresentationDetent


    public init(detents: Set<PresentationDetent>,
                selectedDetent: Binding<PresentationDetent>,
                _ content: () -> Content) {
        self.detents = detents
        _selectedDetent = selectedDetent
        self.content = content()
    }

    public init(detents: Set<PresentationDetent>,
                _ content: () -> Content) {
        self.detents = detents
        _selectedDetent = .constant(.medium)
        self.content = content()
    }

    public var body: some View {
        containerView
            .presentationDetents(detents,
                                 selection: $selectedDetent)
            .presentationBackgroundInteraction(.enabled)
            .interactiveDismissDisabled()
    }
}

extension DSBottomSheet {
    private var containerView: some View {
        VStack {
            content
            Spacer()
        }
    }
}

#Preview {
    DSBottomSheet(detents: [.medium]) {
        Text("Bottom sheet content")
    }
}
