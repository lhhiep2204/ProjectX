//
//  Logger.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

/// Defines the severity levels for logging with visual indicators.
enum LogLevel: String {
    case debug = "🟡"   // Detailed information for debugging purposes
    case info = "🔵"    // General information about application flow
    case warning = "🟠" // Potential issues that aren't critical errors
    case error = "🔴"   // Critical errors that may cause application failure
}

/// A utility for structured logging throughout the application.
/// Provides different logging levels and automatically includes file, line, and function information.
/// Logs are only printed in DEBUG builds to prevent leaking information in production.
enum Logger {
    // swiftlint:disable function_parameter_count
    /// Writes a log message with the specified level and execution context.
    /// - Parameters:
    ///   - level: The severity level of the log message
    ///   - file: The file where the log was called from (automatically provided)
    ///   - line: The line number where the log was called from (automatically provided)
    ///   - column: The column number where the log was called from (automatically provided)
    ///   - function: The function where the log was called from (automatically provided)
    ///   - messages: Variadic messages to log, each converted to a string.
    private static func write(
        _ level: LogLevel,
        file: String,
        line: Int,
        column: Int,
        function: String,
        _ messages: Any...
    ) {
#if DEBUG
        print("\(level.rawValue) \(getFileName(file)): Line \(line), Column: \(column) ~ \(function)")
        print("\(messages.map {"\($0)"}.joined(separator: "\n"))\n")
#endif
    }
    // swiftlint:enable function_parameter_count

    /// Extracts the file name from a full file path.
    /// - Parameter file: The full file path
    /// - Returns: Just the file name component
    private static func getFileName(_ file: String) -> String {
        file.components(separatedBy: "/").last ?? .empty
    }
}

extension Logger {
    /// Logs a message with debug level.
    /// Use for detailed debugging information and tracing.
    /// - Parameters:
    ///   - file: The file where the log was called from (automatically provided)
    ///   - line: The line number where the log was called from (automatically provided)
    ///   - column: The column number where the log was called from (automatically provided)
    ///   - function: The function where the log was called from (automatically provided)
    ///   - messages: Variadic messages to log, each converted to a string.
    static func debug(
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        _ messages: Any...
    ) {
        write(.debug, file: file, line: line, column: column, function: function, messages)
    }

    /// Logs a message with info level.
    /// Use for general information about application flow.
    /// - Parameters:
    ///   - file: The file where the log was called from (automatically provided)
    ///   - line: The line number where the log was called from (automatically provided)
    ///   - column: The column number where the log was called from (automatically provided)
    ///   - function: The function where the log was called from (automatically provided)
    ///   - messages: Variadic messages to log, each converted to a string.
    static func info(
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        _ messages: Any...
    ) {
        write(.info, file: file, line: line, column: column, function: function, messages)
    }

    /// Logs a message with warning level.
    /// Use for potential issues that aren't critical errors.
    /// - Parameters:
    ///   - file: The file where the log was called from (automatically provided)
    ///   - line: The line number where the log was called from (automatically provided)
    ///   - column: The column number where the log was called from (automatically provided)
    ///   - function: The function where the log was called from (automatically provided)
    ///   - messages: Variadic messages to log, each converted to a string.
    static func warning(
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        _ messages: Any...
    ) {
        write(.warning, file: file, line: line, column: column, function: function, messages)
    }

    /// Logs a message with error level.
    /// Use for critical errors that may cause application failure.
    /// - Parameters:
    ///   - file: The file where the log was called from (automatically provided)
    ///   - line: The line number where the log was called from (automatically provided)
    ///   - column: The column number where the log was called from (automatically provided)
    ///   - function: The function where the log was called from (automatically provided)
    ///   - messages: Variadic messages to log, each converted to a string.
    static func error(
        file: String = #file,
        line: Int = #line,
        column: Int = #column,
        function: String = #function,
        _ messages: Any...
    ) {
        write(.error, file: file, line: line, column: column, function: function, messages)
    }
}
