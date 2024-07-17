//
//  DSTextField.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

final class DSTextFieldObservable: ObservableObject {
    @Published var axis: Axis = .horizontal
    @Published var type: DSTextFieldType = .plain
    @Published var disabled: Bool = false
    @Published var image: Image? = nil
    @Published var label: String = ""
    @Published var description: String = ""
    @Published var maxLength: Int = 0
    @Published var lineLimit: Int = 2
#if os(iOS)
    @Published var keyboardType: UIKeyboardType = .default
#endif
    @Published var submitLabel: SubmitLabel = .return
}

public struct DSTextField: View {
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject private var object = DSTextFieldObservable()

    @Binding private var placeholder: String
    @Binding private var text: String
    @FocusState private var editing
    @State private var showPassword: Bool = false

    private let isSecure: Bool
    private let state: DSTextFieldState

    public init(_ placeholder: Binding<String>,
                text: Binding<String>,
                isSecure: Bool = false,
                state: DSTextFieldState = .normal) {
        _placeholder = placeholder
        _text = text
        self.isSecure = isSecure
        self.state = state
    }

    public init(text: Binding<String>,
                isSecure: Bool = false,
                state: DSTextFieldState = .normal) {
        _placeholder = .constant("")
        _text = text
        self.isSecure = isSecure
        self.state = state
    }

    private var borderColor: Color {
        if object.disabled {
            return .appColor(.gray20)
        }

        if editing {
            return .appColor(.blue100)
        }

        return state.borderColor
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: DSConstants.Spacing.spacing4) {
            labelView
            textfieldView
            descriptionView
        }
        .if(object.maxLength > 0) {
            $0.onReceive(text.publisher.collect()) {
                text = String($0.prefix(object.maxLength))
            }
        }
        .onTapGesture {
            editing = true
        }
    }

    @ViewBuilder
    private var labelView: some View {
        if !object.label.isEmpty {
            DSText(object.label)
                .font(.medium(.small))
        }
    }

    @ViewBuilder
    private var textfieldView: some View {
        HStack {
            object.image
                .padding(.leading, DSConstants.Spacing.spacing16)
            if isSecure && !showPassword {
                SecureField(placeholder, text: $text)
                    .configureTextField(object, editing: $editing)
#if os(iOS)
                    .keyboardType(object.keyboardType)
#endif
            } else {
                TextField(placeholder, text: $text, axis: object.axis)
                    .lineLimit(object.lineLimit)
                    .configureTextField(object, editing: $editing)
#if os(iOS)
                    .keyboardType(object.keyboardType)
#endif
            }

            if object.axis == .horizontal && editing && !text.isEmpty {
                clearButtonView
            }

            if isSecure {
                showPasswordButtonView
            }
        }
        .background(Color.appColor(.bgSecondary))
        .if(object.type == .bordered) {
            $0.overlay {
                RoundedRectangle(cornerRadius: DSConstants.Radius.large)
                    .stroke(borderColor,
                            lineWidth: DSConstants.Stroke.thick)

            }
        }
        .if(object.disabled) {
            $0.overlay {
                RoundedRectangle(cornerRadius: DSConstants.Radius.large)
                    .stroke(borderColor, lineWidth: 0)
                    .background(Color.appColor(colorScheme == .light ? .gray20 : .gray80).opacity(0.5))

            }
        }
        .cornerRadius(DSConstants.Radius.large)
    }

    @ViewBuilder
    private var descriptionView: some View {
        if !object.description.isEmpty {
            DSText(object.description)
                .font(.medium(.small))
                .color(state.textColor)
        }
    }

    private var clearButtonView: some View {
        Button(action: {
            text = ""
        }) {
            Image.appSystemIcon(.clearText)
                .foregroundStyle(.textSecondary)
        }
        .if(!isSecure) {
            $0.padding(.trailing, DSConstants.Spacing.spacing16)
        }
    }

    private var showPasswordButtonView: some View {
        Button(action: {
            showPassword.toggle()
        }) {
            Image.appSystemIcon(showPassword ? .passwordShown : .passwordHidden)
                .foregroundStyle(.textSecondary)
        }
        .padding(.trailing, DSConstants.Spacing.spacing16)
    }
}

// MARK: - Public methods
public extension DSTextField {
    /// Sets the type of the text field (plain or bordered).
    /// - Parameter type: The desired type of the text field.
    /// - Returns: The updated DSTextField.
    func type(_ type: DSTextFieldType) -> Self {
        object.type = type
        return self
    }

    /// Sets the disabled state of the text field.
    /// - Parameter disabled: A Boolean value indicating whether the text field is disabled.
    /// - Returns: The updated DSTextField.
    func disabled(_ disabled: Bool) -> Self {
        object.disabled = disabled
        return self
    }

    /// Sets the image to be displayed in the text field.
    /// - Parameter image: The image to be displayed.
    /// - Returns: The updated DSTextField.
    func image(_ image: Image) -> Self {
        object.image = image
        return self
    }

    /// Sets the label text to be displayed above the text field.
    /// - Parameter label: The label text.
    /// - Returns: The updated DSTextField.
    func label(_ label: String) -> Self {
        object.label = label
        return self
    }

    /// Sets the description text to be displayed below the text field.
    /// - Parameter description: The description text.
    /// - Returns: The updated DSTextField.
    func description(_ description: String) -> Self {
        object.description = description
        return self
    }

    /// Sets the maximum length of text that can be entered in the text field.
    /// - Parameter maxLength: The maximum number of characters.
    /// - Returns: The updated DSTextField.
    func maxLength(_ maxLength: Int) -> Self {
        object.maxLength = maxLength
        return self
    }

    /// Configures the text field to support multiline input.
    /// - Parameters:
    ///   - multiline: A Boolean value indicating whether multiline input is enabled.
    ///   - lineLimit: The maximum number of lines for the text field.
    /// - Returns: The updated DSTextField.
    func multiline(_ multiline: Bool = true, lineLimit: Int = 5) -> Self {
        object.axis = multiline ? .vertical : .horizontal
        object.lineLimit = lineLimit
        return self
    }

#if os(iOS)
    /// Sets the keyboard type for the text field.
    /// - Parameter type: The desired keyboard type.
    /// - Returns: The updated DSTextField.
    func keyboardType(_ type: UIKeyboardType) -> Self {
        object.keyboardType = type
        return self
    }
#endif

    /// Sets the submit label for the keyboard.
    /// - Parameter label: The desired submit label.
    /// - Returns: The updated DSTextField.
    func submitLabel(_ label: SubmitLabel) -> Self {
        object.submitLabel = label
        return self
    }
}

#Preview {
    VStack(spacing: DSConstants.Spacing.spacing16) {
        DSTextField(.constant("Username"), text: .constant(""))
            .label("Username")
#if os(iOS)
            .keyboardType(.emailAddress)
#endif
        DSTextField(.constant("Password"), text: .constant(""), isSecure: true)
            .label("Password")
#if os(iOS)
            .keyboardType(.numberPad)
#endif
        DSTextField(.constant("Text placeholder"), text: .constant(""))
            .image(.appSystemIcon(.apple))
            .type(.bordered)
        DSTextField(text: .constant("Disabled"))
            .image(.appSystemIcon(.apple))
            .type(.bordered)
            .disabled(true)
        DSTextField(text: .constant("Success"), state: .success)
            .description("Description success text")
            .type(.bordered)
        DSTextField(text: .constant("Error"), state: .error)
            .description("Description error text")
            .type(.bordered)
        DSTextField(text: .constant("Multiline"), state: .normal)
            .description("Description text")
            .multiline()
            .type(.bordered)
    }
    .padding()
}
