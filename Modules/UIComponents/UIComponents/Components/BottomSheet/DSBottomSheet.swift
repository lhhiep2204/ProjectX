//
//  DSBottomSheet.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 16/5/24.
//

import SwiftUI

final class DSBottomSheetObservable: ObservableObject {
    @Published var backgroundInteraction: PresentationBackgroundInteraction = .automatic
    @Published var dismissible: Bool = false
}

public struct DSBottomSheet<Content: View>: View {
    @ObservedObject private var object = DSBottomSheetObservable()

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
        _selectedDetent = .constant(detents.first ?? .medium)
        self.content = content()
    }

    public var body: some View {
        containerView
            .presentationDetents(detents,
                                 selection: $selectedDetent)
            .presentationBackgroundInteraction(object.backgroundInteraction)
            .if(!object.dismissible) {
                $0.interactiveDismissDisabled()
            }
    }
}

private extension DSBottomSheet {
    var containerView: some View {
        VStack {
            content
            Spacer()
        }
    }
}

public extension DSBottomSheet {
    func backgroundInteraction(_ bginteraction: PresentationBackgroundInteraction) -> Self {
        object.backgroundInteraction = bginteraction
        return self
    }

    func dismissible() -> Self {
        object.dismissible = true
        return self
    }
}

#Preview {
    struct DSPreview: View {
        @State private var isPresented = true

        var body: some View {
            Color.white
                .sheet(isPresented: $isPresented) {
                    DSBottomSheet(detents: [.medium]) {
                        Text("Bottom sheet content")
                            .padding()
                    }
                }
        }
    }

    return DSPreview()
}
