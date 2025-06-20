//
//  DeviceInfoService.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Combine

protocol DeviceInfoServiceProtocol {
    func getDeviceInfo() async throws -> [DeviceInfo]
    func addDeviceInfo(_ info: DeviceInfo) async throws -> DeviceInfo
    func updateDeviceInfo(_ info: DeviceInfo) async throws -> DeviceInfo
    func partialUpdateDeviceInfo(_ info: DeviceInfo) async throws -> DeviceInfo
    func deleteDeviceInfo(_ info: DeviceInfo) async throws -> ResponseMessage
}

struct DeviceInfoService: APIService, DeviceInfoServiceProtocol {
    func getDeviceInfo() async throws -> [DeviceInfo] {
        let response: ArrayResponse<DeviceInfo> = try await makeRequest(target: DeviceInfoRequest.getDeviceInfo)
        return response.items
    }

    func addDeviceInfo(_ info: DeviceInfo) async throws -> DeviceInfo {
        try await makeRequest(target: DeviceInfoRequest.addDeviceInfo(info))
    }

    func updateDeviceInfo(_ info: DeviceInfo) async throws -> DeviceInfo {
        try await makeRequest(target: DeviceInfoRequest.updateDeviceInfo(info))
    }

    func partialUpdateDeviceInfo(_ info: DeviceInfo) async throws -> DeviceInfo {
        try await makeRequest(target: DeviceInfoRequest.partialUpdateDeviceInfo(info))
    }

    func deleteDeviceInfo(_ info: DeviceInfo) async throws -> ResponseMessage {
        try await makeRequest(target: DeviceInfoRequest.deleteDeviceInfo)
    }
}
