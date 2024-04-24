//
//  Route.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

enum Route {
    case home, button, dialog, text, textfield
}

extension Route: View, Hashable {
    // MARK: - Views
    var body: some View {
        switch self {
        case .home:
            ComponentView()
                .navigationTitle("Components")
        case .button:
            ButtonView()
                .navigationTitle("Button")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .dialog:
            DialogView()
                .navigationTitle("DialogView")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .text:
            TextView()
                .navigationTitle("Text")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .textfield:
            TextFieldView()
                .navigationTitle("TextField")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        }
    }
}
