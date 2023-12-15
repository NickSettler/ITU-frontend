//
//  View.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// Custom SwiftUI View Extensions
extension View {
    /// View Alignments
    /// - Parameter alignment: Alignment
    /// - Returns: Transformed view
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    /// View Alignments
    /// - Parameter alignment: Alignment
    /// - Returns: Transformed view
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    /// Disable With Opacity
    /// - Parameter condition: Condition
    /// - Returns: Transformed view
    @ViewBuilder
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }

    /// If
    /// - Parameters:
    ///   - condition: Condition
    ///   - transform: Transform
    /// - Returns: Transformed view
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
