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

enum FeaturesItem: Identifiable, Hashable {
    case components(Component)
    case httpRequest(HTTPRequest)
    case settings(Setting)

    var id: String {
        switch self {
        case .components(let c): "components_\(c.rawValue)"
        case .httpRequest(let r): "httpRequest_\(r.rawValue)"
        case .settings(let s): "settings_\(s.rawValue)"
        }
    }
}

enum Component: String, CaseIterable {
    case button = "Button"
    case dialog = "Dialog"
    case text = "Text"
    case textField = "TextField"
    
    var route: Route {
        switch self {
        case .button: .button
        case .dialog: .dialog
        case .text: .text
        case .textField: .textField
        }
    }
}

enum HTTPRequest: String, CaseIterable {
    case requests = "Requests"
    
    var route: Route {
        switch self {
        case .requests: .demoRequest
        }
    }
}

enum Setting: String, CaseIterable {
    case language = "Language"
    case theme = "Theme"
}

struct FeaturesModel {}

class FeaturesViewModel: BaseViewModel {
    @Published private(set) var state = FeaturesModel()

    private let service: ISampleService
    
    init(service: ISampleService = SampleService()) {
        self.service = service
        
        super.init()
    }
}
