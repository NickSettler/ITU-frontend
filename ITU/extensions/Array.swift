//
//  Array.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

extension Array where Element : Equatable {
    func contains<Value: Equatable>(keyPath: KeyPath<Element, Value>, matching value: Value) -> Bool {
        return self.contains { element in
            element[keyPath: keyPath] == value
        }
    }
}
