//
//  Encodable.swift
//  Extensions
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

extension Encodable {
    /// Converts an encodable object to a dictionary.
    /// - Returns: A dictionary representation of the encodable object.
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            
            return dict?.compactMapValues { $0 }
        } catch {
            print("Error encoding or converting to dictionary: \(error)")
            
            return nil
        }
    }
}
