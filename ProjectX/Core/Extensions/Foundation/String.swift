//
//  String.swift
//  Extensions
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

extension String {
    static let empty = ""

    var trim: Self {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func replace(_ target: String, with replacement: String) -> Self {
        replacingOccurrences(of: target, with: replacement)
    }
}

extension String {
    /// Converts a string to a Date object using a specified date format.
    ///
    /// - Parameter dateFormat: The format in which the date is represented in the string.
    /// - Returns: A Date object if conversion is successful, otherwise nil.
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.date(from: self)
    }
}
