//
//  MenuTabPosition.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// A PreferenceKey representing the position of the Menu Tab.
struct PositionKey : PreferenceKey {
    // The default value is .zero
    static var defaultValue: CGRect = .zero

    /// Function that modifies the existing value with the new value for the Menu Tab Position.
    /// - Parameters:
    ///   - value: The current value for Menu Tab Position expressed as CGRect
    ///   - nextValue: The new value for Menu Tab Position provided as a closure returning CGRect
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

/// View extension for reading the position of Menu Tab.
extension View {
    /// A function that allows to access and control the position of a View.
    /// Update view position with a completion handler upon change.
    /// - Parameter completion: A closure that allows you to perform some tasks after updating the position.
    /// - Returns: The original view with the possibility to perform tasks upon position update.
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay{
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    
                    Color.clear
                        .preference(key: PositionKey.self, value: rect)
                        .onPreferenceChange(PositionKey.self, perform: completion)
                }
            }
    }
}
