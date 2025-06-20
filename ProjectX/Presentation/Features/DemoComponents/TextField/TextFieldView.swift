//
//  TextFieldView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

struct TextFieldView: View {
    enum FocusField {
        case username, password
    }
    @FocusState private var focusField: FocusField?
    @FocusState private var editing

    @State private var text: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: DSSpacing.spacing16) {
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
                    .focused($editing)
                DSTextField(text: $text)
                    .image(.appSystemIcon(.apple))
                    .disabled(true)
                    .focused($editing)
                DSTextField(text: $text, state: .success)
                    .description("Description success text")
                    .focused($editing)
                DSTextField(text: $text, state: .error)
                    .description("Description error text")
                    .focused($editing)
                DSTextField(text: $text, state: .normal)
                    .description("Description text")
                    .multiline()
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
