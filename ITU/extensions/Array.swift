//
//  Array.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation

/// Extension to the Array type where Element conforms to Equatable protocol.
extension Array where Element : Equatable {
    /// Check if array contains an element whose property, specified by a `KeyPath`, matches a value.
    /// - Parameters:
    ///   - keyPath: The `KeyPath` of the property of `Element` to check.
    ///   - value: The value to match against the property specified by `keyPath`.
    /// - Returns: A boolean indicating whether there is an element in the array whose property, specified by `keyPath`, matches `value`.
    func contains<Value: Equatable>(keyPath: KeyPath<Element, Value>, matching value: Value) -> Bool {
        return self.contains { element in
            element[keyPath: keyPath] == value
        }
    }
}
