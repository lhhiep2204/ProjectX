//
//  DSConstants.swift
//  Locify
//
//  Created by Hoàng Hiệp Lê on 30/1/25.
//

import Foundation

/// A structure containing various constant values used throughout the application.
enum DSConstants {
    /// A set of constant spacing values used for layout design.
    /// These represent common spacing values used for paddings, margins, and distances between UI elements.
    enum Spacing {
        /// Spacing of 2 points.
        static let spacing2: CGFloat = 2
        /// Spacing of 4 points.
        static let spacing4: CGFloat = 4
        /// Spacing of 8 points.
        static let spacing8: CGFloat = 8
        /// Spacing of 10 points.
        static let spacing10: CGFloat = 10
        /// Spacing of 12 points.
        static let spacing12: CGFloat = 12
        /// Spacing of 16 points.
        static let spacing16: CGFloat = 16
        /// Spacing of 20 points.
        static let spacing20: CGFloat = 20
        /// Spacing of 24 points.
        static let spacing24: CGFloat = 24
        /// Spacing of 32 points.
        static let spacing32: CGFloat = 32
        /// Spacing of 36 points.
        static let spacing36: CGFloat = 36
        /// Spacing of 40 points.
        static let spacing40: CGFloat = 40
        /// Spacing of 44 points.
        static let spacing44: CGFloat = 44
        /// Spacing of 48 points.
        static let spacing48: CGFloat = 48
        /// Spacing of 52 points.
        static let spacing52: CGFloat = 52
        /// Spacing of 56 points.
        static let spacing56: CGFloat = 56
        /// Spacing of 60 points.
        static let spacing60: CGFloat = 60
    }

    /// A set of constant radius values used for corner radius and other rounded elements.
    /// These values control the roundness of corners on UI components like buttons, cards, and more.
    enum Radius {
        /// Small corner radius (2 points).
        static let small: CGFloat = 2
        /// Medium corner radius (4 points).
        static let medium: CGFloat = 4
        /// Large corner radius (8 points).
        static let large: CGFloat = 8
        /// Extra large corner radius (12 points).
        static let xLarge: CGFloat = 12
        /// Double extra large corner radius (16 points).
        static let xxLarge: CGFloat = 16
    }

    /// A set of constant stroke thickness values used for borders or outlines.
    /// These values define the thickness of the lines or borders applied to various UI components.
    enum Stroke {
        /// Thin stroke thickness (1 point).
        static let thin: CGFloat = 1
        /// Medium stroke thickness (2 points).
        static let thick: CGFloat = 2
        /// Thicker stroke thickness (4 points).
        static let thicker: CGFloat = 4
        /// Thickest stroke thickness (6 points).
        static let thickest: CGFloat = 6
    }

    /// A set of predefined sizes for UI components.
    /// These sizes are used for setting consistent dimensions across elements like buttons, icons, and avatars.
    enum Size {
        /// A fixed size of 2 points.
        static let size2: CGFloat = 2
        /// A fixed size of 4 points.
        static let size4: CGFloat = 4
        /// A fixed size of 8 points.
        static let size8: CGFloat = 8
        /// A fixed size of 10 points.
        static let size10: CGFloat = 10
        /// A fixed size of 12 points.
        static let size12: CGFloat = 12
        /// A fixed size of 16 points.
        static let size16: CGFloat = 16
        /// A fixed size of 20 points.
        static let size20: CGFloat = 20
        /// A fixed size of 24 points.
        static let size24: CGFloat = 24
        /// A fixed size of 32 points.
        static let size32: CGFloat = 32
        /// A fixed size of 36 points.
        static let size36: CGFloat = 36
        /// A fixed size of 40 points.
        static let size40: CGFloat = 40
        /// A fixed size of 44 points.
        static let size44: CGFloat = 44
        /// A fixed size of 48 points.
        static let size48: CGFloat = 48
        /// A fixed size of 52 points.
        static let size52: CGFloat = 52
        /// A fixed size of 56 points.
        static let size56: CGFloat = 56
        /// A fixed size of 60 points.
        static let size60: CGFloat = 60

        /// The standard height for text field: 34 points.
        static let textFieldHeight: CGFloat = 34
    }
}
