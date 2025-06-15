//
//  DeviceInfoService.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine

protocol DeviceInfoServiceProtocol {
    func getDeviceInfo() -> AnyPublisher<[DeviceInfo], NetworkError>
    func addDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError>
    func updateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError>
    func partialUpdateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError>
    func deleteDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<ResponseMessage, NetworkError>
}

struct DeviceInfoService: DeviceInfoServiceProtocol {
    func getDeviceInfo() -> AnyPublisher<[DeviceInfo], NetworkError> {
        BaseService.shared.makeRequest(request: DeviceInfoRequest.getDeviceInfo)
    }

    func addDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError> {
        BaseService.shared.makeRequest(request: DeviceInfoRequest.addDeviceInfo(info))
    }

    func updateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError> {
        BaseService.shared.makeRequest(request: DeviceInfoRequest.updateDeviceInfo(info))
    }

    func partialUpdateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError> {
        BaseService.shared.makeRequest(request: DeviceInfoRequest.partialUpdateDeviceInfo(info))
    }

    func deleteDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<ResponseMessage, NetworkError> {
        BaseService.shared.makeRequest(request: DeviceInfoRequest.deleteDeviceInfo)
    }
}
