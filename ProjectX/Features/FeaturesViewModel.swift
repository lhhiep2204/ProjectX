//
//  FeaturesViewModel.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine
import Utilities

enum Features: String, CaseIterable {
    case components = "Components"
    case httpRequest = "HTTP Request"
    case settings = "Settings"
}

enum Component: String, CaseIterable {
#if os(iOS)
    case bottomSheet = "Bottom sheet"
#endif
    case button = "Button"
    case dialog = "Dialog"
    case text = "Text"
    case textField = "TextField"
}

enum HTTPRequest: String, CaseIterable {
    case requests = "Requests"
}

enum Setting: String, CaseIterable {
    case language = "Language"
    case theme = "Theme"
}

class FeaturesViewModel: BaseViewModel {
    enum State {
        case initial
        case error(_ message: String)
    }

    let state = CurrentValueSubject<State, Never>(.initial)

    private let service: ISampleService

    init(service: ISampleService = SampleService()) {
        self.service = service

        super.init()
    }
}
