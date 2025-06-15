//
//  RouterView.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

/// A SwiftUI view that works in conjunction with a `RouterManager` to manage navigation paths.
struct RouterView<Route: AppRoute>: View {
    // MARK: - ObservedObject Property
    /// The observed object responsible for managing navigation paths.
    @ObservedObject private var manager: RouterManager<Route>

    // MARK: - Initializer
    /// Initializes the `RouterView` with a `RouterManager`.
    ///
    /// - Parameter manager: The `RouterManager` managing the navigation paths.
    init(_ manager: RouterManager<Route>) {
        self.manager = manager
    }

    // MARK: - Body
    var body: some View {
        NavigationStack(path: $manager.paths) {
            // Display the root view and provide navigation destination support
            manager.root
                .navigationDestination(for: Route.self) { $0 }
        }
        // Inject the `RouterManager` as an environment object
        .environmentObject(manager)
    }
}

/// A view modifier that provides navigation support using a `RouterManager`.
struct RouterModifier<Route: AppRoute>: ViewModifier {
    // MARK: - ObservedObject Property
    /// The observed object responsible for managing navigation paths.
    @ObservedObject private var manager: RouterManager<Route>

    // MARK: - Initializer
    /// Initializes the `RouterModifier` with a `RouterManager`.
    ///
    /// - Parameter manager: The `RouterManager` managing the navigation paths.
    init(_ manager: RouterManager<Route>) {
        self.manager = manager
    }

    // MARK: - Body
    func body(content: Content) -> some View {
        NavigationStack(path: $manager.paths) {
            content
                .navigationDestination(for: Route.self) { $0 }
        }
        // Inject the `RouterManager` as an environment object
        .environmentObject(manager)
    }
}

extension View {
    // MARK: - Router Modifier Application
    /// Applies the `RouterModifier` to the view, providing navigation support using a `RouterManager`.
    ///
    /// - Parameter manager: The `RouterManager` managing the navigation paths.
    /// - Returns: A view modified with navigation support.
    func applyRouter<Route: AppRoute>(_ manager: RouterManager<Route>) -> some View {
        modifier(RouterModifier(manager))
    }
}
