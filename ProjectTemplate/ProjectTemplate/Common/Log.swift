//
//  Log.swift
//  VIBChampion
//
//  Created by ha van dong on 1/15/21.
//

import Foundation
import Log

// Define global instane to call log
let appLog = Log()

final class Log {
    // MARK: - Properties
    private let log = Logger()

    // MARK: - Public
    func trace(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log.trace(items)
    }

    func debug(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log.debug(items, separator, terminator, file, line, column, function)
    }

    func info(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log.info(items, separator, terminator, file, line, column, function)
    }

    func warning(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log.warning(items, separator, terminator, file, line, column, function)
    }

    func error(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) {
        log.warning(items, separator, terminator, file, line, column, function)
    }
}
