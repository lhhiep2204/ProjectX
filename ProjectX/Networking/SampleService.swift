//
//  SampleService.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine
import CoreModule

protocol ISampleService {
    func getDeviceInfo() -> AnyPublisher<[DeviceInfo], NetworkError>
    func addDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError>
    func updateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError>
    func partialUpdateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError>
    func deleteDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<ResponseMessage, NetworkError>
}

struct SampleService: ISampleService {
    func getDeviceInfo() -> AnyPublisher<[DeviceInfo], NetworkError> {
        BaseService.shared.makeRequest(request: SampleRequest.getDeviceInfo)
    }

    func addDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError> {
        BaseService.shared.makeRequest(request: SampleRequest.addDeviceInfo(info))
    }

    func updateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError> {
        BaseService.shared.makeRequest(request: SampleRequest.updateDeviceInfo(info))
    }

    func partialUpdateDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<DeviceInfo, NetworkError> {
        BaseService.shared.makeRequest(request: SampleRequest.partialUpdateDeviceInfo(info))
    }

    func deleteDeviceInfo(_ info: DeviceInfo) -> AnyPublisher<ResponseMessage, NetworkError> {
        BaseService.shared.makeRequest(request: SampleRequest.deleteDeviceInfo)
    }
}
