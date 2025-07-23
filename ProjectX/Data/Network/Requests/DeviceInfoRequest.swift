//
//  DeviceInfoRequest.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

enum DeviceInfoRequest {
    case getDeviceInfo
    case addDeviceInfo(DeviceInfo)
    case updateDeviceInfo(DeviceInfo)
    case partialUpdateDeviceInfo(DeviceInfo)
    case deleteDeviceInfo
}

extension DeviceInfoRequest: APITargetProtocol {
    var endpoint: String {
        switch self {
        case .updateDeviceInfo, .partialUpdateDeviceInfo, .deleteDeviceInfo:
            "objects/ff8081818b1b4123018b7fd8a27c024a"
        default:
            "objects"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDeviceInfo: .get
        case .addDeviceInfo: .post
        case .updateDeviceInfo: .put
        case .partialUpdateDeviceInfo: .patch
        case .deleteDeviceInfo: .delete
        }
    }
    
    var body: RequestBody? {
        switch self {
        case .getDeviceInfo:
            return nil
        case .addDeviceInfo(let device),
                .updateDeviceInfo(let device),
                .partialUpdateDeviceInfo(let device):
            return .encodable(device)
        case .deleteDeviceInfo:
            return .parameters(["id": "5"])
        }
    }
    
    var requiresAuthentication: Bool {
        false
    }
}
