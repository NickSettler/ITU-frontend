//
//  AuthView.swift
//  ITU
//
//  Created by Nikita Moiseev
//

import SwiftUI

/// `AuthView` is the main authentication view, which includes `LoginView` and `SignUpView`.
struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    /// Body of `AuthView`.
    var body: some View {
        NavigationStack {
            LoginView(showSignup: $viewModel.showSignup)
                .navigationDestination(isPresented: $viewModel.showSignup) {
                    SignUpView(showSignup: $viewModel.showSignup)
                }
            /// Checking if any Keyboard is Visible
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification), perform: { _ in
                    /// Disabling it for signup view
                    if !viewModel.showSignup {
                        viewModel.isKeyboardShowing = true
                    }
                })
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification), perform: { _ in
                    viewModel.isKeyboardShowing = false
                })
        }
        .overlay {
            /// iOS 17 Bounce Animations
            if #available(iOS 17, *) {
                /// Since this Project Supports iOS 16 too.
                CircleView()
                    .animation(
                        .smooth(duration: 0.45, extraBounce: 0),
                        value: viewModel.showSignup
                    )
                    .animation(
                        .smooth(duration: 0.45, extraBounce: 0),
                        value: viewModel.isKeyboardShowing
                    )
            } else {
                CircleView()
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: viewModel.showSignup
                    )
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: viewModel.isKeyboardShowing
                    )
            }
        }
    }
    
    /// Moving blurry background circle.
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(
                .linearGradient(
                    colors: [.accentColor, .orange, .red],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 200, height: 200)
            .offset(
                x: viewModel.showSignup ? 90 : -90,
                y: -90 - (viewModel.isKeyboardShowing ? 200 : 0)
            )
            .blur(radius: 15)
            .hSpacing(viewModel.showSignup ? .trailing : .leading)
            .vSpacing(.top)
            .opacity(viewModel.accessToken == nil ? 1 : 0)
    }
}

#Preview {
    // Represents `AuthView`.
    AuthView()
}
