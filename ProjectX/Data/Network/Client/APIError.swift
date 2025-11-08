//
//  APIError.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 18/6/25.
//

import Foundation

/// An enumeration representing network-related errors in API operations.
///
/// This enum standardizes error handling for network requests, providing specific cases
/// for common HTTP errors, connectivity issues, and decoding failures. It includes
/// English error messages for user display and supports retry logic for robust recovery.
enum APIError: Error {
    // HTTP status code errors
    case badRequest                // 400
    case unauthorized              // 401
    case forbidden                 // 403
    case notFound                  // 404
    case rateLimited               // 429
    case serverError               // 500
    case maintenance               // 502, 503
    case gatewayTimeout            // 504

    // Network and client errors
    case invalidURL
    case invalidResponse
    case connectivity(String)
    case decodingError(String)
    case cancelled

    // Server-provided error response
    case errorResponse(code: Int, message: String)
    case custom(String)
}

/// Extension that provides human-readable error messages for APIError cases.
/// These messages can be used for user-facing error displays or logging.
extension APIError {
    /// A user-facing error message in English.
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid. Please try again."
        case .invalidResponse:
            return "The server response was invalid. Please try again later."
        case .badRequest:
            return "Invalid request. Please check your input and try again."
        case .unauthorized:
            return "Authentication failed. Please log in again."
        case .forbidden:
            return "Access denied. You don’t have permission for this action."
        case .notFound:
            return "The requested resource was not found."
        case .rateLimited:
            return "Too many requests. Please wait and try again."
        case .serverError:
            return "A server error occurred. Please try again later."
        case .maintenance:
            return "The service is down for scheduled maintenance. Please try again later."
        case .gatewayTimeout:
            return "The request timed out. Please try again."
        case .decodingError:
            return "Failed to process the server response. Please try again."
        case .connectivity(let message):
            return message.isEmpty ? "No internet connection. Please check your network and try again." : message
        case .errorResponse(let code, let message):
            return message.isEmpty ? "Error \(code): An error occurred. Please try again." : "Error \(code): \(message)"
        case .custom(let message):
            return message.isEmpty ? "An error occurred. Please try again." : message
        case .cancelled:
            return "The request was cancelled."
        }
    }
}

/// Extension that provides retry capability information for different error types.
extension APIError {
    /// Indicates whether the error is retryable.
    var isRetryable: Bool {
        switch self {
        case .connectivity, .serverError, .gatewayTimeout, .rateLimited, .unauthorized:
            return true
        default:
            return false
        }
    }

    /// The delay interval before retrying the error, if applicable.
    var retryDelay: TimeInterval {
        switch self {
        case .connectivity, .serverError, .gatewayTimeout, .rateLimited:
            return 3.0
        case .unauthorized:
            return 0.0 // Immediate retry for token refresh
        default:
            return 0.0
        }
    }
}
