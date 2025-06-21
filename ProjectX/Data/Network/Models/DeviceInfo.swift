//
//  DeviceInfo.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 21/6/25.
//

import Foundation

struct DeviceInfo: APIResponseProtocol, Encodable, Identifiable {
    var id: String = UUID().uuidString
    let name: String
}

struct ResponseMessage: APIResponseProtocol {
    let message: String
}
