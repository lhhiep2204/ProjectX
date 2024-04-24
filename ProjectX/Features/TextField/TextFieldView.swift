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
            VStack(spacing: 16) {
                Spacer()
                DSTextField(.constant("Username"),
                            text: $text)
                .label("Username")
                .focused($focusField, equals: .username)
                DSTextField(.constant("Password"),
                            text: $text,
                            isSecure: true)
                .label("Password")
                .focused($focusField, equals: .password)
                DSTextField(.constant("Text placeholder"),
                            text: $text)
                .image(.appSystemIcon(.apple))
                .bordered()
                .focused($editing)
                DSTextField(text: $text)
                    .image(.appSystemIcon(.apple))
                    .bordered()
                    .disabled(true)
                    .focused($editing)
                DSTextField(text: $text,
                            state: .success)
                .bordered()
                .description("Description success text")
                .focused($editing)
                DSTextField(text: $text,
                            state: .error)
                .bordered()
                .description("Description error text")
                .focused($editing)
                DSTextField(text: $text,
                            state: .normal)
                .multiline()
                .bordered()
                .description("Description text")
                .focused($editing)
                Spacer()
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
