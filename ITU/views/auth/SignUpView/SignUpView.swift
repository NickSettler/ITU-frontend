//
//  SignUpView.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// `SignUpView` is a view for handling user registration process.
struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    /// Binding to control the visibility of the SignUpView
    @Binding var showSignup: Bool
    
    /// Body of `SignUpView`.
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            /// Back Button
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
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
                
                CustomTextField(
                    sfIcon: "person",
                    hint: "First Name",
                    type: .first_name,
                    value: $viewModel.firstName
                )
                .padding(.top, 5)
                
                CustomTextField(
                    sfIcon: "person.2",
                    hint: "Last Name",
                    type: .first_name,
                    value: $viewModel.lastName
                )
                .padding(.top, 5)
                
                Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
                    .font(.caption)
                    .tint(.accentColor)
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                
                /// SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right") {
                    viewModel.signUp()
                }
                .hSpacing(.trailing)
                .disableWithOpacity(viewModel.isRegisterButtonDisabled)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button("Login") {
                    showSignup = false
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

// Represents `SignUpView`.
#Preview {
    SignUpView(showSignup: .constant(false))
}
