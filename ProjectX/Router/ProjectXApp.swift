//
//  ProjectXApp.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import CoreModule
import SwiftUI
import UIComponents
import Utilities

@main
struct ProjectXApp: App {
    // MARK: - Properties
    private var routerManager: RouterManager<Route> = .init(root: .features)
    @StateObject private var languageManager = LanguageManager()
    @StateObject private var themeManager = ThemeManager()

#if os(iOS)
    init() {
        guard let largeTitleFont = UIFont(name: "RoundedMplus1c-Bold", size: 34),
              let titleFont = UIFont(name: "RoundedMplus1c-Bold", size: 17) else { return }

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: largeTitleFont]
        UINavigationBar.appearance().titleTextAttributes = [.font: titleFont]
    }
#endif

    var body: some Scene {
        WindowGroup {
            RouterView(routerManager)
                .tint(.appColor(.blue100))
                .preferredColorScheme(themeManager.currentTheme.colorScheme)
        }
        .environmentObject(languageManager)
        .environmentObject(themeManager)
    }
}
