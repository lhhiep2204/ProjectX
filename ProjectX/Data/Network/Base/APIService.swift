//
//  APIService.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 18/6/25.
//

import Foundation

/// A protocol defining the base structure for network service interactions.
/// This service provides a standardized way to make API requests using Swift Concurrency.
/// It handles common networking tasks such as request creation, response parsing, error handling,
/// and automatic retries for certain error conditions.
protocol APIService {
    /// Makes a generic network request and returns the decoded response.
    ///
    /// - Parameter target: The API target containing all necessary request information.
    /// - Returns: The decoded response of type T.
    /// - Throws: APIError if the request fails.
    func makeRequest<T: APIResponseProtocol>(target: APITargetProtocol) async throws -> T
}

/// Default implementation of the makeRequest method.
/// This extension provides an interface that delegates to the internal implementation.
extension APIService {
    func makeRequest<T: APIResponseProtocol>(target: APITargetProtocol) async throws -> T {
        try await performRequest(target: target)
    }
}

/// Private implementation details for the APIService protocol.
///
/// This extension contains the internal logic for making network requests,
/// handling responses, parsing data, and managing errors and retries.
/// These implementation details are kept separate from the public interface
/// to maintain a clean separation of concerns.
extension APIService {
    /// Internal implementation of the request method with retry capability.
    ///
    /// - Parameters:
    ///   - target: The API target containing all necessary request information.
    ///   - retryCount: The number of remaining retry attempts (defaults to APIConstants.maxRetries).
    /// - Returns: The decoded response of type T.
    /// - Throws: APIError if the request fails.
    private func performRequest<T: APIResponseProtocol>(
        target: APITargetProtocol,
        retryCount: Int = NetworkConfiguration.retryCount
    ) async throws -> T {
        guard let urlRequest = createURLRequest(from: target) else {
            throw APIError.invalidURL
        }

        do {
            let (data, response) = try await session.data(for: urlRequest)
            let validatedData = try parseHTTPStatusCode(data: data, response: response)
            let decodedResponse: T = try decodeJson(data: validatedData)

            return decodedResponse
        } catch let error as APIError {
            // Handle authentication errors
            if case .unauthorized = error, target.requiresAuthentication {
                return try await handleAuthenticationError(target: target, retryCount: retryCount)
            }

            // Handle other retryable errors
            return try await handleError(error: error, target: target, retryCount: retryCount)
        } catch {
            let mappedError = mapNetworkError(error)
            return try await handleError(error: mappedError, target: target, retryCount: retryCount)
        }
    }

    /// Returns a configured URLSession for network requests.
    ///
    /// This property uses dependency injection to obtain a URLSession instance.
    private var session: URLSession {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = NetworkConfiguration.timeoutInterval
        config.timeoutIntervalForResource = NetworkConfiguration.resourceTimeoutInterval

        return URLSession(configuration: config)
    }

    /// Creates a URLRequest from an APITargetProtocol object.
    ///
    /// - Parameter target: The API target containing all necessary request information.
    /// - Returns: A configured URLRequest or nil if the URL is invalid.
    private func createURLRequest(from target: APITargetProtocol) -> URLRequest? {
        // Create and validate URL
        guard let url = URL(string: target.baseURL + target.endpoint) else {
            NetworkLogger.httpErrorLogger(APIError.invalidURL)
            return nil
        }

        // Initialize request with basic configuration
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = target.method.rawValue
        urlRequest.timeoutInterval = target.timeoutInterval
        urlRequest.allHTTPHeaderFields = target.header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("ProjectX", forHTTPHeaderField: "User-Agent")

        // Add authentication headers if required
        if target.requiresAuthentication {
            addAuthenticationHeaders(to: &urlRequest, type: target.authenticationType)
        }

        // Early return if no body
        guard let body = target.body else {
            NetworkLogger.httpRequestLogger(urlRequest)
            return urlRequest
        }

        // Handle GET method with query parameters
        if target.method == .get, case .parameters(let params) = body {
            guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                NetworkLogger.httpErrorLogger(APIError.invalidURL)
                return nil
            }

            urlComponent.queryItems = params.map { URLQueryItem(name: $0, value: $1) }

            guard let updatedURL = urlComponent.url else {
                NetworkLogger.httpErrorLogger(
                    APIError.custom("Invalid query parameters: \(params)")
                )
                return nil
            }

            urlRequest.url = updatedURL
        }

        // Handle methods with request body
        else if [.post, .put, .patch, .delete].contains(target.method), case .encodable(let encodableData) = body {
            do {
                let encoder = JSONEncoder()
                urlRequest.httpBody = try encoder.encode(AnyEncodable(encodableData))
            } catch {
                NetworkLogger.httpErrorLogger(error)
                return nil
            }
        }

