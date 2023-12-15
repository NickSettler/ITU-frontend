//
//  Sequence.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Sequence extension
extension Sequence {
    /// Sort sequence by key path and comparator
    /// - Parameters:
    ///   - keyPath: Key path
    ///   - comparator: Comparator closure (default: <)
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        using comparator: (T, T) -> Bool = (<)
    ) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
