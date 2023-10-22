//
//  AuthView.swift
//  ITU
//
//  Created by Никита Моисеев on 22.10.2023.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    
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
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: viewModel.showSignup)
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: viewModel.isKeyboardShowing)
            } else {
                CircleView()
                    .animation(.easeInOut(duration: 0.3), value: viewModel.showSignup)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isKeyboardShowing)
            }
        }
    }
    
    /// Moving Blurred background
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
            /// Moving When the Signup Pages Loads/Dismisses
            .offset(x: viewModel.showSignup ? 90 : -90, y: -90 - (viewModel.isKeyboardShowing ? 200 : 0))
            .blur(radius: 15)
            .hSpacing(viewModel.showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    AuthView()
}
