//
//  DSTextFieldType.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 16/4/24.
//

import SwiftUI

public enum DSTextFieldState {
    case normal, success, error

    public var borderColor: Color {
        switch self {
        case .normal: .appColor(.gray40)
        case .success: .green
        case .error: .red
        }
    }

    public var textColor: Color {
        switch self {
        case .normal: .appColor(.gray60)
        case .success: .green
        case .error: .red
        }
    }
}

enum DSTextFieldType {
    case plain, bordered
}

struct DSTextFieldStyle: ViewModifier {
    var object: DSTextFieldObservable
    var editing: FocusState<Bool>.Binding

    func body(content: Content) -> some View {
        content
            .font(.appFont(.regular(14)))
            .if(object.axis == .horizontal) {
                $0.frame(height: 44)
            }
            .if(object.axis == .vertical) {
                $0.padding(.vertical, 12)
            }
            .padding(.trailing, 16)
            .focused(editing)
            .disabled(object.disabled)
            .if(object.image == nil) {
                $0.padding(.leading, 16)
            }
    }
}

extension View {
    func configureTextField(_ object: DSTextFieldObservable, editing: FocusState<Bool>.Binding) -> some View {
        modifier(DSTextFieldStyle(object: object, editing: editing))
    }
}

extension SecureField {
    func configureTextField(_ object: DSTextFieldObservable, editing: FocusState<Bool>.Binding) -> some View {
        modifier(DSTextFieldStyle(object: object, editing: editing))
    }
}
