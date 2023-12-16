//
//  LoginView.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// `LoginView` is a view for handling user login.
struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    /// A binding for showing SignUp view.
    @Binding var showSignup: Bool

    /// A state for showing Forgot Password view.
    @State private var showForgotPasswordView: Bool = false

    /// Reset Password View (with New Password and Confimration Password View)
    @State private var showResetView: Bool = false
    
    /// Body of `LoginView`.
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Spacer(minLength: 0)
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                /// Custom Text Fields
                CustomTextField(
                    sfIcon: "at",
                    hint: "Email ID",
                    type: .email,
                    value: $viewModel.email
                )
                
                CustomTextField(
                    sfIcon: "lock",
                    hint: "Password",
                    isPassword: true,
                    value: $viewModel.password
                )
                .padding(.top, 5)
                
                Button("Forgot Password?") {
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.accentColor)
                .hSpacing(.trailing)
                
                /// Login Button
                GradientButton(title: "Login", icon: "arrow.right") {
                    viewModel.signIn()
                }
                .hSpacing(.trailing)
                /// Disabling Until the Data is Entered
                .disableWithOpacity(
                    viewModel.email.isEmpty ||
                    viewModel.password.isEmpty
                )
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("SignUp") {
                    showSignup.toggle()
                }
                .fontWeight(.bold)
                .tint(.accentColor)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
    }
}

    // Represents `LoginView`.
#Preview {
    LoginView(showSignup: .constant(false))
}
