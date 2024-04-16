//
//  ComponentView.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Router
import SwiftUI
import UIComponents

struct ComponentView: View {
    @EnvironmentObject private var routerManager: RouterManager<Route>
    @StateObject private var viewModel = ComponentViewModel()

    private func handleState(_ state: ComponentViewModel.State) {
        switch state {
        case .initial:
            viewModel.intent.send(.fetchData)
        default:
            break
        }
    }

    var body: some View {
        containerView
            .onReceive(viewModel.state) { state in
                handleState(state)
            }
    }

    private var containerView: some View {
        List(viewModel.components, id: \.self) { component in
            HStack {
                Text(component.rawValue)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                switch component {
                case .button: routerManager.push(.button)
                case .text: routerManager.push(.text)
                }
            }
        }
    }
}

#Preview {
    ComponentView()
}
