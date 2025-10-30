//
//  ViewModelFactory.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 30/7/25.
//

import Foundation

/// The root dependency container (Composition Root).
///
/// `AppContainer` wires together the feature-level containers and shared services.
/// It follows Clean Architecture principles and acts as the single source of truth
/// for constructing ViewModels and use cases throughout the app.
final class AppContainer {
    /// Shared singleton instance.
    static let shared = AppContainer()

    /// Private initializer to enforce singleton usage.
    private init() {}
}
