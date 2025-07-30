//
//  FeaturesView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import SwiftUI

struct FeaturesView: View {
    @EnvironmentObject private var routerManager: Router<Route>
    @StateObject private var viewModel = FeaturesViewModel()

    @EnvironmentObject var languageManager: LanguageManager
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        containerView
    }
}

// MARK: - Views
extension FeaturesView {
    private var containerView: some View {
        List {
            ForEach(Features.allCases, id: \.self) { feature in
                Section(feature.rawValue) {
                    switch feature {
                    case .components: componentView
                    case .httpRequest: httpRequestView
                    case .settings: settingView
                    }
                }
                .font(.appFont(.medium(.medium)))
            }
        }
    }

    private var componentView: some View {
        ForEach(Component.allCases, id: \.self) { component in
            NavigationLink(value: component.route) {
                HStack {
                    DSText(component.rawValue)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
        }
    }

    private var httpRequestView: some View {
        ForEach(HTTPRequest.allCases, id: \.self) { httpRequest in
            NavigationLink(value: httpRequest.route) {
                HStack {
                    DSText(httpRequest.rawValue)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
        }
    }

    private var settingView: some View {
        ForEach(Setting.allCases, id: \.self) { item in
            switch item {
            case .language: languageView(item)
            case .theme: themeView(item)
            }
        }
    }

    private func languageView(_ item: Setting) -> some View {
        Picker(selection: $languageManager.currentLanguage) {
            ForEach(Language.allCases, id: \.self) { item in
                var text: String {
                    switch item {
                    case .system: .localized(.setting.system)
                    case .english: .localized(.setting.english)
                    case .french: .localized(.setting.french)
                    case .vietnamese: .localized(.setting.vietnamese)
                    }
                }
                DSText(text)
            }
        } label: {
            DSText(.localized(.setting.language))
        }
#if os(macOS)
        .pickerStyle(.radioGroup)
#else
        .pickerStyle(.menu)
#endif
    }

    private func themeView(_ item: Setting) -> some View {
        Picker(selection: $themeManager.currentTheme) {
            ForEach(Theme.allCases, id: \.self) { item in
                var text: String {
                    switch item {
                    case .system: .localized(.setting.system)
                    case .light: .localized(.setting.light)
                    case .dark: .localized(.setting.dark)
                    }
                }
                DSText(text)
            }
        } label: {
            DSText(.localized(.setting.theme))
        }
#if os(macOS)
        .pickerStyle(.radioGroup)
#else
        .pickerStyle(.menu)
#endif
    }
}

#Preview {
    FeaturesView()
        .environmentObject(LanguageManager())
        .environmentObject(ThemeManager())
}
