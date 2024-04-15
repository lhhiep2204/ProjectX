//
//  DSButtonType.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 12/4/24.
//

import SwiftUI

public indirect enum DSButtonType: Equatable {
    case filled(DSButtonSize), bordered(DSButtonSize), icon(DSButtonIconType)

    var sizeMode: DSButtonSizeMode {
        switch self {
        case .bordered(let size), .filled(let size):
            switch size {
            case .small(let sizeMode), .medium(let sizeMode): sizeMode
            }
        case .icon(_): .fit
        }
    }

    var fontSize: Font {
        size.fontSize
    }

    var padding: CGFloat {
        size.padding
    }

    var height: CGFloat {
        size.height
    }

    private var size: DSButtonSize {
        switch self {
        case .bordered(let size), .filled(let size): size
        case .icon(let buttonType): buttonType.type.size
        }
    }
}

public enum DSButtonIconType: Equatable {
    case normal(DSButtonType), circle(DSButtonType)

    var type: DSButtonType {
        switch self {
        case .normal(let type), .circle(let type): type
        }
    }
}

public enum DSButtonSize: Equatable {
    case small(DSButtonSizeMode), medium(DSButtonSizeMode)

    var fontSize: Font {
        switch self {
        case .small: .appFont(.bold(12))
        case .medium: .appFont(.bold(16))
        }
    }

    var padding: CGFloat {
        switch self {
        case .small: 10
        case .medium: 16
        }
    }

    var height: CGFloat {
        switch self {
        case .small: 36
        case .medium: 48
        }
    }
}

public enum DSButtonSizeMode {
    case fit, fill
}
