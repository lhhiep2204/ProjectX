//
//  DSDialogType.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 23/4/24.
//

import SwiftUI

struct DSDialogButton {
    let title: String
    let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

enum DSDialogButtonType {
    case alert(DSDialogButton),
         confirmation(DSDialogButton, DSDialogButton),
         option(DSDialogButton, DSDialogButton)
}

struct DSDialogModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    let title: String?
    let subtitle: String?
    let image: Image?
    let buttonType: DSDialogButtonType
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                    .ignoresSafeArea()
                DSDialog($isPresented,
                         title: title,
                         subtitle: subtitle,
                         image: image,
                         buttonType: buttonType)
            }
            .opacity(isPresented ? 1 : 0)
        }
    }
}

extension View {
    func dialog(_ isPresented: Binding<Bool>,
                title: String? = nil,
                subtitle: String? = nil,
                image: Image? = nil,
                button: DSDialogButton) -> some View {
        modifier(DSDialogModifier(isPresented: isPresented,
                                  title: title,
                                  subtitle: subtitle,
                                  image: image,
                                  buttonType: .alert(button)))
    }
    
    func confirmationDialog(_ isPresented: Binding<Bool>,
                            title: String? = nil,
                            subtitle: String? = nil,
                            image: Image? = nil,
                            leftButton: DSDialogButton,
                            rightButton: DSDialogButton) -> some View {
        modifier(DSDialogModifier(isPresented: isPresented,
                                  title: title,
                                  subtitle: subtitle,
                                  image: image,
                                  buttonType: .confirmation(leftButton, rightButton)))
    }
    
    func optionDialog(_ isPresented: Binding<Bool>,
                      title: String? = nil,
                      subtitle: String? = nil,
                      image: Image? = nil,
                      leftButton: DSDialogButton,
                      rightButton: DSDialogButton) -> some View {
        modifier(DSDialogModifier(isPresented: isPresented,
                                  title: title,
                                  subtitle: subtitle,
                                  image: image,
                                  buttonType: .option(leftButton, rightButton)))
    }
}
