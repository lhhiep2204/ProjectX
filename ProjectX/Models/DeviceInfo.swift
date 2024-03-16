//
//  DeviceInfo.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

struct DeviceInfo: Codable {
    let name: String
}

struct ResponseMessage: Decodable {
    let message: String
}
