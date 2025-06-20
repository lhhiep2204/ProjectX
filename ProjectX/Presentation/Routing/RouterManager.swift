//
//  RouterManager.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine
import SwiftUI

typealias RouterHandler = View & Hashable

protocol AppRoute: RouterHandler { }

/// A class responsible for managing navigation paths in a SwiftUI application.
final class RouterManager<Route: AppRoute>: ObservableObject {
    // MARK: - Published Properties
    /// The root view of the navigation hierarchy.
    @Published var root: Route
    /// The stack of navigation paths.
    @Published var paths: NavigationPath

    // MARK: - Initializer
    /// Initializes the `RouterManager` with a root view.
    ///
    /// - Parameter rootView: The root view of the navigation hierarchy.
    init(paths: NavigationPath = .init(),
                root: Route) {
        self.paths = paths
        self.root = root
    }
}

extension RouterManager {
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
