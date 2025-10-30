//
//  APIResponseProtocol.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 18/6/25.
//

import Foundation

/// A protocol that defines the structure for API response objects.
/// Conforming types must be decodable and include a result code property
/// to indicate the success or failure of the API request.
protocol APIResponseProtocol: Decodable {}
