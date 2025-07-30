//
//  Router.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

/// A protocol that represents a route in the navigation stack.
///
/// Any conforming type must be both a `View` and `Hashable` to support
/// SwiftUI navigation and identity tracking.
typealias RouterHandler = View & Hashable
protocol AppRoute: RouterHandler {}

/// A navigation router for SwiftUI views, handling a stack-based navigation model.
///
/// `Router` maintains the current path stack and root view, and provides methods
/// for navigation actions such as push, pop, and resetting the stack.
final class Router<Route: AppRoute>: ObservableObject {
    /// The root view of the navigation hierarchy.
    @Published var root: Route
    /// The stack of navigation paths.
    @Published var paths: NavigationPath

    /// Initializes the `Router` with a root view.
    ///
    /// - Parameter rootView: The root view of the navigation hierarchy.
    init(
        paths: NavigationPath = .init(),
        root: Route
    ) {
        self.paths = paths
        self.root = root
    }
}

extension Router {
    /// Pushes a new view onto the navigation stack.
    ///
    /// - Parameter path: The view to be pushed onto the stack.
    func push(_ path: Route) {
        paths.append(path)
    }

    /// Pops the top view from the navigation stack.
    func pop() {
        paths.removeLast()
    }

    /// Pops all views from the navigation stack, leaving only the root view.
    func popToRoot() {
        paths.removeLast(paths.count)
    }

    /// Updates the root view of the navigation hierarchy.
    ///
    /// - Parameter rootView: The new root view.
    func updateRoot(_ rootView: Route) {
        root = rootView
        paths.removeLast(paths.count)
    }
}
