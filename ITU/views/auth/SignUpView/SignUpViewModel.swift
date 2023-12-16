//
//  SignUpViewModel.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation
import SwiftUI

/// `SignUpViewModel` is a class designed to manage and publish the signup process.
@MainActor class SignUpViewModel : ObservableObject {

    /// User's tokens
    @AppStorage(E_AUTH_STORAGE_KEYS.ACCESS_TOKEN.rawValue) var access_token: String?
    @AppStorage(E_AUTH_STORAGE_KEYS.REFRESH_TOKEN.rawValue) var refresh_token: String?
    
    /// User's personal information
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var lastName: String = ""
    @Published var firstName: String = ""
    
    /// Observable boolean value to manage loading state of sign up
    @Published var isLoading: Bool = false
    
    /// Computed property to check if register button should be disabled
    var isRegisterButtonDisabled: Bool {
        get {
            return self.email.isEmpty ||
            self.firstName.isEmpty ||
            self.lastName.isEmpty ||
            self.password.isEmpty ||
            self.isLoading
        }
    }
    
    /// Function to handle user signup
    func signUp() {
        Task {
            self.isLoading = true
            
            if let res = await AuthService.signUp(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName
            ) {
                await MainActor.run {
                    self.access_token = res.data.access_token
                    self.refresh_token = res.data.refresh_token
                }
                
                self.isLoading = false
            } else {
                print("Error during registration")
                
                self.isLoading = false
            }
        }
    }
}
