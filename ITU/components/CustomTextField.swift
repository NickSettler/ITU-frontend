//
//  CustomTextField.swift
//  ITU
//
//  Created by Elena Marochkina
//

import SwiftUI

/// TextFieldType represents different types of text fields.
enum TextFieldType: String {
    case email, text, first_name, last_name
}

/// CustomTextField is a custom text field SwiftUI component.
struct CustomTextField: View {
    // SystemName of SF Icon to display.
    var sfIcon: String?
    // Tint color of the icon.
    var iconTint: Color = .gray
    // A placeholder string to show when the text field is empty.
    var hint: String
    // The type of the TextField.
    var type: TextFieldType = .text
    // Hides the TextField when true.
    var isPassword: Bool = false

    // The entered text in the TextField.
    @Binding var value: String

    // To control the visibility of the password.
    @State private var showPassword: Bool = false

    /// When Switching Between Hide/Reveal Password Field, The Keyboard is Closing, to avoid that using the FocusState
    @FocusState private var passwordState: HideState?
    
    enum HideState {
        case hide
        case reveal
    }
    
    /// Body of CustomTextField.
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            if (sfIcon != nil) {
                Image(systemName: sfIcon!)
                    .foregroundStyle(iconTint)
                    .frame(width: 30)
                    .offset(y: 2)
            }
            
            VStack(alignment: .leading, spacing: 8, content: {
                if isPassword {
                    Group {
                        /// Revealing Password when users wants to show Password
                        if showPassword {
                            TextField(hint, text: $value)
                                .focused($passwordState, equals: .reveal)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .textContentType(.password)
                                .keyboardType(.default)
                        } else {
                            SecureField(hint, text: $value)
                                .focused($passwordState, equals: .hide)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .textContentType(.password)
                                .keyboardType(.default)
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

// Preview shows an email TextField and a password TextField.
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
