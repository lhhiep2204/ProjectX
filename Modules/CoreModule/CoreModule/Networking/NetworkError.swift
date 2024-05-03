//
//  NetworkError.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Alamofire

enum NetworkErrorType {
    case invalidUrl
    case invalidPayload
    case invalidResponse
    case networkError(Error)
}

public struct NetworkError: Error {
    private var type: NetworkErrorType

    init(_ type: NetworkErrorType) {
        self.type = type
    }

    public var message: String {
        switch type {
        case .invalidUrl:
            "Invalid URL"
        case .invalidPayload:
            "Invalid Payload"
        case .invalidResponse:
            "Invalid Response"
        case .networkError(let error):
            if let afError = error.asAFError {
                getErrorMessage(from: afError)
            } else {
                "Network error"
            }
        }
    }

    private func getErrorMessage(from error: AFError) -> String {
        switch error.responseCode {
        case 401:
            "Unauthorized"
        case 403:
            "Forbidden"
        default:
            error.errorDescription ?? error.localizedDescription
        }
    }
}
