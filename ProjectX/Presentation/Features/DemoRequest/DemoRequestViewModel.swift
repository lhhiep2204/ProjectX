//
//  DemoRequestViewModel.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 3/7/24.
//

import Combine
import Foundation

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

    private let service: DeviceInfoServiceProtocol

    @Published var deviceInfos: [DeviceInfo] = []

    // MARK: - Constructors
    init(service: DeviceInfoServiceProtocol = DeviceInfoService()) {
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
        Task { @MainActor in
            do {
                deviceInfos = try await service.getDeviceInfo()
                Logger.info("Value: \(deviceInfos)")
            } catch let error as APIError {
                Logger.error(error.errorDescription)
            }
        }
    }

    private func addData() {
        Task {
            do {
                let deviceInfo = try await service.addDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - POST"))
                Logger.info("Value: \(deviceInfo)")
            } catch let error as APIError {
                Logger.error(error.errorDescription)
            }
        }
    }

    private func updateData() {
        Task {
            do {
                let deviceInfo = try await service.updateDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - PUT"))
                Logger.info("Value: \(deviceInfo)")
            } catch let error as APIError {
                Logger.error(error.errorDescription)
            }
        }
    }

    private func partialUpdateData() {
        Task {
            do {
                let deviceInfo = try await service.partialUpdateDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - PATCH"))
                Logger.info("Value: \(deviceInfo)")
            } catch let error as APIError {
                Logger.error(error.errorDescription)
            }
        }
    }

    private func deleteData() {
        Task {
            do {
                let deviceInfo = try await service.deleteDeviceInfo(DeviceInfo(name: "Apple iPhone 15 Pro - DELETE"))
                Logger.info("Value: \(deviceInfo)")
            } catch let error as APIError {
                Logger.error(error.errorDescription)
            }
        }
    }
}
