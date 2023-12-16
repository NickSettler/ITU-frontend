//
//  View.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// Custom SwiftUI View Extensions to add more functionality to SwiftUI's View.
extension View {

	/// View Alignments
	/// - Parameter alignment: Alignment
	/// - Returns: Transformed view with horizontal spacing set to fill available space
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
	/// View Alignments
	/// - Parameter alignment: Alignment
	/// - Returns: Transformed view with vertical spacing set to fill available space
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
	/// Modify opacity and interaction of the view
	/// - Parameter condition: Condition to check whether to modify the view or not
	/// - Returns: Transformed view with modified opacity and interactivity
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.5 : 1)
    }

    @ViewBuilder
	/// Modify the view if condition is met
	/// - Parameters:
	///   - condition: Condition to check whether to modify the view or not
	///   - transform: Closure containing modification of the view
	/// - Returns: Transformed view based on condition
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
