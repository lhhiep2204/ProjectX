//
//  FeaturesView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import CoreModule
import SwiftUI
import UIComponents
import Utilities

struct FeaturesView: View {
    @EnvironmentObject private var routerManager: RouterManager<Route>
    @StateObject private var viewModel = FeaturesViewModel()

    @EnvironmentObject var languageManager: LanguageManager
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
    }
}

extension FeaturesView {
    private func handleState(_ state: FeaturesViewModel.State) {
        switch state {
        case .initial:
            viewModel.intent.send(.fetchData)
        default:
            break
        }
    }

    private var containerView: some View {
        NavigationSplitView {
            List {
                ForEach(Features.allCases, id: \.self) { feature in
                    Section(feature.rawValue) {
                        switch feature {
                        case .components: componentView
                        case .settings: settingView
                        }
                    }
                    .font(.appFont(.medium(.medium)))
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(220)
#endif
        } detail: {
            EmptyView()
        }
    }

    private var componentView: some View {
        ForEach(Component.allCases, id: \.self) { component in
            HStack {
                DSText(component.rawValue)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                switch component {
                case .bottomSheet: routerManager.push(.bottomSheet)
                case .button: routerManager.push(.button)
                case .dialog: routerManager.push(.dialog)
                case .text: routerManager.push(.text)
                case .textField: routerManager.push(.textField)
                }
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
}
