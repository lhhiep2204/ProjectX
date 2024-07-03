//
//  DeviceInfo.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

struct DeviceInfo: Codable, Identifiable {
    var id: String = UUID().uuidString
    let name: String
}

struct ResponseMessage: Decodable {
    let message: String
}
