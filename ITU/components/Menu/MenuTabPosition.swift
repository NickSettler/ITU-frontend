//
//  MenuTabPosition.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// Preference key for menu tab position
struct PositionKey : PreferenceKey {
    static var defaultValue: CGRect = .zero

    /// Reduce function
    /// - Parameters:
    ///   - value: Current value
    ///   - nextValue: Next value
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

/// View extension for menu tab position
extension View {
    /// View position
    ///
    /// Update view position with completion handler. Returns view
    ///
    /// - Parameter completion: Completion handler
    /// - Returns: View
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
