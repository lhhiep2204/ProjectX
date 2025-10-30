//
//  APITargetProtocol.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 18/6/25.
//

import Foundation

// MARK: - HTTPMethod Enum
/// An enumeration representing various HTTP methods.
/// These methods define the standard actions that can be performed on resources in a RESTful API.
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - RequestBody Enum
/// An enumeration representing different types of request bodies.
/// This provides a flexible way to handle various data formats in API requests.
///
/// - encodable: Contains an Encodable object that will be serialized to JSON.
/// - parameters: Contains a dictionary of string key-value pairs for URL query parameters.
enum RequestBody {
    case encodable(Encodable)
    case parameters([String: String])
}

// MARK: - Authentication Type Enum
/// An enumeration representing different authentication methods.
enum AuthenticationType {
    case none
    case bearer(String)
    case apiKey(String)
    case basic(username: String, password: String)
}

// MARK: - APITargetProtocol
/// A protocol defining the basic structure for a network request target.
///
/// This protocol serves as a blueprint for API endpoints, providing all the necessary
/// information to construct a complete HTTP request. By conforming to this protocol,
/// API endpoints can be defined in a consistent and type-safe manner.
///
/// Implementations typically organize API endpoints as enum cases, with each case
/// representing a specific API endpoint and conforming to this protocol.
protocol APITargetProtocol {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: RequestBody? { get }
    var requiresAuthentication: Bool { get }
    var authenticationType: AuthenticationType { get }
    var timeoutInterval: TimeInterval { get }
}

/// Default implementations for the APITargetProtocol.
/// These provide sensible defaults that can be overridden when needed.
extension APITargetProtocol {
    var baseURL: String {
        NetworkConfiguration.baseURL
    }

    var header: [String: String]? {
        nil
    }

    var body: RequestBody? {
        nil
    }

    var requiresAuthentication: Bool {
        true
    }

    var authenticationType: AuthenticationType {
        .bearer("ACCESS_TOKEN")
    }

    var timeoutInterval: TimeInterval {
        NetworkConfiguration.timeoutInterval
    }
}
