//
//  DSTextField.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

final class DSTextFieldObservable: ObservableObject {
    @Published var axis: Axis = .horizontal
    @Published var disabled: Bool = false
    @Published var description: String = .empty
    @Published var label: String = .empty
    @Published var lineLimit: Int = 2
    @Published var image: Image? = nil
    @Published var style: DSTextFieldType = .plain
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
        VStack(alignment: .leading, spacing: 4) {
            labelView
            textfieldView
            descriptionView
        }
        .onTapGesture {
            editing = true
        }
    }
    
    @ViewBuilder
    private var labelView: some View {
        if !object.label.isEmpty {
            DSText(object.label)
                .type(.medium(.small))
        }
    }
    
    @ViewBuilder
    private var textfieldView: some View {
        HStack {
            object.image
                .padding(.leading, 16)
            if isSecure && !showPassword {
                SecureField(placeholder, text: $text)
                    .configureTextField(object, editing: $editing)
            } else {
                TextField(placeholder, text: $text, axis: object.axis)
                    .lineLimit(object.lineLimit, reservesSpace: true)
                    .configureTextField(object, editing: $editing)
            }
            
            if object.axis == .horizontal && editing && !text.isEmpty {
                clearButtonView
            }
            
            if isSecure {
                showPasswordButtonView
            }
        }
        .background(Color.appColor(.backgroundSecondary))
        .if(object.style == .bordered) {
            $0.overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 3)
                
            }
        }
        .if(object.disabled) {
            $0.overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 0)
                    .background(Color.appColor(colorScheme == .light ? .gray20 : .gray80).opacity(0.5))
                
            }
        }
        .cornerRadius(8)
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        if !object.description.isEmpty {
            DSText(object.description)
                .type(.medium(.small))
                .color(state.textColor)
        }
    }
    
    private var clearButtonView: some View {
        Button(action: {
            text = ""
        }, label: {
            Image.appSystemIcon(.clearText)
                .foregroundStyle(.textSecondary)
        })
        .if(!isSecure) {
            $0.padding(.trailing, 16)
        }
    }
    
    private var showPasswordButtonView: some View {
        Button(action: {
            showPassword.toggle()
        }, label: {
            Image.appSystemIcon(showPassword ? .passwordShown : .passwordHidden)
                .foregroundStyle(.textSecondary)
        })
        .padding(.trailing, 16)
    }
}

public extension DSTextField {
    func bordered() -> Self {
        object.style = .bordered
        return self
    }
    
    func image(_ image: Image) -> Self {
        object.image = image
        return self
    }
    
    func disabled(_ disabled: Bool) -> Self {
        object.disabled = disabled
        return self
    }
    
    func description(_ description: String) -> Self {
        object.description = description
        return self
    }
    
    func label(_ label: String) -> Self {
        object.label = label
        return self
    }
    
    func multiline(lineLimit: Int = 5) -> Self {
        object.axis = .vertical
        object.lineLimit = lineLimit
        return self
    }
}

#Preview {
    VStack(spacing: 16) {
        DSTextField(.constant("Username"),
                    text: .constant(""))
        .label("Username")
        DSTextField(.constant("Password"),
                    text: .constant(""),
                    isSecure: true)
        .label("Password")
        DSTextField(.constant("Text placeholder"),
                    text: .constant(""))
        .image(.appSystemIcon(.apple))
        .bordered()
        DSTextField(text: .constant("Disabled"))
            .image(.appSystemIcon(.apple))
            .bordered()
            .disabled(true)
        DSTextField(text: .constant("Success"),
                    state: .success)
        .bordered()
        .description("Description success text")
        DSTextField(text: .constant("Error"),
                    state: .error)
        .bordered()
        .description("Description error text")
        DSTextField(text: .constant("Multiline"),
                    state: .normal)
        .multiline()
        .bordered()
        .description("Description text")
    }
    .padding()
}
