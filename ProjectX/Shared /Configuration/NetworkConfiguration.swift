//
//  NetworkConfiguration.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 19/6/25.
//

import Foundation

struct NetworkConfiguration {
    // Base URL for API requests
    static let baseURL: String = "https://api.restful-api.dev/"

    // Timeout intervals
    static let timeoutInterval: TimeInterval = 30.0
    static let resourceTimeoutInterval: TimeInterval = 60.0

    // Retry configuration
    static let retryCount: Int = 3
    static let retryDelay: TimeInterval = 3.0
    static let maxRetries: Int = 3
}
