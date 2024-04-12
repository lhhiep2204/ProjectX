//
//  DSButtonType.swift
//  UIComponents
//
//  Created by Hoàng Hiệp Lê on 12/4/24.
//

import SwiftUI

public indirect enum DSButtonType: Equatable {
    case filled(DSButtonSize), bordered(DSButtonSize), icon(DSButtonType)

    private var size: DSButtonSize {
        switch self {
        case .bordered(let size), .filled(let size): size
        case .icon(let type): type.size
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
}
