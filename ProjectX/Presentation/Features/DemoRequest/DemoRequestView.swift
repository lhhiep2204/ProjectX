//
//  DemoRequestView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 3/7/24.
//

import SwiftUI

struct DemoRequestView: View {
    // MARK: - Properties
    @EnvironmentObject private var routerManager: RouterManager<Route>
    @StateObject private var viewModel = DemoRequestViewModel()

    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
    }
}

// MARK: - State
extension DemoRequestView {
    private func handleState(_ state: DemoRequestViewModel.State) {
        switch state {
        case .initial:
            viewModel.intent.send(.fetchData)
        default:
            break
        }
    }
}

// MARK: - Views
extension DemoRequestView {
    private var containerView: some View {
        List {
            Section("Devices") {
                ForEach(viewModel.deviceInfos) { info in
                    DSText(info.name)
                }
            }
        }
    }
}

#Preview {
    DemoRequestView()
}
