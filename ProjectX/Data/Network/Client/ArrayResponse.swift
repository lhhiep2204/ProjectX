//
//  ArrayResponse.swift
//  ProjectX
//
//  Created by Hoàng Hiệp Lê on 20/6/25.
//

import Foundation

/// A generic wrapper for decoding an array of `Decodable` items.
/// Used when an API returns a raw JSON array (e.g. `[{}, {}, ...]`)
struct ArrayResponse<T: Decodable>: @MainActor APIResponseProtocol {
    let items: [T]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var results = [T]()

        while !container.isAtEnd {
            let item = try container.decode(T.self)
            results.append(item)
        }

        self.items = results
    }
}
