//
//  ButtonStyle.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 17/03/2024.
//

import SwiftUI

public extension ButtonStyle where Self == FilledButtonStyle {
    static var filled: FilledButtonStyle {
        FilledButtonStyle()
    }
}

public extension ButtonStyle where Self == BorderedButtonStyle {
    static var bordered: BorderedButtonStyle {
        BorderedButtonStyle()
    }
}
