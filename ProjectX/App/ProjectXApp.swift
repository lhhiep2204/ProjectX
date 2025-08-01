//
//  ProjectXApp.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftData
import SwiftUI

@main
struct ProjectXApp: App {
    // MARK: - Properties
    private var routerManager: Router<Route> = .init(root: .features)
    @StateObject private var languageManager = LanguageManager()
    @StateObject private var themeManager = ThemeManager()

    private var container: ModelContainer = {
        let schema = Schema([/* Add models here */])

        let modelConfiguration = ModelConfiguration(schema: schema)

        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            LocalDataManager.configure(with: modelContainer)

            return modelContainer
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

//#if os(iOS)
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.appFont(.bold(.custom(34)))]
//        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.appFont(.bold(.custom(17)))]
//    }
//#endif

    var body: some Scene {
        WindowGroup {
            RouterView(routerManager)
                .tint(.appColor(.accent))
                .preferredColorScheme(themeManager.currentTheme.colorScheme)
        }
        .modelContainer(container)
        .environmentObject(languageManager)
        .environmentObject(themeManager)
    }
}
