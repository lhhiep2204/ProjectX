//
//  Date.swift
//  Extensions
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

public extension Date {
    /// Converts a Date object to a string with a specified date format.
    /// 
    /// - Parameter dateFormat: The format in which the date should be represented.
    /// - Returns: A string representation of the date.
    func toString(_ dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
