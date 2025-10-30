//
//  EnvironmentValues.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 30/7/25.
//

import SwiftUI

/// An `EnvironmentKey` for injecting the `AppContainer` singleton into the SwiftUI environment.
struct AppContainerKey: EnvironmentKey {
    static let defaultValue: AppContainer = .shared
}

extension EnvironmentValues {
    /// A property to access or set the `AppContainer` instance in the SwiftUI environment.
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
