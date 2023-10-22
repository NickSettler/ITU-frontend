//
//  SignUpView.swift
//  ITU
//
//  Created by Никита Моисеев on 22.10.2023.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showSignup: Bool
    /// View Properties
    @State private var emailID: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""

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
                /// Custom Text Fields
                CustomTextField(sfIcon: "at", hint: "Email ID", value: $emailID)
                
                CustomTextField(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 5)
                
                CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
                    .font(.caption)
                    .tint(.accentColor)
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                
                /// SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right") {
                    /// YOUR CODE
                }
                .hSpacing(.trailing)
                /// Disabling Until the Data is Entered
                .disableWithOpacity(emailID.isEmpty || password.isEmpty || fullName.isEmpty)
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

#Preview {
    SignUpView(showSignup: .constant(false))
}
