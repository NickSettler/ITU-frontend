//
//  CustomTextField.swift
//  ITU
//
//  Created by Никита Моисеев on 22.10.2023.
//

import SwiftUI

enum TextFieldType: String {
    case email, text, first_name, last_name
}

struct CustomTextField: View {
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    var type: TextFieldType = .text
    /// Hides TextField
    var isPassword: Bool = false
    @Binding var value: String
    /// View Properties
    @State private var showPassword: Bool = false
    /// When Switching Between Hide/Reveal Password Field, The Keyboard is Closing, to avoid that using the FocusState
    @FocusState private var passwordState: HideState?
    
    enum HideState {
        case hide
        case reveal
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
            /// Since I Need Same Width to Align TextFields Equally
                .frame(width: 30)
            /// Slightly Bringing Down
                .offset(y: 2)
            
            VStack(alignment: .leading, spacing: 8, content: {
                if isPassword {
                    Group {
                        /// Revealing Password when users wants to show Password
                        if showPassword {
                            TextField(hint, text: $value)
                                .focused($passwordState, equals: .reveal)
                        } else {
                            SecureField(hint, text: $value)
                                .focused($passwordState, equals: .hide)
                        }
                    }
                } else {
                    switch (type) {
                    case .text:
                        TextField(hint, text: $value)
                    case .email:
                        TextField(hint, text: $value)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                    case .first_name:
                        TextField(hint, text: $value)
                            .textInputAutocapitalization(.words)
                            .textContentType(.givenName)
                    case .last_name:
                        TextField(hint, text: $value)
                            .textInputAutocapitalization(.words)
                            .textContentType(.familyName)
                    }
                }
                
                Divider()
            })
            .overlay(alignment: .trailing) {
                /// Password Reveal Button
                if isPassword {
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                        passwordState = showPassword ? .reveal : .hide
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
        })
    }
}

#Preview {
    VStack(spacing: 25) {
        CustomTextField(
            sfIcon: "at",
            hint: "Email ID",
            type: .email,
            value: .constant("Email")
        )
        
        CustomTextField(
            sfIcon: "lock",
            hint: "Password",
            isPassword: true,
            value: .constant("Pass")
        )
        .padding(.top, 5)
    }
    .padding()
}
