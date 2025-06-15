//
//  DSTextField.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

/// An observable class that manages the state and behavior of `DSTextField`.
@Observable
final class DSTextFieldObservable {
    /// The axis of the text field, determining whether it supports multiline input.
    var axis: Axis = .horizontal

    /// A Boolean value that indicates whether the text field is disabled.
    var disabled: Bool = false

    /// An optional image displayed inside the text field, typically used as an icon.
    var image: Image?

    /// The label text displayed above the text field.
    var label: String = ""

    /// The description text displayed below the text field.
    var description: String = ""

    /// The maximum length of input allowed in the text field. A value of `0` means no limit.
    var maxLength: Int = 0
}

/// A customizable text field component with styling and behavior options.
struct DSTextField: View {
    @Environment(\.colorScheme) var colorScheme

    private var object = DSTextFieldObservable()

    @Binding private var placeholder: String
    @Binding private var text: String
    @FocusState private var editing
    @State private var showPassword: Bool = false

    private let isSecure: Bool
    private let state: DSTextFieldState

    /// Initializes a `DSTextField` with a placeholder and text binding.
    /// - Parameters:
    ///   - placeholder: A binding to the placeholder text.
    ///   - text: A binding to the user-inputted text.
    ///   - isSecure: A Boolean indicating if the text field is for secure input (e.g., passwords).
    ///   - state: The state of the text field, affecting its appearance.
    init(
        _ placeholder: Binding<String>,
        text: Binding<String>,
        isSecure: Bool = false,
        state: DSTextFieldState = .normal
    ) {
        _placeholder = placeholder
        _text = text
        self.isSecure = isSecure
        self.state = state
    }

    /// Initializes a `DSTextField` without a placeholder.
    /// - Parameters:
    ///   - text: A binding to the user-inputted text.
    ///   - isSecure: A Boolean indicating if the text field is for secure input.
    ///   - state: The state of the text field.
    init(
        text: Binding<String>,
        isSecure: Bool = false,
        state: DSTextFieldState = .normal
    ) {
        _placeholder = .constant("")
        _text = text
        self.isSecure = isSecure
        self.state = state
    }

    /// Computes the border color based on the state of the text field.
    private var borderColor: Color {
        if object.disabled {
            return .appColor(.gray20)
        }

        return editing ? .teal : state.borderColor
    }

    /// Computes the border width based on the disabled state.
    private var borderWidth: CGFloat {
        object.disabled ? 0 : DSStroke.thick
    }

    /// Computes the background color when the text field is disabled.
    private var disabledBackground: Color {
        .appColor(colorScheme == .light ? .gray20 : .gray80).opacity(0.5)
    }

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: DSSpacing.spacing4
        ) {
            if !object.label.isEmpty {
                DSText(
                    object.label,
                    font: .medium(.small)
                )
            }

            inputView

            if !object.description.isEmpty {
                DSText(
                    object.description,
                    font: .medium(.small),
                    color: state.textColor
                )
            }
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
}

// MARK: - Private Methods
extension DSTextField {
    /// A view representing the main text field component.
    private var inputView: some View {
        HStack(spacing: DSSpacing.spacing8) {
            object.image

            textFieldView

            if object.axis == .horizontal && editing && !text.isEmpty {
                clearButtonView
            }

            if isSecure {
                showPasswordButtonView
            }
        }
        .padding(.horizontal, DSSpacing.spacing12)
        .background(Color.appColor(.bgSecondary))
        .cornerRadius(DSRadius.xxLarge)
        .overlay {
            RoundedRectangle(cornerRadius: DSRadius.xxLarge)
                .stroke(borderColor, lineWidth: borderWidth)
                .if(object.disabled) {
                    $0.background(disabledBackground)
                        .cornerRadius(DSRadius.xxLarge)
                }
        }
    }

    /// The actual text field input view, supporting secure and non-secure modes.
    private var textFieldView: some View {
        Group {
            if isSecure && !showPassword {
                SecureField(
                    placeholder,
                    text: $text
                )
            } else {
                TextField(
                    placeholder,
                    text: $text,
                    axis: object.axis
                )
            }
        }
        .textFieldStyle(
            DSTextFieldStyle()
        )
        .if(object.axis == .horizontal) {
            $0.frame(height: DSSize.textFieldHeight)
        } else: {
            $0.padding(.vertical, DSSpacing.spacing8)
        }
        .focused($editing)
        .disabled(object.disabled)
    }

    /// A button for clearing the text input.
    private var clearButtonView: some View {
        Button(action: {
            text = ""
        }, label: {
            Image
                .appSystemIcon(.clearText)
                .foregroundStyle(.textSecondary)
        })
    }

    /// A button for toggling the visibility of secure text input.
    private var showPasswordButtonView: some View {
        Button(action: {
            showPassword.toggle()
        }, label: {
            Image
                .appSystemIcon(showPassword ? .passwordShown : .passwordHidden)
                .foregroundStyle(.textSecondary)
        })
    }
}

// MARK: - methods
extension DSTextField {
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
        return self
    }
}

#Preview {
    VStack(spacing: DSSpacing.spacing16) {
        DSTextField(
            .constant("Username"),
            text: .constant("")
        )
        .label("Username")
#if os(iOS)
        .keyboardType(.emailAddress)
#endif

        DSTextField(
            .constant("Password"),
            text: .constant(""),
            isSecure: true
        )
        .label("Password")
#if os(iOS)
        .keyboardType(.numberPad)
#endif

        DSTextField(
            .constant("Text placeholder"),
            text: .constant("")
        )
        .image(.appIcon(.location))

        DSTextField(
            text: .constant("Disabled")
        )
        .image(.appIcon(.location))
        .disabled(true)

        DSTextField(
            text: .constant("Success"),
            state: .success
        )
        .description("Description success text")

        DSTextField(
            text: .constant("Error"),
            state: .error
        )
        .description("Description error text")

        DSTextField(
            text: .constant("Multiline"),
            state: .normal
        )
        .description("Description text")
        .multiline()
    }
    .padding()
}
