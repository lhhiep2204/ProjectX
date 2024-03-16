//
//  SampleRequest.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Extensions
import Networking

enum SampleRequest {
    case getDeviceInfo
    case addDeviceInfo(DeviceInfo)
    case updateDeviceInfo(DeviceInfo)
    case partialUpdateDeviceInfo(DeviceInfo)
    case deleteDeviceInfo
}

extension SampleRequest: BaseAPIRequest {
    var baseURL: String {
        "https://api.restful-api.dev/"
    }

    var endpoint: String {
        switch self {
        case .updateDeviceInfo, .partialUpdateDeviceInfo, .deleteDeviceInfo:
            "objects/ff8081818b1b4123018b7fd8a27c024a"
        default:
            "objects"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getDeviceInfo: .get
        case .addDeviceInfo: .post
        case .updateDeviceInfo: .put
        case .partialUpdateDeviceInfo: .patch
        case .deleteDeviceInfo: .delete
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .getDeviceInfo:
            nil
        case .addDeviceInfo(let device),
             .updateDeviceInfo(let device),
             .partialUpdateDeviceInfo(let device):
            device.toDictionary()
        case .deleteDeviceInfo:
            ["id": "5"]
        }
    }
}
