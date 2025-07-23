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
                // 1. Standard with placeholder and label
                DSTextField(
                    .constant("Username"),
                    text: .constant("")
                )
                .label("Username")
#if os(iOS)
                .keyboardType(.emailAddress)
#endif
                .focused($editing)

                // 2. Secure field (password)
                DSTextField(
                    .constant("Password"),
                    text: .constant(""),
                    isSecure: true
                )
                .label("Password")
#if os(iOS)
                .keyboardType(.numberPad)
#endif
                .focused($editing)

                // 3. With icon
                DSTextField(
                    .constant("Text placeholder"),
                    text: .constant("")
                )
                .image(.appSystemIcon(.apple))
                .focused($editing)

                // 4. Disabled
                DSTextField(
                    text: .constant("Disabled")
                )
                .image(.appSystemIcon(.apple))
                .disabled(true)
                .focused($editing)

                // 5. Success state
                DSTextField(
                    text: .constant("Success"),
                    state: .success
                )
                .description("Description success text")
                .focused($editing)

                // 6. Error state
                DSTextField(
                    text: .constant("Error"),
                    state: .error
                )
                .description("Description error text")
                .focused($editing)

                // 7. Multiline
                DSTextField(
                    text: .constant("Multiline\nLine 2\nLine 3"),
                    state: .normal
                )
                .description("Description text")
                .multiline()
                .focused($editing)

                // 8. Max Length (set to 3)
                DSTextField(
                    .constant("Limited"),
                    text: .constant("12345")
                )
                .label("Max Length 3")
                .maxLength(3)
                .focused($editing)

                // 9. Non-translucent field
                DSTextField(
                    .constant("Opaque"),
                    text: .constant("Text"),
                    translucent: false
                )
                .label("Opaque Background")
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
