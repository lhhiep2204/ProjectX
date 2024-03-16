//
//  Route.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

enum Route {
    case home
}

extension Route: View, Hashable {
    // MARK: - Views
    var body: some View {
        switch self {
        case .home:
            ContentView()
        }
    }
}
