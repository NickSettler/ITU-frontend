//
//  Array.swift
//  ITU
//
//  Created by Никита Моисеев on 05.11.2023.
//

import Foundation

extension Array where Element : Equatable {
    func contains<Value: Equatable>(keyPath: KeyPath<Element, Value>, matching value: Value) -> Bool {
        return self.contains { element in
            element[keyPath: keyPath] == value
        }
    }
}