        NetworkLogger.httpRequestLogger(urlRequest)
        return urlRequest
    }

    /// Adds authentication headers to the request based on the authentication type.
    ///
    /// - Parameters:
    ///   - request: The URLRequest to add headers to.
    ///   - type: The authentication type to use.
    private func addAuthenticationHeaders(to request: inout URLRequest, type: AuthenticationType) {
        switch type {
        case .none:
            break
        case .bearer(let token):
            if !token.isEmpty {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        case .apiKey(let key):
            if !key.isEmpty {
                request.addValue(key, forHTTPHeaderField: "X-API-Key")
            }
        case .basic(let username, let password):
            let credentials = "\(username):\(password)"
            if let data = credentials.data(using: .utf8) {
                let base64Credentials = data.base64EncodedString()
                request.addValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
            }
        }
    }

    /// Parses the HTTP status code from a response and validates it.
    ///
    /// - Parameter output: The output from a URLSession data task.
    /// - Returns: The response data if the status code is valid (200-299).
    /// - Throws: An APIError if the status code indicates an error condition.
    private func parseHTTPStatusCode(
        data: Data,
        response: URLResponse
    ) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        let statusCode = httpResponse.statusCode
        guard (200...299).contains(statusCode) else {
            throw mapStatusCodeToError(statusCode)
        }

        NetworkLogger.httpResponseLogger(data, httpResponse)

        return data
    }

    /// Maps HTTP status codes to appropriate APIError cases.
    ///
    /// - Parameter statusCode: The HTTP status code to map.
    /// - Returns: The corresponding APIError.
    private func mapStatusCodeToError(_ statusCode: Int) -> APIError {
        switch statusCode {
        case 400: .badRequest
        case 401: .unauthorized
        case 403: .forbidden
        case 404: .notFound
        case 429: .rateLimited
        case 500: .serverError
        case 502, 503: .maintenance
        case 504: .gatewayTimeout
        default: .custom(String(statusCode))
        }
    }

    /// Decodes JSON response data into the specified type.
    ///
    /// - Parameter data: The JSON data to decode.
    /// - Returns: The decoded response object.
    /// - Throws: APIError if decoding fails or result code indicates error.
    private func decodeJson<T: APIResponseProtocol>(data: Data) throws -> T {
        let decoder = JSONDecoder()

        do {
            let response = try decoder.decode(T.self, from: data)

            return response
        } catch let decodingError as DecodingError {
            do {
                let errorResponse = try decoder.decode(APIErrorResponse.self, from: data)

                throw APIError.errorResponse(
                    code: errorResponse.error.code,
                    message: errorResponse.error.message
                )
            } catch {
                throw decodingError
            }
        }
    }

    /// Handles authentication errors by attempting to refresh token and retry.
    ///
    /// - Parameters:
    ///   - target: The API target containing all necessary request information.
    ///   - retryCount: The number of remaining retry attempts.
    /// - Returns: The decoded response if successful after token refresh.
    /// - Throws: APIError if authentication fails or retry limit exceeded.
    private func handleAuthenticationError<T: APIResponseProtocol>(
        target: APITargetProtocol,
        retryCount: Int
    ) async throws -> T {
        guard retryCount > 0 else {
            throw APIError.unauthorized
        }

        // Attempt to refresh token
        do {
            //            try await AuthManager.shared.refreshToken()

            // Retry the original request with new token
            return try await performRequest(target: target, retryCount: retryCount - 1)
        } catch {
            // If token refresh fails, throw unauthorized error
            throw APIError.unauthorized
        }
    }

    /// Maps various error types to appropriate APIError cases.
    ///
    /// - Parameter error: The original error that occurred during the network request.
    /// - Returns: A standardized APIError that can be handled by the application.
    private func mapNetworkError(_ error: Error) -> APIError {
        NetworkLogger.httpErrorLogger(error)

        if let apiError = error as? APIError {
            return apiError
        }

        if let urlError = error as? URLError {
            return mapURLError(urlError)
        }

        if let decodingError = error as? DecodingError {
            return mapDecodingError(decodingError)
        }

        return .custom(error.localizedDescription)
    }

    /// Maps URLError to appropriate APIError cases.
    ///
    /// - Parameter urlError: The URLError to map.
    /// - Returns: A standardized APIError.
    private func mapURLError(_ urlError: URLError) -> APIError {
        switch urlError.code {
        case .timedOut, .notConnectedToInternet, .networkConnectionLost:
            return .connectivity(urlError.localizedDescription)
        case .cancelled:
            return .cancelled
        default:
            return .custom(urlError.localizedDescription)
        }
    }

    /// Maps DecodingError to appropriate APIError cases.
    ///
    /// - Parameter decodingError: The DecodingError to map.
    /// - Returns: A standardized APIError.
    private func mapDecodingError(_ decodingError: DecodingError) -> APIError {
        switch decodingError {
        case .keyNotFound(let key, let context):
            return .decodingError("Key not found: \(key), \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            return .decodingError("Value not found: \(type), \(context.debugDescription)")
        case .typeMismatch(let type, let context):
            return .decodingError("Type mismatch: \(type), \(context.debugDescription)")
        case .dataCorrupted(let context):
            return .decodingError("Data corrupted: \(context.debugDescription)")
        default:
            return .decodingError("Unknown decoding error: \(decodingError.localizedDescription)")
        }
    }

    /// Handles errors from network r equests and implements retry logic.
    ///
    /// - Parameters:
    ///   - error: The APIError that occurred during the request.
    ///   - target: The API target containing all necessary request information.
    ///   - retryCount: The number of remaining retry attempts.
    /// - Returns: The decoded response if successful after retry.
    /// - Throws: APIError if retry limit exceeded or non-retryable error.
    private func handleError<T: APIResponseProtocol>(
        error: APIError,
        target: APITargetProtocol,
        retryCount: Int
    ) async throws -> T {
        guard retryCount > 0 else {
            throw error
        }

        if error.isRetryable {
            try await Task.sleep(nanoseconds: UInt64(error.retryDelay * 1_000_000_000))
            return try await performRequest(target: target, retryCount: retryCount - 1)
        } else {
            // Don't retry client errors (4xx) except for specific cases
            throw error
        }
    }
}

/// A type-erasing wrapper for Encodable values.
///
/// This struct allows any Encodable type to be wrapped in a common type,
/// which is useful when dealing with heterogeneous collections of Encodable objects
struct AnyEncodable: Encodable {
    private let encode: (Encoder) throws -> Void

    init(_ value: Encodable) {
        self.encode = value.encode
    }

    func encode(to encoder: Encoder) throws {
        try encode(encoder)
    }
}
