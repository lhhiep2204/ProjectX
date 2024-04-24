//
//  ProjectXApp.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Router
import SwiftUI
import SwiftData

@main
struct ProjectXApp: App {
    // MARK: - Properties
    private var routerManager: RouterManager<Route> = .init(root: .home)

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RouterView(routerManager)
                .tint(.appColor(.blue100))
        }
        .modelContainer(sharedModelContainer)
    }
}
