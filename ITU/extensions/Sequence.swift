//
//  Sequence.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import Foundation

/// Extension to the Sequence type to add a sorting functionality based on a keypath of the sequence element.
extension Sequence {
	/// Sort sequence by key path and comparator
	/// - Parameters:
	///   - keyPath: Key path of a property by which the sequence is sorted.
	///   - comparator: Optional comparator closure that takes two properties as parameters and returns a Bool. Defaults to standard <+operator (less than).
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        using comparator: (T, T) -> Bool = (<)
    ) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}
