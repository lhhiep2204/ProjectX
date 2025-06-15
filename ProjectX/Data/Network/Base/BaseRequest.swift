//
//  BaseRequest.swift
//  CoreModule
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

/// An enumeration representing various HTTP methods.
enum RequestMethod: String {
    case get, post, put, patch, delete
}

/// A structure representing information about a file to be uploaded.
struct FileInfo {
    let file: Data
    let filePath, fileName, mimeType: String

    init(file: Data, filePath: String, fileName: String, mimeType: String) {
        self.file = file
        self.filePath = filePath
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

// MARK: - BaseRequest Protocol
/// A protocol defining the basic structure for a network request.
protocol BaseRequest {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
}

// MARK: - BaseAPIRequest Protocol
/// A protocol defining the basic structure for a regular API request.
protocol BaseAPIRequest: BaseRequest {
    var parameters: [String: Any]? { get }
}

// MARK: - BaseUploadRequest Protocol
/// A protocol defining the basic structure for an upload request using Alamofire multipart.
protocol BaseUploadRequest: BaseRequest {
    var fileInfo: FileInfo { get }
}

// MARK: - Default Implementations
extension BaseRequest {
    var headers: [String: String]? {
        nil
    }
}

extension BaseAPIRequest {
    var parameters: [String: Any]? {
        nil
    }
}

extension BaseUploadRequest {
    var method: RequestMethod {
        .post
    }
}
