//
//  Route.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import CoreModule
import SwiftUI

enum Route {
    case features
    case button, dialog, text, textField
    case demoRequest
}

extension Route: AppRoute {
    // MARK: - Views
    var body: some View {
        switch self {
        case .features:
            FeaturesView()
                .navigationTitle("Features")
        case .button:
            ButtonView()
                .navigationTitle("Button")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .dialog:
            DialogView()
                .navigationTitle("Dialog")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .text:
            TextView()
                .navigationTitle("Text")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .textField:
            TextFieldView()
                .navigationTitle("TextField")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        case .demoRequest:
            DemoRequestView()
                .navigationTitle("Demo Request")
#if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
#endif
        }
    }
}
