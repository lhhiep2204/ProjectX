//
//  TextFieldView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI
import UIComponents

struct TextFieldView: View {
    enum FocusField {
        case username, password
    }
    @FocusState private var focusField: FocusField?
    @FocusState private var editing

    @State private var text: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: DSConstants.Spacing.spacing16) {
                DSTextField(.constant("Username"), text: $text)
                    .label("Username")
#if os(iOS)
                    .keyboardType(.emailAddress)
#endif
                    .submitLabel(.next)
                    .focused($focusField, equals: .username)
                    .onSubmit {
                        focusField = .password
                    }
                DSTextField(.constant("Password"), text: $text, isSecure: true)
                    .label("Password")
#if os(iOS)
                    .keyboardType(.numberPad)
#endif
                    .focused($focusField, equals: .password)
                DSTextField(.constant("Text placeholder"), text: $text)
                    .image(.appSystemIcon(.apple))
                    .type(.bordered)
                    .focused($editing)
                DSTextField(text: $text)
                    .image(.appSystemIcon(.apple))
                    .type(.bordered)
                    .disabled(true)
                    .focused($editing)
                DSTextField(text: $text, state: .success)
                    .description("Description success text")
                    .type(.bordered)
                    .focused($editing)
                DSTextField(text: $text, state: .error)
                    .description("Description error text")
                    .type(.bordered)
                    .focused($editing)
                DSTextField(text: $text, state: .normal)
                    .description("Description text")
                    .multiline()
                    .type(.bordered)
                    .focused($editing)
            }
            .padding()
        }
        .onTapGesture {
            focusField = nil
            editing = false
        }
    }
}

#Preview {
    TextFieldView()
}
