//
//  DemoRequestViewModel.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 3/7/24.
//

import Combine
import Foundation
import Utilities

class DemoRequestViewModel: BaseViewModel {
    // MARK: - Enums
    enum State {
        case initial
        case fetchDataSuccess
        case error(_ message: String)
    }

    enum Intent {
        case fetchData
    }

    // MARK: - Properties
    let state = CurrentValueSubject<State, Never>(.initial)
    let intent = PassthroughSubject<Intent, Never>()

    private let service: ISampleService

    @Published var deviceInfos: [DeviceInfo] = []

    // MARK: - Constructors
    init(service: ISampleService = SampleService()) {
        self.service = service

        super.init()

        intent
            .sink { [weak self] action in
                guard let self else { return }

                handleAction(action)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Action
extension DemoRequestViewModel {
    private func handleAction(_ action: Intent) {
        switch action {
        case .fetchData:
            fetchData()
        }
    }
}

// MARK: - Methods
extension DemoRequestViewModel {
    private func fetchData() {
        service.getDeviceInfo()
            .sink { [weak self] completion in
                guard let self else { return }

                if case .failure(let error) = completion {
                    Logger.error(error.message)
                    state.send(.error(error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }

                Logger.info("Value: \(value)")
                
                deviceInfos = value
                state.send(.fetchDataSuccess)
            }
            .store(in: &subscriptions)
    }

    private func addData() {
        service.addDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - POST"))
            .sink { [weak self] completion in
                guard let self else { return }

                if case .failure(let error) = completion {
                    Logger.error(error.message)
                    state.send(.error(error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }

                Logger.info("Value: \(value)")
                state.send(.fetchDataSuccess)
            }
            .store(in: &subscriptions)
    }

    private func updateData() {
        service.updateDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - PUT"))
            .sink { [weak self] completion in
                guard let self else { return }

                if case .failure(let error) = completion {
                    Logger.error(error.message)
                    state.send(.error(error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }

                Logger.info("Value: \(value)")
                state.send(.fetchDataSuccess)
            }
            .store(in: &subscriptions)
    }

    private func partialUpdateData() {
        service.partialUpdateDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - PATCH"))
            .sink { [weak self] completion in
                guard let self else { return }

                if case .failure(let error) = completion {
                    Logger.error(error.message)
                    state.send(.error(error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }

                Logger.info("Value: \(value)")
                state.send(.fetchDataSuccess)
            }
            .store(in: &subscriptions)
    }

    private func deleteData() {
        service.deleteDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - DELETE"))
            .sink { [weak self] completion in
                guard let self else { return }

                if case .failure(let error) = completion {
                    Logger.error(error.message)
                    state.send(.error(error.message))
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }

                Logger.info("Value: \(value)")
                state.send(.fetchDataSuccess)
            }
            .store(in: &subscriptions)
    }
}
