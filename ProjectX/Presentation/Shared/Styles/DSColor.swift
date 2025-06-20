//
//  DSColor.swift
//  Locify
//
//  Created by Hoàng Hiệp Lê on 30/1/25.
//

import SwiftUI

/// A design system enum that defines color names used in the app.
/// These values should match the color names defined in the asset catalog.
enum DSColor: String {
    // MARK: - Background
    case bgPrimary = "background.primary"
    case bgSecondary = "background.secondary"
    
    // MARK: - Text
    case textPrimary = "text.primary"
    case textSecondary = "text.secondary"
    
    // MARK: - Shade
    case blue10 = "blue.10"
    case blue100 = "blue.100"
    
    case gray20 = "gray.20"
    case gray40 = "gray.40"
    case gray60 = "gray.60"
    case gray80 = "gray.80"
    case gray100 = "gray.100"
}

extension Color {
    /// Retrieves a color from the asset catalog using `DSColor`.
    ///
    /// - Parameter color: The `DSColor` enum case representing the desired color.
    /// - Returns: A `Color` instance corresponding to the specified `DSColor`.
    static func appColor(_ color: DSColor) -> Self {
        .init(color.rawValue)
    }
}
