//
//  RefreshTokenRequest.swift
//  Networking
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

struct RefreshTokenRequest: BaseAPIRequest {
    var baseURL: String {
        // TODO: Replace with the project's base URL
        "https://example-api.com/"
    }
    
    var endpoint: String {
        // TODO: Replace with the specific endpoint for refreshing tokens in the project
        "sampleEndpoint"
    }
    
    var method: RequestMethod {
        .post
    }
    
    var parameters: [String : Any]? {
        // TODO: Replace both the key and value with the actual refresh token parameter and value in your project
        ["refresh_token": "refreshToken"]
    }
}
