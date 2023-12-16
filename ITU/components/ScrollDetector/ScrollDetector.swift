//
//  ScrollDetector.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// `ScrollDetector` is a struct to bridge SwiftUI's ScrollView
/// with UIScrollView in order to monitor the scroll offset and velocity.
struct ScrollDetector: UIViewRepresentable {
    // Closure to be called when scrolling event occurrs.
    var onScroll: (CGFloat) -> ()
    /// Closure to be called when scroll view dragging ends.
    /// Parameter 1: offset of the content.
    /// Parameter 2: velocity of the scroll.
    var onDraggingEnd: (CGFloat, CGFloat) -> ()

    /// Creating coordinator to control UIScrollViewDelegate methods.
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    /// Creating UIView.
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }

    /// Updating UIView.
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            /// Adding Delegate for only one time
            if let scrollview = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isDelegateAdded {
                /// Adding Delegate
                scrollview.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    /// UIScrollViewDelegate methods implementation
    class Coordinator: NSObject, UIScrollViewDelegate {
        // The reference to 'ScrollDetector' to allow updating the state.
        var parent: ScrollDetector

        init(parent: ScrollDetector) {
            self.parent = parent
        }
        
        /// Bool to check if Delegate is added to UIScrollView
        var isDelegateAdded: Bool = false

        /// Method to capture the current offset of the scrollview
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.onScroll(scrollView.contentOffset.y)
        }
        
        ///Method to capture the end dragging event of the scrollview.
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y, velocity.y)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView.panGestureRecognizer.view)
            parent.onDraggingEnd(scrollView.contentOffset.y, velocity.y)
        }
    }
}
