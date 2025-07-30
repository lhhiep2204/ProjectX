//
//  ViewModelFactory.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 30/7/25.
//

import Foundation

/// A singleton responsible for creating and providing `ViewModel` instances with all their dependencies.
///
/// This factory follows Clean Architecture principles:
/// - Each `ViewModel` receives only the required `UseCases` or `UseCase` containers
/// - Each `UseCase` is injected with its corresponding `Repository`
/// - `Repositories` currently use mock data but are designed to handle local and remote data sources
/// - Use case containers group related operations by domain
final class ViewModelFactory {
    /// Shared singleton instance.
    static let shared = ViewModelFactory()

    /// Private initializer to enforce the singleton pattern.
    private init() {}
}
