//
//  NetworkLogger.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

public struct NetworkLogger {
    /// Log details of an HTTP request.
    ///
    /// - Parameter request: The URLRequest to be logged.
    static func httpRequestLogger(_ request: URLRequest) {
#if DEBUG
        var output = "🟡 Request:\n"
        var curl = ""

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

        print(output)
        print(curl + "\n")
#endif
    }

    /// Log details of an HTTP response.
    ///
    /// - Parameters:
    ///   - data: The response data.
    ///   - response: The URLResponse to be logged.
    static func httpResponseLogger(_ data: Data,
                                   _ response: HTTPURLResponse?) {
#if DEBUG
        var output = "🟢 Response:\n"

        if let response {
            if let url = response.url {
                output += "- URL: \(url)\n"
            }

            output += "- Status code: \(response.statusCode)\n"
            if let headers = response.allHeaderFields as? [String: Any] {
                output += "- Response Headers:\n"
                for (key, value) in headers {
                    output += " -H '\(key): \(value)'\n"
                }
            }
        }

        if let responseString = String(data: data, encoding: .utf8) {
            output += "- Response Data: \(responseString)\n"
        }

        print(output)
#endif
    }
}
