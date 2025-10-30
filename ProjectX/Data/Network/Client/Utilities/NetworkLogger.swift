//
//  NetworkLogger.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

/// A utility class for logging network-related information including HTTP requests, responses, and errors.
/// This logger is only active in DEBUG builds and provides formatted output for debugging network issues.
enum NetworkLogger {
    /// Write a message to the console output based on the current environment.
    ///
    /// - Parameter message: The message string to be written to the console.
    private static func write(_ message: String) {
#if DEBUG
        print(message)
#endif
    }

    /// Log details of an HTTP request.
    ///
    /// - Parameter request: The URLRequest to be logged.
    static func httpRequestLogger(_ request: URLRequest) {
        var output = "🟡 Request:\n"
        var curl = String.empty

        if let url = request.url {
            output += "- URL: \(url)\n"
            curl += "curl -v '\(url.absoluteString)'"
        }

        if let method = request.httpMethod {
            output += "- Method: \(method)\n"
            curl += " -X \(method)"
        }

        if let headers = request.allHTTPHeaderFields {
            output += "- Headers:\n"
            for (key, value) in headers {
                output += " -H '\(key): \(value)'\n"
                curl += " -H '\(key): \(value)'"
            }
        }

        if let httpBody = request.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            output += "- Body: \(bodyString)\n"
            curl += " -d '\(bodyString)'"
        }
        write(output + curl + "\n")
    }

    /// Log details of an HTTP response.
    ///
    /// - Parameters:
    ///   - data: The response data.
    ///   - response: The URLResponse to be logged.
    static func httpResponseLogger(_ data: Data, _ response: URLResponse) {
        var output = "🟢 Response:\n"

        if let httpResponse = response as? HTTPURLResponse {
            if let url = httpResponse.url {
                output += "- URL: \(url)\n"
            }

            output += "- Status code: \(httpResponse.statusCode)\n"
            if let headers = httpResponse.allHeaderFields as? [String: Any] {
                output += "- Response Headers:\n"
                for (key, value) in headers {
                    output += " -H '\(key): \(value)'\n"
                }
            }
        }

        if let responseString = String(data: data, encoding: .utf8) {
            output += "- Response Data: \(responseString)\n"
        }

        write(output)
    }

    /// Log details of network errors.
    ///
    /// - Parameter error: The error that occurred.
    static func httpErrorLogger(_ error: Error) {
        var output = "🔴 Error:\n"

        if let apiError = error as? APIError {
            output += "- APIError: \(apiError.errorDescription)\n"
        } else if let urlError = error as? URLError {
            output += "- URLError: \(urlError.localizedDescription)\n"
        } else if let decodingError = error as? DecodingError {
            output += "- DecodingError: \(decodingError.localizedDescription)\n"
        } else {
            output += "- Description: \(error.localizedDescription)\n"
        }

        write(output)
    }
}
