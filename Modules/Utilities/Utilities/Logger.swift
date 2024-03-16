//
//  Logger.swift
//  Utilities
//
//  Created by Hoàng Hiệp Lê on 16/03/2024.
//

import Foundation

enum LogLevel: String {
    case info = "🔵"
    case warning = "🟠"
    case error = "🔴"
}

public struct Logger {
    private static func logHeader(_ level: LogLevel,
                                  file: String,
                                  line: Int,
                                  column: Int,
                                  function: String) {
        print("\(level.rawValue) \(getFileName(file)): Line \(line), Column: \(column) ~ \(function)")
    }

    private static func getFileName(_ file: String) -> String {
        let fileURL = URL(filePath: file)
        return fileURL.lastPathComponent
    }
}

public extension Logger {
    static func info(file: String = #file,
                     line: Int = #line,
                     column: Int = #column,
                     function: String = #function,
                     _ messages: Any...) {
#if DEBUG
        logHeader(.info, file: file, line: line, column: column, function: function)

        for message in messages {
            print("\(message)\n")
        }
#endif
    }

    static func warning(file: String = #file,
                        line: Int = #line,
                        column: Int = #column,
                        function: String = #function,
                        _ messages: Any...) {
#if DEBUG
        logHeader(.warning, file: file, line: line, column: column, function: function)

        for message in messages {
            print("\(message)\n")
        }
#endif
    }

    static func error(file: String = #file,
                      line: Int = #line,
                      column: Int = #column,
                      function: String = #function,
                      _ messages: Any...) {
#if DEBUG
        logHeader(.error, file: file, line: line, column: column, function: function)

        for message in messages {
            print("\(message)\n")
        }
#endif
    }
}
