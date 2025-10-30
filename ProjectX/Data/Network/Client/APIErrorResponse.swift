//
//  APIErrorResponse.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 18/6/25.
//

import Foundation

struct APIErrorResponse: Decodable {
    let error: APIErrorDetail
}

struct APIErrorDetail: Decodable {
    let code: Int
    let message: String
}
