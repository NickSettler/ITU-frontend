//
//  Array.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Array extension
extension Array where Element : Equatable {
    /// Check if array contains element by key path and value
    /// - Parameters:
    ///   - keyPath: Key path
    ///   - value: Value
    /// - Returns: True if array contains element by key path and value
    func contains<Value: Equatable>(keyPath: KeyPath<Element, Value>, matching value: Value) -> Bool {
        return self.contains { element in
            element[keyPath: keyPath] == value
        }
    }
}
